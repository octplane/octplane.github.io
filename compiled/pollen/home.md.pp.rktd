((3) 0 () 0 () () (h - () (metas h - () (here-path . "/Users/oct/mine/mine/oct.zoy.org.v2022/home.md.pp")) (doc u . "# Pierre Baillet's homepage\n\nWelcome home.\n\n\nOn this site, you can read about my latest posts below, find out [where this nick comes from](/about/),\nread about [the talks I deliver](/as-a-speaker.html).\n\n## Blog posts\n\n{% for p in page.collection.visible %}\n- [{{ p.title }}]({{ p.link }}) {{ p.date | date(\"Y/m/d\") }}\n{% endfor %}\n\n### Latest bookmarks\n\n{% for name, feed in twig_feeds %}\n{% for item in feed.items %}\n- {{ item.date.date | nicetime(false)  }} - [{{item.title}}]({{item.url}})\n{% endfor %}\n{% endfor %}")))