#!/usr/bin/env bash

( sleep 2 && open http://127.0.0.1:4000/scratch-blog/ ) &
bundle exec jekyll serve --livereload
