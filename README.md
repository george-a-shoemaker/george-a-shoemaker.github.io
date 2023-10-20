
Following this tutorial series: [Up and Running With GitHub Pages, Part 3, Bloggin with Jekyll](https://www.youtube.com/watch?v=EmSrQCDsMv4)

Create new blog from scratch: `jekyll new . --force`

Build and serve blog locally: `bundle exec jekyll serve`

**Live site**: https://george-a-shoemaker.github.io/scratch-blog/


## _config.yml

Top level site data that is injected into a template.

Cannot be edited with live-reload, you must rebuild the site from scratch.

## Gemfile

This file manages Ruby dependencies (ie gems).

As suggested by the comments, this project should be using the `github-pages` gem instead of `jekyll`

## Theme

Out of the box you can use a Gem-based theme such as `minima`.

I want to tinker with the layout so I copied the relevant theme directories: `_includes, _layouts, _sass, assets` into the root project directory

This means I'm using a "regular", ie hard-coded theme

