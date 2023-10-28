---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: personal-blog-home
title: "Personal Blog 💡" 
category: personal
---

This is where I write about things interests me. Running, surfing, living abroad...

[Link to HOME]({{ site.baseurl }}/)

{%- for path in page_paths -%}
  {%- assign my_page = site.pages | where: "path", path | first -%}
    {%- if my_page.title -%}
        <a class="page-link" href="{{ my_page.url | relative_url }}">{{ my_page.title | escape }}</a>
    {%- endif -%}
{%- endfor -%}