---
layout: post
title:  "How the hell to exit Vim"
date:   2022-04-16 07:00:00 -0600
category: software
---

\~or\~ a design critique of the text editor we love to hate, Vim.
<p align="center">
   <img
      src="{{ site.url }}{{ site.baseurl }}/assets/images/vim-logo.png" alt="Logo of Vim text editor"
   >
</p>

## A common first experience

You're a spring chicken 🐥  dabbling in `git` and you want to make your first commit.

 `git commit -a`

Odds are `git` just fired up Vim and you're expected to:

1. Write your commit message
2. Save your commit message
3. Exit Vim

When you start typing your message, things get wackadoodle. The mouse is useless. You panic. 😱

Google tells you to:

1. Write your commit message
   - Type `i` to enter "insert mode"
   - Type out your commit message
2. Save your commit message
   - Hit `esc` to return to "normal mode"
   - Type `:w` and hit `enter` to "write" the file
3. Exit Vim
   - Type `:q` and hit `enter` to quit Vim

What the hell was all that?

If you never want to experience that again you can configure `git` to use easy peasy `gedit`.

`git config --global core.editor "gedit -w -s"` 

## A design critique of Vim

I've been reading [The Design of Everyday Things][design-of-wiki] by Don Norman. I'll be using some terminology from the first chapter to describe what's good and bad about Vim.

### Conceptual Models

The first thing to *understand* about Vim is that it is modal. This means that the result of a keystroke is dependent on the mode you are in. Sort of like Caps Lock but taken to an extreme.

The default is "normal" mode which I think of as "navigation" mode. Vim makes the observation that you spend most of your time navigating when you edit a file. Therefore a myriad of navigation actions are placed at your finger tips in "normal" mode.

There's also "insert" mode, which allows you to type as you'd expect. "Visual" mode is for highlighting and manipulating chunks of text. Finally there is a "command" mode for things like saving or quitting. A command always starts with `:`.

### Mapping

There is a direct mapping of keys to actions in "normal" mode. Some attempt has been made to make the mapping "natural". For example you press `i` to enter insert mode. But pretty quickly the actions behind each key become pretty esoteric. Here are the most essential actions in "normal" mode.

<p align="center">
   <img
      src="{{ site.url }}{{ site.baseurl }}/assets/images/vim-basic.png" alt="Logo of Vim text editor"
   >
</p>

This cheat sheet is just the tip of the iceburge. Nearly every key does something.

I find `h`,`j`,`k`,`l` as navigation keys to be pretty unintutive. I can never remeber if `j` is down or up. Once upon a time keyboards didn't have arrow keys so this is how they chose to do it.


### Siginfiers

Vim gives essentially zero indication of what actions can take place. The only real feedback you get is a cursor and indication of which mode you're in at the bottom of the window.

The lack of signifiers might be the biggest probelm with Vim from a design perspective. The consequence is that the "discoverabily" of new actions is extremely low. In order to make Vim more useful you have study an external resource. This can make it really frustrating and cumbersome for beginners.

### Affordances

The idea behind this term is that software "affords" the user certain capabilites. However access to these capbailites is entirely dependent on the user. An "affordance" is a *relationship* between the software and the user according to Norman.

Vim makes this relationship painfully obvious because the discoverability of affordances is so poor. With zero knowledge of Vim, it doesn't even afford quitting out of it.

<p align="center">
   <img
      src="{{ site.url }}{{ site.baseurl }}/assets/images/vim-comic.png" alt="Comic with a punchline that implies that Vim in inescapable."
   >
</p>

Vim can afford customization of appearance & behavior with a [.vimrc][vimrc]{{ site.blank-target }} file. There's also a meta layer of affordances that you can invent yourself with [macros][vim-macro]{{ site.blank-target }}. Macros are prewritten commands that are especially useful for conquering repetitive tasks.

## Yes, I actually use Vim

And here's why.

It's nearly ubiquitious on Unix-like systems. It'll make you dangerous on a remote server with no GUI. If Vim isn't installed look for it's predecessor, Vi.

I also use Vim keybindings across IDEs, namely Xcode, Android Studio & VS Code. I know these editors have good shortcuts, I just don't want to learn a new set for each one.

Vim is simply what I'm used to. A professor in college introduced me to it and I dove in.

## Should you learn Vim?

I'll leave that up to you. It takes real effort to make it useful.

I suggest learning with [vim.so][vim-so]{{ site.blank-target }}. It's interactive and helps you internalize the keystrokes with repetition. I also find [learnbyexample.github.io/vim_reference][learnbyexample]{{ site.blank-target }} to be a straightforward reference.

[vim-so]:https://www.vim.so/
[vimrc]:https://learnbyexample.github.io/vim_reference/Customizing-Vim.html
[design-of-wiki]:https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things
[vim-macro]:https://learnbyexample.github.io/vim_reference/Macro.html
[learnbyexample]:https://learnbyexample.github.io/vim_reference/