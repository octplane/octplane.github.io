---
title: "rman is clever"
layout: "post"
date: "2008-12-09 15:55:00"
updated: "2008-12-09 16:06:44"
tags:
- admin
- oracle
lang: us
---

Well, sort of. Today, after <a href="https://metalink.oracle.com/CSP/ui/index.html?mlrdu=%2Fmetalink%2Fplsql%2Ff%3Fp%3D130%3A14%3A1803355855427536666%3A%3A%3A%3Ap14_database_id%2Cp14_docid%2Cp14_show_header%2Cp14_show_help%2Cp14_black_frame%2Cp14_font%3ANOT%2C277710.1%2C1%2C1%2C1%2Chelvetica$&amp;version=html">patching one of my oracle database server</a> against a migration issue that prevented it from shutting down clean. I finally managed to run<a href="http://www.cuddletech.com/articles/oracle/node58.html"> the magic command</a>:


```
alter database archivelog;
```



That would enable me to backup the database. Unfortunately, the disk space on this server is too low to allow two full backups of the database. I wanted to delete the old backup before doing the new one in rman but rman is too clever: You cannot delete the last remaining backup! I now have to find larger disks.
