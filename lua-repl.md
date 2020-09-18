This is a module creates in a buffer an interactive Lua REPL using Textadept's
Lua State. This can be a useful substitute for Textadept's command entry.

## Download

[Download](https://github.com/orbitalquark/textadept-modules/blob/default/lua_repl/init.lua)

## Install

Save the script below to *_USERHOME/modules/lua/repl.lua* and add the following
to your *_USERHOME/init.lua*:

    require('lua.repl')


## Usage

Select "Tools > Lua REPL" to open the REPL. Typing the Enter key on any line
evaluates that line, unless that line is a continuation line. In that case, when
finished, select the lines to evaluate and type Enter to evaluate the entire
chunk.

Lines may be optionally prefixed with '=' (similar to the Lua prompt) to print a
result.
