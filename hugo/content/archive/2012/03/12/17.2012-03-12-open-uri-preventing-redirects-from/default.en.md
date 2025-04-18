---
title: 'Open-uri preventing redirects from https to http'
type: blog
date: '2012-03-12'
layout: post
permalink: /2012/03/open-uri-preventing-redirects-from.html
uuid: '3595971863622331023'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-3595971863622331023'
updated: '2012-03-28 09:32:32'
blogger:
    siteid: '5365176712784435549'
    postid: '3595971863622331023'
    comments: '0'
taxonomy:
    tag: [backup]
lang: us
categories:
    - ruby
    - bug
    - open-uri
author:
    name: Oct
    url: 'http://www.blogger.com/profile/10969884152933508554?rel=author'
    image: 'http://img2.blogblog.com/img/b16-rounded.gif'
---

Because it assumes it's insecure. That's quite annoying and should be configurable.<br />
<a href="http://www.blogger.com/goog_2039056758"><br /></a><br />
<br />
<ul>
<li><a href="http://www.ruby-forum.com/topic/1111884">http://www.ruby-forum.com/topic/1111884</a></li>
</ul>

```
def OpenURI.redirectable?(uri1, uri2)
    true
end
```

This monkey-patch fixes the issue and remove the check.<br />
<br />
A bug exists for the stdlib&nbsp;<a href="http://bugs.ruby-taxonomy:
    tag: [backup]
lang.org/issues/859">http://bugs.ruby-lang.org/issues/859</a> but fixes just the other way round.</div>
