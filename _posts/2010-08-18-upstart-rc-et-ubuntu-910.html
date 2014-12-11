---
title: "Upstart, rc et Ubuntu 9.10"
layout: "post"
permalink: "/2010/08/upstart-rc-et-ubuntu-910.html"
uuid: "8297468859675528727"
guid: "tag:blogger.com,1999:blog-5365176712784435549.post-8297468859675528727"
date: "2010-08-18 15:21:00"
updated: "2010-08-18 15:21:05"
description: 
blogger:
    siteid: "5365176712784435549"
    postid: "8297468859675528727"
    comments: "0"
categories: [ubuntu, français]
author: 
    name: "Oct"
    url: "http://www.blogger.com/profile/10969884152933508554?rel=author"
    image: "http://img2.blogblog.com/img/b16-rounded.gif"
---

{% raw %}
<div class="css-full-post-content js-full-post-content">
Comme vous le savez peut-être, la dernière version d'Ubuntu intègre un<br />
système révolutionnaire de boot parallèle pour remplacer les vieux<br />
scripts rc.* qui existent sur nos vénérés serveurs depuis bien<br />
longtemps. Sur le papier les avantages d'Upstart (ca s'appelle comme<br />
ça) par rapport à rc.* sont multiples:<br />
- démarrage/arrêt des démons conditionnés à des évènements (réseau-up,<br />
démon foo-démarré, ...)<br />
- parallélisme du démarrage des démons  (lié au premier point)<br />
- monitoring des démons et respawn lorsqu'ils meurent<br />
- pre/post-scripts facile à rajouter<br />
- configuration aisée<br />
<br />
Bref, ça à l'air cool. J'y reviendrais à la fin.<br />
<br />
Tout a commencé quand lors du reboot d'une machine dev' à Fotopedia,<br />
je constate qu'un démon (un mongodb) a été killé -9 au lieu d'être<br />
arrêté normalement. Ce démon était géré par "runit", un autre système<br />
de gestion de services qu'on utilise à Fotopédia depuis longtemps pour<br />
pallier les faiblesses des scripts rc* (en particulier, écrire les<br />
scripts pour init.d pour des démons qui ne forkent pas est un<br />
délicieux cauchemar que je laisse à l'exercice du lecteur). Bref, on<br />
utilisait runit, qui est super simple à configurer : un script dans<br />
/etc/sv/mondémon/run un lien depuis /etc/service vers ce folder, on<br />
attends 5 secondes et le démon démarre le système.<br />
<br />
Voyant que mon mongodb est KILL -9, j'enquête, je fais des expériences<br />
et je m'aperçois que visiblement, runit est aussi KILL -9 par le<br />
système lors du shutdown pour une raison que j'ignore (oui, le démon<br />
runit n'est pas très bavard sur ses conditions de vie et de mort). Ca<br />
craint, surtout que mon mongo pourrait rester dans un état<br />
inconsistent si on le tue trop violemment. En plus, il pose un lock<br />
sur le fs et refuse de démarrer s'il est encore là plus tard (donc en<br />
particulier si on le KILL -9).<br />
<br />
En ne cherchant pas les origines de la mort violent de runit lors du<br />
shutdown, je commets ma première erreur.<br />
<br />
J'examine les alternatives, et je finis par me dire (et là, je commets<br />
ma deuxième erreur, liée à la première): Puisque c'est Upstart qui<br />
fait tourner runit sur mon Ubuntu (là pour le coup, je pense que c'est<br />
les packages de la distro qui font ca), et que j'utilise runit pour<br />
lancer mon mongodb, je vais faire tourner mon mongodb directement dans<br />
Runit. Comme dirait mon grand père, moins y a de code, moins y a de<br />
bug.<br />
<br />
Aussitôt dit, aussitôt fait, je réécris un partie des règles Chef pour<br />
migrer d'un système à l'autre, je migre les 12 mongos qu'on a en<br />
testing, je teste, ça marche (enfin, les démons tournent dans Upstart<br />
sans trop de complication, mettent leurs logs au bon endroit et<br />
logrotatent correctement).<br />
<br />
Fièrement, je reboote ma machine et au boot d'après, je m'aperçois que<br />
les mongodb ont été KILLés -9 lors du shutdown, encore une fois. Bref,<br />
quelque chose se moque de moi.<br />
<br />
Je rajoute du log dans mongodb, je recommence et je m'aperçois, vu les<br />
logs, que mongo s'arrête bien avant le reboot mais redémarre quasi<br />
aussitôt sans jamais finir sa séquence de démarrage (et tout ca AVANT<br />
que la machine ne reboote). Au boot d'après, le mongodb qui a été<br />
interrompu violemment (puisque les logs le sont aussi) a posé son lock<br />
et mon nouveau démon refuse de démarrer. Damned.<br />
<br />
Je me met donc à rajouter des informations de débug dans les post et<br />
les pré-scripts Upstart de mon démon pour voir par exemple ce qui est<br />
en train de se passer sur la machine lors du deuxième démarrage avant<br />
le reboot. Je m'aperçois avec horreur que le deuxième démarrage du<br />
Mongo a lieu en plein runlevel 6, alors que la machine est en plein<br />
shutdown et donc, normalement, que personne ne se lance.<br />
<br />
Je finis par tomber sur la directive _respawn_ que j'avais incluse<br />
dans les scripts Upstart pour mongo. Le doute jaillit dans mon esprit;<br />
je la commente, je teste. Tout marche bien. L'explication:<br />
<br />
Sur Ubuntu 9.10, la gestion des runlevels et confiée à "rc" qui est un<br />
des démons gérés par Upstart. Lorsque la machine entre en runlevel 6,<br />
elle essaye de tuer tous les process avec un kill classique, celui-ci<br />
réussit. Cependant, Upstart s'aperçoit que mon mongodb vient d'être<br />
terminé et le relance aussitôt. Quelques instants plus tard le<br />
runlevel 6 envoie un KILL -9 aux démons qui n'ont pas voulu s'arrêter;<br />
tuant violemment le Mongo (et tout les démons qui sont en respawn dans<br />
Upstart).<br />
<br />
Morale numéro 1: j'ai remplacé _respawn_ de Upstart par un monit qui<br />
fait pareil mais à côté. Comme monit est lancé par rc, lorsque la<br />
machine se shutdowne les démons s'arrêtent correctement.<br />
<br />
Morale numéro 2: J'ai fini par modifier la conf Upstart de Runit qui<br />
précisait elle aussi _respawn_, ce paramètre expliquait que runit ne<br />
terminait par correctement et que mes mongodbs étaient aussi tués<br />
violemment. En enlevant le respawn de runit, rc 6 peut tuer runit<br />
correctement, celui-ci peut donc tuer ses démons enfants correctement<br />
et mes mongos sont proprement shutdownés. On peut donc bien utiliser<br />
runit (qui est quand même un poil plus confort que upstart à gérer).<br />
Evidemment, une fois qu'on réalise ça, il faut rollbacker TOUTE la<br />
configuration de startup et de monitoring de mes mongos et remigrer<br />
mes 12 mongos sur mon environnement de test. Ca n'a pris que 30<br />
minutes avec Chef.<br />
<br />
Morale numéro 3: On dirait bien que l'intégration d'Upstart dans 9.10<br />
n'est pas complètement finie. Je ne dirais pas pourrie parce que si<br />
j'avais fait attention, j'aurai pas perdu 2 jours, mais bon. Quand<br />
même.<br />
<br />
<br />
Au final, même si c'est relativement prometteur comme système, le fait<br />
que Canonical ait sortie la 9.10 pas complètement intégrée dans<br />
upstart est manifestement un énorme problème.
</div>
{% endraw %}