---
title: 'Signify to GMail RSS signature Converter'
date: '2009-07-14 19:58'
layout: post
permalink: /2009/07/signify-to-gmail-rss-signature.html
uuid: '7512566651567661520'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-7512566651567661520'
updated: '2009-07-14 20:40:40'
blogger:
    siteid: '5365176712784435549'
    postid: '7512566651567661520'
    comments: '0'
categories:
    - python
taxonomy:
    tag: [backup]
lang: us
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---


Just wanted to share this small python code that naïvely converts a <a href="http://sourceforge.net/projects/signify/">signify </a> parameter file into a RSS file that can be used in <a href="http://mail.google.com/">GMail</a> with the Random Signature Appender lab feature.


It doesn't support any magical option of Signify (alignment, variable replacement). However, current lab feature <a href="http://groups.google.com/group/gmail-labs-help-random-signature/msg/874535157bd60408">has limitation to 96 chars in signature</a>. This definitively sucks.


Published under the <a href="http://sam.zoy.org/wtfpl/">WTFPL</a>.


´´´
import lxml.etree as et
import sys
import StringIO
import codecs

#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar
#  14 rue de Plaisance, 75014 Paris, France
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO. 


# take first command line parameter as input file
f = codecs.open( sys.argv[1], "r", "utf-8" )

signs = []
current_signature = ""

preamble = """
&lt;rss version="0.91"&gt;
&lt;channel&gt;
&lt;title&gt;Signify converted signatures&lt;/title&gt;
&lt;taxonomy:
    tag: [backup]
language&gt;en-us&lt;/language&gt;
&lt;/channel&gt;
&lt;/rss&gt;
"""

tree = et.parse(StringIO.StringIO(preamble))
channelNode = tree.xpath('/rss/channel')[0]
count = 0

for line in f:
line = line.rstrip()
if line.find("#") == 0:
line = line
# do nothing
elif line.find('%') == 0:
if len(current_signature) > 0:
 signs.append(current_signature)

 item = et.Element("item")
 title = et.Element("title")
 title.text = current_signature

 item.append(title)
 channelNode.append(item)

 count += 1
 current_signature = ""
else:

current_signature += line + "
"

print et.tostring(tree, xml_declaration=True, encoding="utf-8")
´´´
{% endraw %}