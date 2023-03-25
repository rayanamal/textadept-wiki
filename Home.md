Welcome to the Textadept wiki.

Textadept is a fast, minimalist, and remarkably extensible cross-platform text
editor for programmers. Written in a combination of C and Lua and relentlessly
optimized for speed and minimalism over years, Textadept is an ideal editor for
programmers who want endless extensibility without sacrificing speed and disk
space, and without succumbing to code bloat and a superabundance of features.

**Note: Textadept 11 has recently been released, which has many API and
configuration changes compared to 10.8. See the
[migration guide](https://orbitalquark.github.io/textadept/manual.html#migrating-from-textadept-10-to-11)
for more information on those changes. Wiki content should be up to date, but
content in external links may not be.**

---
[Wiki Editing Tips](EditingTips)
---

Search for 'textadept' on GitHub: https://github.com/search?o=desc&q=textadept&s=updated&type=Repositories

Search for 'textadept' on GitLab: https://gitlab.com/search?search=textadept

Textadept topic on GitHub: https://github.com/topics/textadept

## Language Modules

Official modules for HTML, CSS, Ruby, Python, ReST, and YAML are available as a
[zipped release](https://orbitalquark.github.io/textadept/changelog.html) and in
[various repositories](https://github.com/orbitalquark).

* D (https://github.com/Hackerpilot/textadept-d) -- works with
  [Dscanner](https://github.com/Hackerpilot/Dscanner/) program to provide
  autocomplete for D code.
* Markdown (https://github.com/rgieseke/ta-markdown)
* [Lisp](https://repo.or.cz/ta-parkour.git) -- Structured editing for Lisps
* [Javascript](https://github.com/AlexanderMisel/ta-javascript) -- A module for
  Javascript.

**The following may not be compatible with Textadept 11 yet**

* [CoffeeScript](http://rgieseke.github.com/ta-coffeescript) _dead link_
* [Python](https://bitbucket.org/SirAlaran/ta-python/) -- Helps automate
  indentation in Python code. _dead link_
* [LaTeX](https://bitbucket.org/SirAlaran/ta-latex/) -- Snippets for LaTeX
  markup. _dead link_
* [ConTeXt/LaTeX](https://github.com/stephengaito/ta-context-latex)
* [XML](https://bitbucket.org/SirAlaran/ta-xml/) -- Closes XML tags as you type
  them. Can automatically close tags at the cursor position. Contains several
  XSLT snippets. _dead link_
* [Hypertext add-on](https://bitbucket.org/SirAlaran/ta-hypertext/) -- Several
  of the above XML module's features, plus a limited implementation of the Zen
  Coding abbreviation engine. Requires the official Hypertext module. _dead link_
* [Moonscript](https://bitbucket.org/a_baez/ta-moonscript) -- And another one by
  the [creator of the language](https://github.com/leafo/moonscript-textadept). _dead link_
* [Toml](https://bitbucket.org/a_baez/ta-toml) -- A small module with snippets. _dead link_
* [Rust](https://bitbucket.org/a_baez/ta-rust) -- This thing has everything you
  could think of for working with the Rust language. _dead link_
* [YANG](yang-support) -- A module for YANG.

## Modules

* Textredux (https://github.com/rgieseke/textredux) -- Offers a set of text
  based replacement interfaces for core Textadept functionality, including a
  powerful file browser, buffer list, etc.
* textadept-vi (https://github.com/jugglerchris/textadept-vi)
  Some customisation for textadept to make it feel a bit like vim.
* [Lua REPL](https://github.com/orbitalquark/textadept-lua-repl) -- A Lua REPL
  using Textadept's Lua State.
* [ctags](https://github.com/orbitalquark/textadept-ctags) -- A module for
  autoloading ctags, jumping between them, and autocompleting from them.
* [Spell Checking](https://github.com/orbitalquark/textadept-spellcheck) -- A
  module for spell checking.
* [File diffing](https://github.com/orbitalquark/textadept-file-diff) -- A
  module for visualizing and merging the differences between two files.
* [Export](https://github.com/orbitalquark/textadept-export) -- A module for
  exporting buffers to various formats like HTML for printing.
* [LSP](https://github.com/orbitalquark/textadept-lsp) client module that
  communicates over the
  [Language Server Protocol](https://microsoft.github.io/language-server-protocol/)
  with language servers in order to provide autocompletion, callips, go to
  definition, etc. Sample language server configurations [are here](LSP-Configurations).
* [File browser](ta-filebrowser) -- A simple split-view file browser pane.
* [Elastic Tabstops](https://github.com/joshuakraemer/textadept-elastic-tabstops) -- An implementation of Nick Gravgaard’s
  Elastic Tabstops mechanism.
* [textadept-hydra](https://github.com/mhwombat/textadept-hydra) -- Modeled on the emacs hydra plugin. 
  Allows you to define key maps for related commands, with the ability to easily repeat commands by using a single keystroke.
* [Analyzer](https://github.com/david-von-tamar/textadept-analyzer) -- A static analysis framework for Textadept.
  Currently, the module integrates [luacheck](https://github.com/mpeterv/luacheck) and shows annotations and indicators (squiggle markers) for errors and warnings within the code editor.

**The following may not be compatible with Textadept 11 yet**

* [Comments](ta-comments)
* [Hastebin](https://bitbucket.org/a_baez/ta-hastebin) -- A
  [hastebin](http://hastebin.com/) client module for Textadept. _dead link_
* [Lapis](https://bitbucket.org/a_baez/ta-lapis) -- A module to work with the
  [lapis](http://leafo.net/lapis/) web framework. _dead link_
* [Love](https://bitbucket.org/a_baez/ta-love) -- A module to work with the
  [LÖVE](http://love2d.org/) game engine. _dead link_
* [Linux](https://bitbucket.org/a_baez/ta-linux) -- A linux kernel development
  module. Pretty simple, but works and makes life easier when working on those
  kernel modules or other kernel business. _dead link_
* [Macro](macro) -- A simple module for recording and replaying of keyboard
  macros.
* [Relative line numbers](https://github.com/rufusroflpunch/textadept-relative) --
  Module to display relative line numbers. Especially useful alongside vim-like
  modules.

## Functions

* [Selected word marker](https://github.com/lundmark/textadept_swm) allows you
  to select text in your buffer and all occurrences of that word will be
  surrounded by a box-indicator.
* [Brian's common functions](https://bitbucket.org/SirAlaran/ta-common/) _dead link_
* [Folding Key Commands](FoldingCommands)
* [Math - Replace selected equation with its value](bcmath)
* [Open terminal here (Linux/BSD)](TerminalHere)
* [Open webpage or link](OpenWebpage)
* [Replace Posix time with date](PosixDate)
* [Combining close and unsplit](CloseUnsplitView)
* [Delete Lines](DeleteLines)
* [Enclose functions](enclose)
* [Append a final newline to file](final-newline)
* [Alternative save-strips-whitespace function](SaveStripsWs)
* [Goto Symbol (filtered list)](GotoSymbol)
* [Quick "find next" for words under the cursor](GotoNearestOccurrence)
* [C/C++: completion with clang++](CppClangCompletion)
* [C/C++: automatic indentation with uncrustify](CppUncrustifyIndent)
* [Highlight trailing whitespace](HightlightTrailingWhitespace) _dead link_
* [Stats](Stats) shows line, word, and character counts
* [Switch to previous buffer (z-order)](previous-buffer-z-order) switches to the
  most recently used buffer, not the previous buffer in the buffer list.
* [Control+Tab option: navigate buffers in MRU order ](control-tab-mru)
* [Import default session](import-default-session) allows you to import the
  default, previous session into the current session.

## Themes

* [150+ Base-16 themes](https://github.com/rgieseke/base16-textadept/)
* [A Theme creator Web page](https://mswift42.github.io/themecreator/) Edit and generate your TextAdept theme(s)

## Collection of Modifications, ~/.textadept

* [rgieseke's common module](https://github.com/rgieseke/ta-common)
* [Alejandro's common module](https://bitbucket.org/a_baez/ta-common) _dead link_
* [Brian's ~/.textadept/ folder](http://hackerpilot.org/configs.php) _dead link_
* [Mitchell's ~/.textadept/](https://github.com/orbitalquark/.textadept)
* [Alejandro's ~/.textadept/](https://bitbucket.org/a_baez/ta-userhome) _dead link_
* [Gabriel's tweaks](https://github.com/gabdub/ta-tweaks)

## Theming

* [Line number margin for large files](LineNumberMargin)
* [Fontsize](Fontsize)
* [Distraction Free Mode](DistractionFreeMode)
* [Adjust line number margin on zoom](AdjustLineNumberMarginOnZoom)
* [Change statusbar color](ChangeStatusbarColor)

## Snippets

* [Library](SnippetLibrary)
* [Extra](https://bitbucket.org/a_baez/ta-extra) -- A module for adding
  snippets/changes to languages on Textadept, without having to write modules
  for each one. _dead link_
  * Alternative link (unconfirmed) [https://github.com/abaez/ta-extra.git]
* [Load snippets in directories](Load-snippets-in-directories) -- A replacement for the `textadept.snippets.paths` feature from Textadept 11 that was removed starting in Textadept 12.

## Articles, Guides, and Write-ups

* [Beautify Textadept](https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8)
* [Textadept and Snippets](https://medium.com/@a_baez/textadept-and-snippets-e55557c02ff1)
* [Textadept Language Lexers](https://medium.com/@a_baez/textadept-language-lexers-fd96f62e9527)
* [Textadept Modules](https://medium.com/@a_baez/a-textadept-module-db906f195195?source=your-stories)
* [Textadept's Userhome](https://medium.com/@a_baez/textadept-s-userhome-29ed8128db52#.owk71g6cz)
* [Review: Textadept](http://yfl.bahmanm.com/Members/ttmrichter/software-reviews/textadept-review) _dead link_
* [Textadept is fun to use and hack - Part 1](http://thejeshgn.com/2015/02/28/textadept-is-fun-to-use-and-hack-part-1/)

## Miscellaneous

* [Easy entry of ISO-Latin-1 characters with Textadept](Latin1)
* [Locale dependent key shortcuts](LocaleDependentKeys)
* [Find/Replace](FindReplace)
* [Keyboard Shortcuts](https://orbitalquark.github.io/textadept/api.html#textadept.keys)
* [Linux / BSD Desktop integration (freedesktop.org .desktop file)](FdoDesktop)
* [Stupid shell trick](http://yfl.bahmanm.com/Members/ttmrichter/yfl-blog/stupid-shell-trick) _dead link_
  for launching Textadept, among other GUI programs, from the console.
* [Viewer mode](TextadeptViewer)
* [Send selected text to **tmux**](selection2tmux) to work with a REPL from
  within TextAdept
* How to open Textadept in [wait-mode](wait-mode), that is, open a file in a new
  instance of Textadept, wait for it to be closed, and then quit Textadept.

---

## Notes and Scripts for Old Versions

### Stuff Only Working for 10.x

* [Migrating to Textadept 11](https://orbitalquark.github.io/textadept/manual.html#migrating-from-textadept-10-to-11)

#### Modules

* [George's module collection](gmc) -- A collection of my most frequently used
  modules, from a simple line centering utility to a reasonably complete macro
  facility.
* [Lua pattern find](lua-pattern-find) -- Brings back Textadept's Lua pattern
  searches and toggles between them and regular expression searches.
* [Enhanced Show Style](enhanced-show-style) -- Modify the "show style" tooltip
  to display the names of characters (code points) and the bytes that actually
  appear in the saved version of the file.

#### Themes

* [Black](BlackTheme)

#### Lexers

* [Lexer snippets](LexerSnippets)

#### Miscellaneous

* [A folding exercise](Fold)
* [How to close a file by double-clicking in its tab](tab-double-click) - how to
  add a new custom event to textadept.c

### Stuff Only Working for 9.x

* [Migrating to Textadept 9](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-9-to-10)

#### Miscellaneous

* [Conveniently search for UTF-8 codepoints in regex.](utf8-codepoint-regex)

### Stuff Only Working for 8.x

* [Migrating to Textadept 9](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-8-to-9)

#### Modules

* [Version control](version-control) -- A rudimentary version control module
  that supports basic VCS features from within Textadept.
* [Multiedit](multiedit) -- Better multi selection navigation/editing
  (sublimeish)

### Stuff Only Working for 7.x

* [Migrating to Textadept 9](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-7-to-8)

#### Language Modules

* A group of unsupported modules (including Adeptsenses) for Java, PHP, RHTML,
  Ruby, and Ruby on Rails can be found [here](adeptsense)

#### Modules

* [Adeptsense](adeptsense) - code autocompletion and documentation.

#### Miscellaneous

* [Keybord map like screen utility](https://bitbucket.org/dragonfyre13/ta-screen-keys/overview)

### Stuff Only Working for 6.x

* [Migrating to Textadept 7](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-6-to-7)

#### Themes

* [Solarized](solarized)
* [Green Mango](https://github.com/brickcap/textadept-custom-themes)
* [Diogo Dark](https://github.com/ocorreiododiogo/diogo-dark-theme)

### Stuff Only Working for 5.x

* [Migrating to Textadept 6](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-5-to-6)

#### Language Modules

* [Javascript](https://bitbucket.org/SirAlaran/ta-javascript/) -- Provides
  adeptsense autocompletion for several DOM methods and a subset of jQuery.

#### Themeing

* [More fold markers](MoreFoldMarkers)

### Stuff Only Working for 3.x and 4.x

* [Migrating to Textadept 5](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-4-to-5)
* [Migrating to Textadept 4](https://github.com/orbitalquark/textadept/blob/1a898bdf93501c0f39387d92a5f6d21cd472bc40/doc/manual.md#textadept-3-to-4)

#### Language Modules

* [PKGBUILD module](ta-pkgbuild)

#### Modules

* [Load "Common" modules](modules-common)
* [Zen-coding-style hypertext snippets](zenlike)
* [XML editing utilities](XmlComplete)
* [C-Style](CStyle)
* [Multi-Edit](multi-edit)
* [Line Wrap](LineWrap)

#### Functions

* [Function Selector - Manage lua functions with a filtered list](FunctionList)
* [Rectangular selection](http://gist.github.com/421382)
* [Insert Filename](InsertFilename)
* [quote enclose and add a comma to each line of selected text](QuoteEncloseSelectedLines)

#### Themes

* [Classic Themes](ClassicThemes)
* [Alaran-Dark](AlaranDark3)

#### Snippets

* [HTML](HypertextSnippets)

#### Miscellaneous

* [Instructions for portable cross-platform usage](RelativePaths)
