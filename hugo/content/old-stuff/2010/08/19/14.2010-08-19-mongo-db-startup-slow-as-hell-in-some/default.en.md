---
title: 'Mongo DB Startup slow as hell (in some conditions)'
type: blog
date: '2010-08-19'
layout: post
permalink: /2010/08/mongo-db-startup-slow-as-hell-in-some.html
uuid: '477182467467613943'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-477182467467613943'
updated: '2010-08-19 08:52:39'
blogger:
    siteid: '5365176712784435549'
    postid: '477182467467613943'
    comments: '0'
taxonomy:
    tag: [backup]
lang: us
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

We are now in the process of switching to Mongo DB 1.6.1 in order to use Sharding and Replicat Sets.

Yesterday, I found out that when Mongo was printing:

<blockquote>Wed Aug 18 16:59:33 [initandlisten] waiting for connections on port 27103 
Wed Aug 18 16:59:33 [initandlisten] ****** </blockquote>
It might not be quite ready. In fact, It is still allocating its <i>oplog</i> and this can take an awful lot of time on slow disk/fs combinations (several minutes in my case).

I opened a bug at Mongo (<a href="http://jira.mongodb.org/browse/SERVER-1637">http://jira.mongodb.org/browse/SERVER-1637</a>) and Eliot pointed me to a fs configuration change that could help.

We have now opted for XFS local disks (instead of 8 RAID-1 EBS disks in Ext3). XFS is supported by the kernel of the instance we use while Ext4 is NOT.

