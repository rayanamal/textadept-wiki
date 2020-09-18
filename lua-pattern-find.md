## Introduction

Starting in Textadept 9.0 alpha 2, regular expression searches replaced Lua
pattern searches. This module brings back Textadept's Lua pattern searches and
toggles between them and regular expression searches.

It inserts a toggle option into the "Search" menu. You can also bind a key to
the `toggle_lua_patterns()` function.

## Usage

Download the [attached file](lua-pattern-find/lua-pattern-find.lua) and add the
following to your *~/.textadept/init.lua*:

    require('lua-pattern-find')
