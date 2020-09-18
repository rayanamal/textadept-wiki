Scripts for editing C-style languages such as D, Java, C++, C, and C#

## Download

[cstyle.lua](CStyle/cstyle.lua

## Installation

Place the scripts into a folder called "common" in your modules directory. For
example: "textadept/modules/common/cstyle.lua" Note: This script requires my
comments code. If it is not installed, you must comment out or delete the
relevant lines from the `enterkeypressed` function.

## Usage

To use these functions, add them to the *init.lua* or *post_init.lua* file for
the language you are using. Here is an example for the D language:

    local textadept = _G.textadept

    ---
    -- Commands for the d module.
    module('_m.dmd.commands', package.seeall)

    require 'common.cstyle'
    -- D-specific key commands.
    keys.dmd = {
            [keys.LANGUAGE_MODULE_PREFIX] = {
                    m = { io.open_file,
                    (_USERHOME..'/modules/dmd/init.lua'):iconv('UTF-8', _CHARSET) },
            },
            ['a\n'] = {newline},
            ['s\n'] = {newline_semicolon},
            ['c;'] = {endline_semicolon},
            ['}'] = {match_brace_indent},
            ['\n'] = {enter_key_pressed},
            ['c{'] = {openBraceMagic},
            ['cs\n'] = {closeTagComStr},
            ['cM'] = {selectScope},
    }

This sets up keybindings so that `Alt+Enter` will move the cursor to the end of
the line and add a newline. This is useful if the cursor is inside the
parenthesis of an if statement. `Shift+Enter` now adds a semicolon to the end of
the line and adds a newline. `Control+;` adds a semicolon to the end of the
line. The indentation levels of `}` characters are matched with the beginning
`{` when they are inserted. The enter key will do things like auto-continue
comments, indent after `{` characters, etc. To disable any of these features,
just comment out the key command in your language's *init.lua*.
