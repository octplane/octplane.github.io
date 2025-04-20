---
title: 'Démarrer Node.js en 8 secondes'
type: blog
type: blog
date: '2014-03-07'
layout: post
moot_legacy_id: 8
cover_image: 'http://nodejs.org/images/logos/nodejs-1280x1024.png'
cover_credit: 'Node js project'
tags:
    - code
taxonomy:
    tag: [backup]
lang: fr
---

Ce tutoriel est inspiré des aventures de Bernardo, mon chef bien aimé, au pays de Node.js. Il est destiné à vous expliquer comment démarrer du développement en node.js le plus rapidement possible.

Dans cet article, je vous explique comment tester rapidement du code javascript dans node.js sans aucune connaissance préalable de ce monde farfelu et curieux qu'est node.js. Les pré-requis sont **un cerveau**, **un ordinateur**, **une connexion internet** et une tout petite connaissance de **javascript**.

#### Installation
Installez node.js sur votre ordinateur (oui, j'suis comme ça, je dis encore ordinateur et pas machine) : Allez sur la page de [téléchargement de node.js][1] et téléchargez la version adaptée à votre système d'exploitation.

A la fin de l'installation, vous devez pouvoir lancer ce genre de commande en console :

	#node -e "console.log('pouet');"
	pouet
	#


#### Programmation

Editez un fichier qui s'appelle `prems.js` et mettez dedans, par exemple :

	console.log('Salut le monde !');

#### Execution

C'est prêt :

	# node prems.js
	Salut le monde !
	#
#### Extension

Maintenant, vous êtes prêt à développer du javascript à vous en faire péter la sous-ventrière ! Si jamais vous voulez installer des paquets pour les utiliser dans votre programme, vous pouvez invoquer `npm`, et lui faire installer des paquets globalement :

*(par exemple)*

	npm install -g underscore

Et ensuite dans votre petit script :

	var _ = require("underscore");

plus tard du code qui utilise :

	_.map(arr, function(it) {....

	...

#### Conclusion

Et c'est tout, maintenant, vous êtes assez fort pour commencer à développer du node.js. Evidemment, si vous aimeriez faire ca plus proprement, je vous encourage à aller lire des tutoriels sur **npm** et son format de paquet qui permet l'installation locale de paquets pour votre application, ainsi que les système de gestion de tâches tels que **Grunt** qui vous permettront de préparer votre application ou bibliothèque à un entrée fracassante dans le monde node.js.

Codez bien !

[1]:	http://nodejs.org/download/
