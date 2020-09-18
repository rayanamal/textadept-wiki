## Overview

A Textadept module for Vim-like Ctags support. The module automatically loads
Ctags when they are available and allows jumping to definitions and back (via a
stack mechanism). You can also perform autocompletion from tags files.

## Download

[Download](https://github.com/orbitalquark/textadept-modules/blob/default/ctags/init.lua)

## Usage

Download the Ctags module and place it in a *~/.textadept/modules/ctags/*
directory. Then `require` it from your *~/.textadept/init.lua* and optionally
set up some key bindings. For example:

    _M.ctags = require('ctags')
    keys['a&'] = textadept.menu.menubar[_L['_Search']]['_Ctags']['_Goto Ctag'][2]
    keys['a,'] = textadept.menu.menubar[_L['_Search']]['_Ctags']['Jump _Back'][2]
    keys['a.'] = textadept.menu.menubar[_L['_Search']]['_Ctags']['Jump _Forward'][2]
    keys['ac'] = textadept.menu.menubar[_L['_Search']]['_Ctags']['_Autocomplete Tag'][2]

Ctags are also available from the *Search* menu automatically.

## More Information

There are four ways to tell Textadept about tags files:

1. Place a *tags* file in current file's directory. This file will be used in a
   tag search from any file in that directory.
2. Place a *tags* file in a project's root directory. This file will be used in
   a tag search from any of that project's source files.
3. Add a *tags* file or list of *tags* files to the `_M.ctags` table for a
   project root key. This file(s) will be used in a tag search from any of that
   project's source files. For example:
   `_M.ctags['/path/to/project'] = '/path/to/tags'`.
4. Add a *tags* file to the `_M.ctags` table. This file will be used in any tag
   search. For example: `_M.ctags[#_M.ctags + 1] = '/path/to/tags'`.

Textadept will use any and all *tags* files based on the above rules.
