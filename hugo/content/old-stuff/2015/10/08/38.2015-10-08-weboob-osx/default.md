---
title: 'Catchup TV sous OSX (ou comment faire du replay facile)'
type: blog
date: '2015-10-08'
layout: post
tags:
    - python
    - code
taxonomy:
    tag: [backup]
lang: fr
---

# Le Catchup, c'est chouette

*Cet article explique comment installer facilement Weboob sur OSX et s'en servir pour télécharger vos émissions préférées en différé.*

La télé publique contient parfois des émissions intéressantes. Pas plus tard qu'hier matin, je m'aperçois que ce documentaire sur cette banque est passé sur France 3 et que je l'ai raté. J'aimerai bien le revoir, voir même avoir l'enregistrement de l'émission sous le coude. Pour la montrer à mes amis ou la regarder dans le train.

Malheureusement, les sites de catchup français imposent bien souvent d'être connecté à internet, de se taper des publicités avant les émissions qui nous intéressent et d'autres limitations assez insupportables. Pourtant, la fonctionnalité de "magnétoscope" qui permet de faire une copie à usage privé nous intéresserait bien, mais visiblemenent, ca excite moins les ayant-droits (au cas où par exemple, on irait se faire de l'argent sur leur dos, ou même pire, dire du bien de leur production et diffuser la culture, mébon).

[Weboob](http://weboob.org/) est un projet libre, dont le but est de permettre aux utilisateurs d'internet de s'affranchir de l'interface graphique des sites internets pour en extraire la substantifique moëlle structurée. Adieu les cookies à accepter, les pubs à se taper, les claviers virtuels à cliquer ! Weboob essaye via l'intermédiaire d'une liste de plugins de vous faciliter la vie, le tout dans une interface en mode texte relativement utilisable.

La doc officielle de weboob ne dit pas vraiment comment installer ces outils sous OSX et donc, voici la notice.

## Pré-requis

Un mac, Xcode installé quelque part et 5 minutes.

Installez les outils xcode (nécessaire pour avoir zlib dans les parages)

```
xcode-select --install
```

Récupérez les sources de dev de Weboob

```
git clone git://git.symlink.me/pub/weboob/devel.git
```

Installer virtualenv (normalement, juste) `brew install virtualenv` mais ça peut être plus compliqué, donc je vous colle ce petit lien qui a servi
à Bernardo pour se déplanter (merci à lui): 

[http://hackercodex.com/guide/python-development-environment-on-mac-osx/#virtualenv](http://hackercodex.com/guide/python-development-environment-on-mac-osx/#virtualenv)

Puis créez un environnement virtualenv par là :

```
cd devel
virtualenv venv
```

Activez le et installez weboob :

```
source venv/bin/activate
python setup.py install
```

Un fois tout installé, vous pouvez lancer videoob par exemple :

```
videoob
(venv)14:24:58 Tirlipinpon:~/src/devel > videoob
Welcome to videoob v1.1

Copyright(C) 2010-2015 Christophe Benz, Romain Bignon, John Obbele
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Type "help" to display available commands.

Loaded backends: allocine, arretsurimages, arte, canalplus, cappedtv, dailymotion, europarl, francetelevisions, gdcvault, ina, jacquieetmichel, nolifetv, quvi, rmll, trictractv, vimeo, vine, youjizz, youporn, youtube

videoob>
```

Les commandes `search` et `download` devraient vous aider à démarrer. Y a plus qu'a profiter ! Enjoy ☺

