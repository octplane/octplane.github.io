---
title: 'Blog Styling'
type: blog
date: '2012-03-28'
layout: post
permalink: /2012/03/blog-styling.html
uuid: '7353438691744615084'
guid: 'tag:blogger.com,1999:blog-5365176712784435549.post-7353438691744615084'
updated: '2012-03-28 09:30:52'
taxonomy:
    tag: [backup]
lang: us
---

This article describes the way I style things in this blog.<br />
<br />
<h3>


Blockquotes</h3>
&nbsp;I use the following CSS styles for my blockquotes. Final result is:<br />
<br />
<blockquote class="tr_bq">
Example of styled blockquote </blockquote>
<br />
<pre><code>
blockquote{
  background:#f9f9f9;
  border-left:1em solid #eee;
  margin:1.5em 1em;
  padding:.5em 1em;
  quotes:"\201C""\201D";
  font: italic normal 12pt/1.2em Georgia;
}

blockquote:before{
  color:#808080;
  content:open-quote;
  font-size:4em;
  line-height:.1em;
  margin-right:.25em;
  vertical-align:-.4em;
}

blockquote :first-child{display:inline;}
blockquote :last-child{margin-bottom:0;}
</code></pre>
<h3>
Code block</h3>
For code blocks, I use the following style:<br />
<br />

```
pre {
        border:1px dashed #E1E1E1;
        color:#333344;
        background:#FAFAFA;
        font-family:monospace;
        overflow:auto;
        font-size:11px;
        padding:0.5em;
}
```
