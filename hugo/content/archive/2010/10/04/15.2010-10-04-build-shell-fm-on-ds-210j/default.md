---
title: "Build shell-FM on DS-210J"
layout: "post"
permalink: "/2010/10/build-shell-fm-on-ds-210j.html"
uuid: "1248577752564243585"
guid: "tag:blogger.com,1999:blog-5365176712784435549.post-1248577752564243585"
date: "2010-10-04 22:22:00"
updated: "2010-10-04 22:22:49"
description: 
blogger:
    siteid: "5365176712784435549"
    postid: "1248577752564243585"
    comments: "0"
categories:
taxonomy:
    tag: [backup]
lang: us
author: 
    name: "Oct"
    url: "http://www.blogger.com/profile/10969884152933508554?rel=author"
    image: "http://img2.blogblog.com/img/b16-rounded.gif"
---

{% raw %}
<div class="css-full-post-content js-full-post-content">
<span class="Apple-style-span" style="font-size: large;">How to build shell-fm on DS 210J</span><br />
<br />
<b>Needed Package</b><br />
<br />
<br />
<ul><li>bootstraped unit:&nbsp;using for example this web page, http://sites.google.com/site/moosyresearch/ds210j</li>
<li>git</li>
<li>gcc</li>
</ul><br />
<br />
<b>Checkout shell-fm sources</b><br />
<br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><span class="Apple-style-span" style="font-size: x-small;">git clone git://github.com/jkramer/shell-fm.git shell-fm</span></span><br />
<br />
<b>Commands to run</b><br />
<br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><span class="Apple-style-span" style="font-size: x-small;">alias cc=gcc</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cd shell-fm/source</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o autoban.o autoban.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o bookmark.o bookmark.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o completion.o completion.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o feeds.o feeds.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o getln.o getln.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o hash.o hash.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o history.o history.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o http.o http.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o interface.o interface.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o md5.o md5.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o pipe.o pipe.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o play.o play.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o playlist.o playlist.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o radio.o radio.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o readline.o readline.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o recommend.o recommend.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o ropen.o ropen.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o sckif.o sckif.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o service.o service.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o settings.o settings.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o split.o split.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o strary.o strary.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o submit.o submit.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o tag.o tag.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o util.o util.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ &nbsp;-c -o xmlrpc.o xmlrpc.c</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">cc -Os -Wall -MD -W -I./include/ -c -o select.o select.c</span></span><br />
<br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">ar -cvq libshellfm.a autoban.o bookmark.o completion.o feeds.o getln.o hash.o history.o http.o interface.o md5.o pipe.o play.o playlist.o radio.o readline.o remend.o ropen.o sckif.o service.o settings.o split.o strary.o submit.o tag.o util.o xmlrpc.o select.o</span></span><br />
<br />
Overwrite the libpthead library by the built-in one:<br />
<br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><span class="Apple-style-span" style="font-size: x-small;">cp /lib/libpthread.so.0 /opt/arm-none-linux-gnueabi/lib/libpthread-2.5.so</span></span><br />
<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">gcc -o shell-fm -Os -Wall -MD -W -I./include/ main.c -lmad -lao -lpthread -ldl libshellfm.a</span></span><br />
<br />
<br />
<b>Run shell-fm !</b><br />
<br />
Once it is configured: (i use)<br />
<br />
&nbsp;<span class="Apple-style-span" style="font-size: x-small;"><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">./shell-fm -D /dev/dsp4</span></span><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
http://forum.buffalo.nas-central.org/viewtopic.php?f=69&amp;t=17016
</div>
{% endraw %}