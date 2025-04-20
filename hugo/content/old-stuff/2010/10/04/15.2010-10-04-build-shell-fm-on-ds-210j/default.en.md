---
title: 'Build shell-FM on DS-210J'
type: blog
date: '2010-10-04'
layout: post
permalink: /2010/10/build-shell-fm-on-ds-210j.html
uuid: '1248577752564243585'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-1248577752564243585'
updated: '2010-10-04 22:22:49'
blogger:
    siteid: '5365176712784435549'
    postid: '1248577752564243585'
    comments: '0'
taxonomy:
    tag: [backup]
lang: us
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

## How to build shell-fm on DS 210J</span>

<b>Needed Package</b>


<ul><li>bootstraped unit:&nbsp;using for example this web page, http://sites.google.com/site/moosyresearch/ds210j</li>
<li>git</li>
<li>gcc</li>
</ul>

<b>Checkout shell-fm sources</b>

<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><span class="Apple-style-span" style="font-size: x-small;">git clone git://github.com/jkramer/shell-fm.git shell-fm<

<b>Commands to run</b>

```
alias cc=gcc
cd shell-fm/source<
cc -Os -Wall -MD -W -I./include/ -c -o autoban.o autoban.c<
cc -Os -Wall -MD -W -I./include/ -c -o bookmark.o bookmark.c<
cc -Os -Wall -MD -W -I./include/ -c -o completion.o completion.c<
cc -Os -Wall -MD -W -I./include/ -c -o feeds.o feeds.c<
cc -Os -Wall -MD -W -I./include/ -c -o getln.o getln.c<
cc -Os -Wall -MD -W -I./include/ -c -o hash.o hash.c<
cc -Os -Wall -MD -W -I./include/ -c -o history.o history.c<
cc -Os -Wall -MD -W -I./include/ -c -o http.o http.c<
cc -Os -Wall -MD -W -I./include/ -c -o interface.o interface.c<
cc -Os -Wall -MD -W -I./include/ -c -o md5.o md5.c<
cc -Os -Wall -MD -W -I./include/ -c -o pipe.o pipe.c<
cc -Os -Wall -MD -W -I./include/ -c -o play.o play.c<
cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o playlist.o playlist.c<
cc -Os -Wall -MD -W -I./include/ -c -o radio.o radio.c<
cc -Os -Wall -MD -W -I./include/ -c -o readline.o readline.c<
cc -Os -Wall -MD -W -I./include/ -c -o recommend.o recommend.c<
cc -Os -Wall -MD -W -I./include/ -c -o ropen.o ropen.c<
cc -Os -Wall -MD -W -I./include/ -c -o sckif.o sckif.c<
cc -Os -Wall -MD -W -I./include/ -c -o service.o service.c<
cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o settings.o settings.c<
cc -Os -Wall -MD -W -I./include/ -c -o split.o split.c<
cc -Os -Wall -MD -W -I./include/ -c -o strary.o strary.c<
cc -Os -Wall -MD -W -I./include/ -c -o submit.o submit.c<
cc -Os -Wall -MD -W -I./include/ -c -o tag.o tag.c<
cc -Os -Wall -MD -W -I./include/ -c -o util.o util.c<
cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o xmlrpc.o xmlrpc.c<
cc -Os -Wall -MD -W -I./include/ -c -o select.o select.c<

ar -cvq libshellfm.a autoban.o bookmark.o completion.o feeds.o getln.o hash.o history.o http.o interface.o md5.o pipe.o play.o playlist.o radio.o readline.o remend.o ropen.o sckif.o service.o settings.o split.o strary.o submit.o tag.o util.o xmlrpc.o select.o<
```

Overwrite the libpthead library by the built-in one:

```
cp /lib/libpthread.so.0 /opt/arm-none-linux-gnueabi/lib/libpthread-2.5.so
gcc -o shell-fm -Os -Wall -MD -W -I./include/ main.c -lmad -lao -lpthread -ldl libshellfm.a
```

<b>Run shell-fm !</b>

Once it is configured: (i use)

```
./shell-fm -D /dev/dsp4
```













http://forum.buffalo.nas-central.org/viewtopic.php?f=69&amp;t=17016
