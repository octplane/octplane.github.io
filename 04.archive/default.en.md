---
title: Archives
menu: /var/backup/
process:
    markdown: true
    twig: true
visible: true
content:
    items:
        '@taxonomy':
            tag: backup
    order:
        by: date
        dir: desc
    limit: 50
    pagination: true
---

Collection of old posts. Mostly for historical purpose.

{% for p in page.collection %}
- [{{ p.title }}]({{ p.link }}) {{ p.date |date("M j, Y") }}
{% endfor %}