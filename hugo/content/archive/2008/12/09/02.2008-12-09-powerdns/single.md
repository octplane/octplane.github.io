---
title: Powerdns
type: blog
date: '2008-12-09'
layout: post
taxonomy:
    tag: [backup]
lang: us
---

[Powerdns](http://www.powerdns.com/) is a very nice DNS server. It provides out of the box Geo sensitivity, enabling you to redirect your customer to different servers according to their origin. We use that we a quite complex zone setup.

Also it can be plugged onto a SQL backend (such as mysql, postgresql or sqlite). The whole stuff can then be managed by dedicated web tools. We use [pdnsadmin](https://www.openhub.net/p/pdnsadmin) (php based, requires mysql) and this is enough for simple uses.
