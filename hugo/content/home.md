#lang pollen

◊(define-meta title "Homepage")

◊(define meta "
menu: $HOME
process:
    markdown: true
    twig: true
twig_first: true
content:
    items:
        '@page': /blog
    order:
        by: date
        dir: desc
    limit: 100
    pagination: false"
)

# Pierre Baillet's homepage

Welcome home.


On this site, you can read about my latest posts below, find out [where this nick comes from](/about.html),
read about [the talks I deliver](/as-a-speaker.html).

## Blog posts

◊(pagetree->list)

{% for p in page.collection.visible %}
- [{{ p.title }}]({{ p.link }}) {{ p.date | date("Y/m/d") }}
{% endfor %}

### Latest bookmarks

{% for name, feed in twig_feeds %}
{% for item in feed.items %}
- {{ item.date.date | nicetime(false)  }} - [{{item.title}}]({{item.url}})
{% endfor %}
{% endfor %}