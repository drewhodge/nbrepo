# Notaional-FZF--Vim usage

## Detailed Usage

This plugin unites searching and file creation. It defines a single
command `:NV`, which can take 0 or more arguments, which are interpreted
as regexes.

Type `:NV` or bind it to a mapping to bring up a fuzzy search menu. Type
in your search terms and it will fuzzy search for them. Adding an
exclamation mark to the command (`:NV!`), will run it fullscreen.

You can type `:NV` to see all results, and then filter them with FZF.
You can type `:NV python` to restrict your initial search to lines that
contain the phrase `python`. `:NV [0-9] [0-9]` will find all numbers
separated by a space. You know, regexes.

It does not search in a fully fuzzy fashion because that's less useful
for prose. It looks for full words, but they don't have to be next to
each other, just on the same line. You can use the arrow keys or `c-p`
and `c-n` to scroll through the search results, and then hit one of
these keys to open up a file:

Note that the following options can be customized.

-   `c-x`: Use search string as filename and open in vertical split.
-   `c-v`: Open in vertical split
-   `c-s`: Open in horizontal split
-   `c-t`: Open in new tab
-   `c-y`: Yank the selected filenames
-   `<Enter>`: Open highlighted search result in current buffer

The lines around the selected file will be visible in a preview window.

## Mappings

This plugin only defines a command `:NV`, and if you want a mapping for
it, you can define it yourself. This is intentionally not done by
default. You should use whatever mapping(s) work best for you.

For example,

``` {.vim}
nnoremap <silent> <c-s> :NV<CR>
```

## Optional Settings and Their Defaults

You can display the full path by setting `g:nv_use_short_pathnames = 0`.

You can toggle displaying the preview window by pressing `alt-p`. This
is handy on smaller screens. If you don't want to show the preview by
default, set `g:nv_show_preview = 0`.

``` {.vim}
" String. Set to '' (the empty string) if you don't want an extension appended by default.
" Don't forget the dot, unless you don't want one.
let g:nv_default_extension = '.md'

" String. Default is first directory found in `g:nv_search_paths`. Error thrown
"if no directory found and g:nv_main_directory is not specified
"let g:nv_main_directory = g:nv_main_directory or (first directory in g:nv_search_paths)

" Dictionary with string keys and values. Must be in the form 'ctrl-KEY':
" 'command' or 'alt-KEY' : 'command'. See examples below.
let g:nv_keymap = {
                    \ 'ctrl-s': 'split ',
                    \ 'ctrl-v': 'vertical split ',
                    \ 'ctrl-t': 'tabedit ',
                    \ })

" String. Must be in the form 'ctrl-KEY' or 'alt-KEY'
let g:nv_create_note_key = 'ctrl-x'

" String. Controls how new note window is created.
let g:nv_create_note_window = 'vertical split'

" Boolean. Show preview. Set by default. Pressing Alt-p in FZF will toggle this for the current search.
let g:nv_show_preview = 1

" Boolean. Respect .*ignore files in or above nv_search_paths. Set by default.
let g:nv_use_ignore_files = 1

" Boolean. Include hidden files and folders in search. Disabled by default.
let g:nv_include_hidden = 0

" Boolean. Wrap text in preview window.
let g:nv_wrap_preview_text = 1

" String. Width of window as a percentage of screen's width.
let g:nv_window_width = '40%'

" String. Determines where the window is. Valid options are: 'right', 'left', 'up', 'down'.
let g:nv_window_direction = 'down'

" String. Command to open the window (e.g. `vertical` `aboveleft` `30new` `call my_function()`).
let g:nv_window_command = 'call my_function()'

" Float. Width of preview window as a percentage of screen's width. 50% by default.
let g:nv_preview_width = 50

" String. Determines where the preview window is. Valid options are: 'right', 'left', 'up', 'down'.
let g:nv_preview_direction = 'right'

" String. Yanks the selected filenames to the default register.
let g:nv_yank_key = 'ctrl-y'

" String. Separator used between yanked filenames.
let g:nv_yank_separator = "\n"

" Boolean. If set, will truncate each path element to a single character. If
" you have colons in your pathname, this will fail. Set by default.
let g:nv_use_short_pathnames = 1

"List of Strings. Shell glob patterns. Ignore all filenames that match any of
" the patterns.
let g:nv_ignore_pattern = ['summarize-*', 'misc*']

" List of Strings. Key mappings like above in case you want to define your own
" handler function. Most users won't want to set this to anything.

let g:nv_expect_keys = []
```

### bat config

If `bat` is in the PATH then it will be used. It will use `$BAT_THEME` if it's set.

You can also define your own handler function, in case you don't like
how this plugin handles input but like how it wraps everything else. It
*must* be called `NV_note_handler`.

## Potential Use Cases

-   Add `~/notes` and `~/wiki` so your notes are only one key binding
    away.
-   Add relative links like `./notes`, `./doc`, etc. to
    `g:nv_search_paths` so you can always see/update the documentation
    of your current project and keep up-to-date personal notes.

## Philosophy

To quote [scrod](https://github.com/scrod/nv/issues/22),

> The reasoning behind Notational Velocity's present lack of
> multi-database support is that storing notes in separate databases
> would 1) Require the same kinds of decisions that
> category/folder-based organizers force upon their users (e.g., "Is
> this note going to be work-specific or home-specific?"), and 2) Defeat
> the point of instantaneous searching by requiring, ultimately, the
> user to repeat each search for every database in use.

-   By providing a default directory, we offer (one) fix to the first
    issue.

-   By searching the whole set of directories simultaneously, we handle
    the second.

It also handles Notational Velocity's issue with multiple databases.
UNIX does not allow repeated filenames in the same folder, but often the
parent folder provides context, like in `workout/TODO.md` and
`coding/TODO.md`.

This plug-in attempts to abstract the operation of note-taking over
*all* the notes you take, with priority given to one main notes
directory.

## Caveat Emptor

-   This plugin is just a wrapper over FZF that can view directories and
    open/create files. That's all it's ever meant to be. Anything else
    would be put into a separate plugin.

