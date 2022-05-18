---
title: 'Upstart, rc et Ubuntu 9.10'
date: '2010-08-18 15:21'
layout: post
permalink: /2010/08/upstart-rc-et-ubuntu-910.html
uuid: '8297468859675528727'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-8297468859675528727'
updated: '2010-08-18 15:21:05'
blogger:
    siteid: '5365176712784435549'
    postid: '8297468859675528727'
    comments: '0'
categories:
    - ubuntu
    - français
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

Comme vous le savez peut-être, la dernière version d'Ubuntu intègre un système révolutionnaire de boot parallèle pour remplacer les vieux scripts rc.* qui existent sur nos vénérés serveurs depuis bien longtemps. Sur le papier les avantages d'Upstart (ca s'appelle comme ça) par rapport à rc.* sont multiples:

- démarrage/arrêt des démons conditionnés à des évènements (réseau-up,démon foo-démarré, ...)
- parallélisme du démarrage des démons  (lié au premier point)
- monitoring des démons et respawn lorsqu'ils meurent
- pre/post-scripts facile à rajouter
- configuration aisée

Bref, ça à l'air cool. J'y reviendrais à la fin.

Tout a commencé quand lors du reboot d'une machine dev' à Fotopedia, je constate qu'un démon (un mongodb) a été killé -9 au lieu d'être arrêté normalement. Ce démon était géré par "runit", un autre système de gestion de services qu'on utilise à Fotopédia depuis longtemps pour pallier les faiblesses des scripts rc* (en particulier, écrire les scripts pour init.d pour des démons qui ne forkent pas est un délicieux cauchemar que je laisse à l'exercice du lecteur). Bref, on utilisait runit, qui est super simple à configurer : un script dans /etc/sv/mondémon/run un lien depuis /etc/service vers ce folder, on attends 5 secondes et le démon démarre le système.

Voyant que mon mongodb est KILL -9, j'enquête, je fais des expériences et je m'aperçois que visiblement, runit est aussi KILL -9 par le système lors du shutdown pour une raison que j'ignore (oui, le démon runit n'est pas très bavard sur ses conditions de vie et de mort).

Ca craint, surtout que mon mongo pourrait rester dans un état inconsistent si on le tue trop violemment. En plus, il pose un lock sur le fs et refuse de démarrer s'il est encore là plus tard (donc en particulier si on le KILL -9).

En ne cherchant pas les origines de la mort violent de runit lors du<br />
shutdown, je commets ma première erreur.

J'examine les alternatives, et je finis par me dire (et là, je commets ma deuxième erreur, liée à la première): Puisque c'est Upstart qui fait tourner runit sur mon Ubuntu (là pour le coup, je pense que c'est les packages de la distro qui font ca), et que j'utilise runit pour lancer mon mongodb, je vais faire tourner mon mongodb directement dans Runit. Comme dirait mon grand père, moins y a de code, moins y a de bug.


Aussitôt dit, aussitôt fait, je réécris un partie des règles Chef pour migrer d'un système à l'autre, je migre les 12 mongos qu'on a en testing, je teste, ça marche (enfin, les démons tournent dans Upstart sans trop de complication, mettent leurs logs au bon endroit et logrotatent correctement).


Fièrement, je reboote ma machine et au boot d'après, je m'aperçois que les mongodb ont été KILLés -9 lors du shutdown, encore une fois. Bref, quelque chose se moque de moi.


Je rajoute du log dans mongodb, je recommence et je m'aperçois, vu les logs, que mongo s'arrête bien avant le reboot mais redémarre quasi aussitôt sans jamais finir sa séquence de démarrage (et tout ca AVANT que la machine ne reboote). Au boot d'après, le mongodb qui a été interrompu violemment (puisque les logs le sont aussi) a posé son lock et mon nouveau démon refuse de démarrer. Damned.

Je me met donc à rajouter des informations de débug dans les post et les pré-scripts Upstart de mon démon pour voir par exemple ce qui est en train de se passer sur la machine lors du deuxième démarrage avant le reboot. Je m'aperçois avec horreur que le deuxième démarrage du<br Mongo a lieu en plein runlevel 6, alors que la machine est en plein shutdown et donc, normalement, que personne ne se lance.

Je finis par tomber sur la directive _respawn_ que j'avais incluse dans les scripts Upstart pour mongo. Le doute jaillit dans mon esprit; je la commente, je teste. Tout marche bien. L'explication:

Sur Ubuntu 9.10, la gestion des runlevels et confiée à "rc" qui est un des démons gérés par Upstart. Lorsque la machine entre en runlevel 6, elle essaye de tuer tous les process avec un kill classique, celui-ci réussit. Cependant, Upstart s'aperçoit que mon mongodb vient d'être terminé et le relance aussitôt. Quelques instants plus tard le runlevel 6 envoie un KILL -9 aux démons qui n'ont pas voulu s'arrêter; tuant violemment le Mongo (et tout les démons qui sont en respawn dans Upstart).

Morale numéro 1: j'ai remplacé _respawn_ de Upstart par un monit qui fait pareil mais à côté. Comme monit est lancé par rc, lorsque la machine se shutdowne les démons s'arrêtent correctement.

Morale numéro 2: J'ai fini par modifier la conf Upstart de Runit qui précisait elle aussi _respawn_, ce paramètre expliquait que runit ne terminait par correctement et que mes mongodbs étaient aussi tués violemment. En enlevant le respawn de runit, rc 6 peut tuer runit correctement, celui-ci peut donc tuer ses démons enfants correctement et mes mongos sont proprement shutdownés. On peut donc bien utiliser runit (qui est quand même un poil plus confort que upstart à gérer).

Evidemment, une fois qu'on réalise ça, il faut rollbacker TOUTE la configuration de startup et de monitoring de mes mongos et remigrer mes 12 mongos sur mon environnement de test. Ca n'a pris que 30 minutes avec Chef.

Morale numéro 3: On dirait bien que l'intégration d'Upstart dans 9.10 n'est pas complètement finie. Je ne dirais pas pourrie parce que si j'avais fait attention, j'aurai pas perdu 2 jours, mais bon. Quand même.

Au final, même si c'est relativement prometteur comme système, le fait que Canonical ait sortie la 9.10 pas complètement intégrée dans upstart est manifestement un énorme problème.
