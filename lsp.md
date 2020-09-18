## Introduction

This is an experimental client module for Textadept that communicates over the
[Language Server Protocol](https://microsoft.github.io/language-server-protocol/)
(LSP) with language servers in order to provide autocompletion, calltips, go to
definition, and more.

## Download

[Download](https://github.com/orbitalquark/textadept-modules/tree/default/lsp)

## Usage

Download the module files and place them in a *~/.textadept/modules/lsp/*
directory. Then `require` it from your *~/.textadept/init.lua* and set up some
language server commands. For example:

    _M.lsp = require('lsp')
    _M.lsp.server_commands.lua = 'lua-lsp'
    _M.lsp.server_commands.cpp = function()
      return 'cquery', {
        cacheDirectory = '/tmp/cquery-cache',
        compilationDatabaseDirectory = io.get_project_root(),
        progressReportFrequencyMs = -1
      }
    end

When either Lua or cpp files are opened, their associated language servers are
automatically started (one per language, though). See the documentation for
`server_commands` in *init.lua* for more information on how to specify comands.

Language Server features are available from the Tools > Language Server menu.
Note that not all language servers may support the menu options. You can assign
keybindings to these features in your *~/.textadept/init.lua* after requiring
the module. For example:

    keys['ca '] = function()
      textadept.editing.autocomplete('lsp')
    end
    keys['cH'] = _M.lsp.signature_help
    keys.f12 = _M.lsp.goto_definition

## Additional Information

If you want to inspect the LSP messages sent back and forth, you can use the Lua
command entry to set `_M.lsp.log_rpc = true`. It doesn't matter if any LSPs are
already active -- from this point forward all messages will be logged to the
"[LSP]" buffer.

**Note: Buggy language servers that do not respect the protocol may cause this
module and Textadept to hang, waiting for a response. There is no recourse other
than to force-quit Textadept and restart.**
