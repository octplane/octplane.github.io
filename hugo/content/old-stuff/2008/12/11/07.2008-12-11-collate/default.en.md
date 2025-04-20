---
title: COLLATE
type: blog
date: '2008-12-11'
layout: post
permalink: /2008/12/collate.html
uuid: '3832825394751345562'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-3832825394751345562'
updated: '2008-12-11 18:54:30'
blogger:
    siteid: '5365176712784435549'
    postid: '3832825394751345562'
    comments: '0'
categories:
    - 'devel mssql'
taxonomy:
    tag: [backup]
lang: us
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

Never, never forget to add the <span style="font-style: italic;">COLLATION </span>of your temporary tables when you write MS-SQL server stored procedures. If you forget to do that and you ever migrate from say SQL Server 2005 to SQL Server 2000 some database, you end up doing the following:

<ul><li>naively reimport everything</li><li>try to compile the SP just to receive some weird errors message about the existing <span style="font-style: italic;">COLLATION </span>if you ever have a conflict between your <span style="font-style: italic;">COLLATION</span>S</li><li>later, try to run the SP and get some nice runtime errors because <span style="font-style: italic;">tempdb </span>uses a different <span style="font-style: italic;">COLLATION </span>than the one in your database</li><li>lose<span style="font-weight: bold;"> one complete afternoon</span> scripting stuff like <span style="font-style: italic;">ALTER TABLE ALTER COLUMN foo varchar(3) COLLATE ....</span></li><li>hope this si something that is never going to happen again.</li></ul>That's what I just did. Thank you.
