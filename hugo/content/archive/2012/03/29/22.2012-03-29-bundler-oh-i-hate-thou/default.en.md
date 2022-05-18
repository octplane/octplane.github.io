---
title: 'Bundler, oh, I hate thou'
date: '2012-03-29 08:08'
layout: post
permalink: /2012/03/bundler-oh-i-hate-thou.html
uuid: '5424362764459069503'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-5424362764459069503'
updated: '2012-03-29 08:08:38'
tags:
    - ruby
    - joke
    - bundler
taxonomy:
    tag: [backup]
lang: us
---

Another merry joke from my bundler friend. If you ever switch to deployment mode
(using the <code>bundle install --deployment</code>
command), do not come and cry if bundler starts saying:<br />
<pre>Could not find gemname-version in any of the sources
</pre>
When you have :

```
gem list
*** LOCAL GEMS ***
gemname (version)
```

Instead remove the lock:

```
bundle install --no-deployment
```

And voilà.

Short post, but this issue made me mad for half an hour.
