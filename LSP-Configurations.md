## Language Server Configurations

Here are some example language server configurations for Textadept's [LSP module](https://github.com/orbitalquark/textadept-lsp) that you can put in your *~/.textadept/init.lua* after installing it

### C++

```
   require('lsp').server_commands.cpp = function()
      return 'cquery', {
        cacheDirectory = '/tmp/cquery-cache',
        compilationDatabaseDirectory = io.get_project_root(),
        progressReportFrequencyMs = -1
      }
    end
```

### Haskell

```
    require('lsp').server_commands.haskell = 'haskell-language-server --lsp'
```

### Lua

```
    require('lsp').server_commands.lua = 'lua-lsp'
```

### Python

```
    require('lsp').server_commands.python = 'python-language-server'
```