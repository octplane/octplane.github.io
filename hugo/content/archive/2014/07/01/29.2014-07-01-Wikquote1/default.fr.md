---
title: 'Analyse de fr.wikiquote.org'
type: blog
date: '2014-07-01'
layout: post
moot_legacy_id: 11
cover_image: 'http://upload.wikimedia.org/wikipedia/commons/8/81/Wikimedia-logo.svg'
cover_credit: 'User:Zscout370 with mods. by Dbenbenn. Designed by Neolux'
tags:
    - code
    - wikipedia
taxonomy:
    tag: [backup]
lang: fr
---

Cet article évoque l'analyse technique du contenu des articles de la version française de Wikiquote. Elle donne un éclairage instructif sur la qualité du contenu de cette base en terme structurel.

## Wikiquote ?

Si vous l'ignoriez encore, [wikiquote](http://fr.wikiquote.org) est un des projets Wikimedia qui contient entre autres la très connue [Wikipedia](http://fr.wikipedia.org), l'encyclopédie libre et à laquelle tout le monde peut participer. Wikiquote, lui, vise à rassembler des citations, et à les organiser par auteur et par thème.

Dans le cadre de mes projets personnels, j'avais besoin de voir s'il était possible de parser les données Wikiquote pour en extraire les citations de manière aussi structurée que possible.

## Et alors ?

Après quelques expériences, le format de fr.wikiquote.org est relativement structuré, les citations sont dans des [modèles](http://fr.wikiquote.org/wiki/Cat%C3%A9gorie:Mod%C3%A8le:Racine)  `{{{citation}}}` et les références dans des `{{{Réf livre|série|article|film ...}}`. J'ai finalement fini par écrire un parser simple du format du markup utilisé dans fr.wikiquote.org, il est disponible [ici, pour les curieux](https://github.com/octplane/wikiquote-parser) et il vous faudra un dump de wikiquote, ou le lancer sur l'échantillon qui est dans le projet.

## Des stats

Alors voilà les statistiques livrées par la machine. Pour chaque balise, j'ai listé les attributs les plus fréquement utilisés (avec leur % d'adoption). On voit ici que la variabilité est assez considérable, et qu'en particulier, les citations ne sont probablement pas toutes sourcées (vu l'écart entre les `Réf` et les `Citation`).

Néanmoins, il devrait être possible d'extraire un sacré paquet de citations de manière automatisée et d'avoir quelque chose d'exploitable. Prochaine étape, faire un mini site qui permet de naviguer dans ces citations de manière structurée.

### [citation](http://fr.wikiquote.org/wiki/Modèle:citation) (42883 occ.)

- citation (68%)
- précisions (14%)
- taxonomy:
    tag: [backup]
langue (11%)
- original (9%)

### [réf livre](http://fr.wikiquote.org/wiki/Modèle:réf_livre) (28186 occ.)

- page (96%)
- titre (88%)
- auteur (88%)
- éditeur (86%)
- année (85%)
- isbn (40%)
- année d'origine (36%)
- collection (33%)
- section (24%)
- chapitre (22%)
- traducteur (18%)
- partie (16%)
- référence (11%)

### [personnage](http://fr.wikiquote.org/wiki/Modèle:personnage) (13531 occ.)

### [w](http://fr.wikiquote.org/wiki/Modèle:w) (6410 occ.)

### [réf film](http://fr.wikiquote.org/wiki/Modèle:réf_film) (4791 occ.)

- titre (99%)
- auteur (98%)
- date (95%)
- acteur (91%)

### [interprojet](http://fr.wikiquote.org/wiki/Modèle:interprojet) (3650 occ.)

- w (82%)
- wikt (24%)
- commons (14%)
- s (11%)

### [réf article](http://fr.wikiquote.org/wiki/Modèle:réf_Article) (3314 occ.)

- titre (99%)
- auteur (99%)
- publication (96%)
- date (67%)
- page (63%)
- numéro (51%)
- issn (13%)
- url (12%)

### [réf série](http://fr.wikiquote.org/wiki/Modèle:réf_Série) (3083 occ.)

- acteur (97%)
- auteur (96%)
- série (93%)
- saison (93%)
- épisode (93%)
- diffusion (23%)
- diffuseur (23%)
- date (21%)
- traducteur (19%)

### defaultsort (2717 occ.)

### [date](http://fr.wikiquote.org/wiki/Modèle:date) (1788 occ.)

### [réf pub](http://fr.wikiquote.org/wiki/Modèle:réf_pub) (1755 occ.)

- nom (99%)
- date (97%)
- source (83%)
- auteur (66%)
- parution (61%)
- lieu (51%)
- précision (11%)

### [choisie citation du jour](http://fr.wikiquote.org/wiki/Modèle:choisie_citation_du_jour) (1502 occ.)

- mois (100%)
- année (100%)
- jour (100%)
- puce (95%)
- commentaire (81%)

Je n'ai mis que le début des stats (tout les modèles présents plus de 1000 fois), parce qu'il y en a un petit paquet et que c'est pas forcément très trépidant. N'hésitez pas à me faire du retour sur ces données si vous avez des choses à dire :)

(relecture par Alexis)
