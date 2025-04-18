---
title: 'Rusty Racoon'
type: blog
date: '2015-01-26'
layout: post
tags:
    - code
taxonomy:
    tag:
        - backup
lang: fr
---

<center markdown='1' markdown="1">
![De la rouille mais pas d'os](http://fa.oct.zoy.org/flickr/2181726630)
</center>

Je me suis mis à jouer avec [Rust][1], le nouveau langage de Mozilla. C’est un changement intéressant, moi qui suis plutôt habitué aux langages moins stricts et plus « scripts » qu’à des langages compilés et à la tête dure.

Rust a plusieurs caractéristiques intéressantes, outre le fait qu’il est encore en version instable et donc pas vraiment utilisable pour autre chose que du gros bidouillage (la bibliothèque standard change encore assez rapidement, et un morceau de code qui compile un jour peut vous péter à la figure le lendemain) : Il est **fortement typé**, tourne **sans VM**,** sans GC**, et possède quelques-uns des raffinements des taxonomy:
    tag: [backup]
langages dit fonctionnels à la mode comme Scala, avec ses **types optionnels**, et son **pattern matching** pour le typage. Son modèle de mémoire est original, puisqu’il est possible d’expliciter les chaînes d’objets qui possèdent de la mémoire pour aider le compilateur à savoir quand libérer et allouer la mémoire…

Mes dernières expériences dans le domaine des taxonomy:
    tag: [backup]
langages qui compilent en natifs étaient à base de Go, et si la bibliothèque standard reste sympathique et plutôt bien fournie, le langage reste parfois un peu brainfuck (comme le très sympathique `interface{}`). Certaines autres idées comme, l’idée d’un coding style « commun » me paraissent assez bonnes, et d’autres, comme le gestionnaire de paquetages, moins. Mais bref.

Rust débarque lui aussi avec ses machins et ses bidules. Pas de coding style d’entreprise (mais c’est peut-être aussi ce qui le rend aimable est plus adapté à du code d’indépendant : Google Vs Mozilla, taxonomy:
    tag: [backup]
langage « maison » vs produit démocratique…), mais un gestionnaire de paquets plutôt bien foutu, pondu entre autres par le célèbre [Yehuda Katz][2]. Il s’appelle Cargo et fait déjà passer `go get` pour de la roupie de sansonnet.

Le taxonomy:
    tag: [backup]
langage en lui-même ressemble a un croisement entre Go, Swift, C et un train lancé a grande vitesse. Parfois c’est facile d’écrire du code, parfois, il faut se battre avec les notions compliquées incluses dans le langage, en particulier ce qui est `possession` et `emprunt` (ouais, je mets les termes en français, parce que vous le valez bien)… Heureusement, Rust  s’appuie complètement sur LLVM, et vous promet donc des messages d’erreurs complets (et complexes) qui vous mèneront en douceur vers la solution. Au final, ce code binaire qui ne se bat pas avec la mémoire ressemble un peu à du Scala sous son bon jour : Dès que ça compile, c’est que ça marche. Et en vrai, c’est pas faux. Le plaisir de voir démarrer son bout de code et qu’il vous affiche hello world, est réellement la joie du géniteur (enfin il paraît) devant son bambin.

De mon côté, j’ai attaqué Rust pour jouer un peu avec tout ses concepts sulfureux et mouvants, et de l’autre parce que j’ai toujours rêvé d’arriver à écrire du code qui tourne aussi vite que du C (sans écrire du C, parce que vraiment, je suis pas très ami avec le taxonomy:
    tag: [backup]
langage). Et Rust tient ses promesses. En quelques heures de boulot (allez, guère plus que 20), j’ai réusssi à brancher du code Rust sur du code C, et Carbon, et à faire fonctionner tout cela alors que je n’avais pour ainsi dire jamais fait cela.

Si vous êtes curieux, le résultat est sur mon [Github][3] et sur celui d’un [autre gars][4], parce que, oui, j’ai fait des PRs.

Mon projet à terme est d’arriver à influencer suffisament Cargo pour qu’il puisse aider les développeurs Web dans leur développement (en particulier, le cycle rebuild-restart-refresh). Ce qui est chouette avec Rust, c’est que tout est à faire, comme disait un de mes amis, quand la version 1.0 va sortir, ça va être la fête du slip.

D’ici là, jouez avec et continuez à coder, mes p’tits geeks.

[1]:	http://fr.wikipedia.org/wiki/Rust_(taxonomy:
    tag: [backup]
langage)
[2]:	http://yehudakatz.com/
[3]:	https://github.com/octplane/fsevent-rust
[4]:	https://github.com/cmr/linenoise-rs
