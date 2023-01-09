# Notational FZF--install and config

***Loosen the mental blockages to recording information. Scrape away the
tartar of convention that handicaps its retrieval.***

--- [Notational Velocity home page](http://notational.net/)

Notational Velocity is a note-taking app where searching for a note and
creating one are the same operation.

You search for a query, and if no note matches, it creates a new note
with that query as the title.

## Usage

See the following GIF or watch this
[asciinema](https://asciinema.org/a/oXAsE6lDnywkrSSH5xuOIVQuO):

![Usage](/screenshots/usage.gif?raw=true "Usage")

## Installation

``` {.vim}
" with vim-plug
Plug 'https://github.com/alok/notational-fzf-vim'
```

## Changes

Read `CHANGELOG.md`.

## Description

Vim is great for writing. But it isn't optimized for note-taking, where
you often create lots of little notes and frequently change larger notes
in a separate directory from the one you're working in. For years I used
[nvALT](http://brettterpstra.com/projects/nvalt/) and whenever I had to
do serious editing, I would open the file in Vim.

But some things about nvALT bugged me.

-   It's not meant for large text files, and opening them will cause it
    to lag *a lot*.

-   I can't use splits

-   I do most of my work in Vim, so why have another window open,
    wasting precious screen space with its inferior editing
    capabilities. Sorry Brett, but nvALT can't match Vim's editing
    speed.

-   I also disagree with some parts of Notational Velocity's philosophy.

Plugins like [vim-pad](https://github.com/fmoralesc/vim-pad) didn't do
it for me either, because:

-   I don't want to archive my notes. I should be able to just search
    for them.
-   I don't want to use the first line as the title since I have notes
    with duplicated titles in different directories, like `README.md`.
-   I just want to be able to search a set of directories and create
    notes in one of them, ***quickly***.

When [Junegunn](https://github.com/junegunn/) created
[`fzf`](https://github.com/junegunn/fzf), I realized that I could have
all that, in Vim.

This plugin allows you to define a list of directories that you want to
search. The first directory in the list is used as the main directory,
unless you set `g:nv_main_directory`. If you press `control-x` after
typing some words, it will use those words as the filename to create a
file in the main directory. It will then open that file in a vertical
split. If that file already exists, don't worry, it won't overwrite it.
This plugin never modifies your files at any point. It can only read,
open, and create them.

You can define relative links, so adding `./docs` and `./notes` will
work. Keep in mind that it's relative to your current working directory
(as Vim interprets it).

## Dependencies

-   [`rg`](https://github.com/BurntSushi/ripgrep) is required for its
    fast search.

-   [`fzf`](https://github.com/junegunn/fzf).

-   `fzf` Vim plugin. Install the Vim plugin that comes with `fzf`,
    which can be done like so if you use
    [vim-plug](https://github.com/junegunn/vim-plug).

    ``` {.vim}
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    ```

-   Python 3.5 or higher, for the preview window and filepath
    shortening.

## Optional dependencies

-   Pypy 3, for a potential speedup

## Required Settings

You have to define a list of directories **or** files (which all must be
strings) to search. This setting is named `g:nv_search_paths`.

Remember that these can be relative links.

``` {.vim}
" example
let g:nv_search_paths = ['~/wiki', '~/writing', '~/code', 'docs.md' , './notes.md']
```
