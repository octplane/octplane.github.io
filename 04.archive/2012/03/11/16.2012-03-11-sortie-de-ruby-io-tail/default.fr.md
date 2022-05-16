---
title: 'Sortie de ruby io tail'
date: '2012-03-11 11:19'
layout: post
permalink: /2012/03/sortie-de-ruby-io-tail.html
uuid: '1160669586505724972'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-1160669586505724972'
updated: '2012-03-11 11:19:36'
blogger:
    siteid: '5365176712784435549'
    postid: '1160669586505724972'
    comments: '0'
categories:
    - ruby
    - library
    - devel
    - français
taxonomy:
    tag: [backup]
lang: fr
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

Ruby-io-tail est une bibliothèque qui vous permet de lire automatiquement la fin d'un fichier de journal ou la sortie d'un processus, depuis Ruby en utilisant des blocks comme Ruby peut en proposer. Le code est libéré sous license GPL et la documentation en anglais est également disponible.

Parmi les fonctionnalités disponibles, vous pouvez créer un groupe d'IO à suivre et appeler un seul point d'entrée qui vous rappelle à chaque nouvelle ligne à lire dans un des ces IOs. De plus, en cas de fermeture abrupte d'un fichier, ou si le processus meurt, vous avez la possibilité de réouvrir automatiquement le fichier ou de relancer automatique le fichier.<br />
<br />
Ce project est un fork amical de Florian Frank ( l'auteur de <a href="https://github.com/flori/file-tail">https://github.com/flori/file-tail</a>) auquel j'ai rajouté la possibilité de suivre la sortie d'un processus extérieur.<br />
<br />
Pour plus d'information:
- La page de documentation du projet :&nbsp;<a href="http://rubydoc.info/github/octplane/ruby-io-tail/file/README.rdoc">http://rubydoc.info/github/octplane/ruby-io-tail/file/README.rdoc</a><br />
- Le project sur Github : <a href="https://github.com/octplane/ruby-io-tail">https://github.com/octplane/ruby-io-tail</a>