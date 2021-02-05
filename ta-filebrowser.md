## Download

Download [this](ta-filebrowser/init.lua) to a
*~/.textadept/modules/file_browser/* folder.

## Usage

Go to the command entry and type:

    require('file_browser').init('/path/to/project')

Pressing spacebar on any entry activates it. (Directories are opened/closed and
files are opened in a split view). Other keys are: 'p' and 'n' to navigate up or
down by item, 'P' and 'N' to navigate up or down by level, and 'f' and 'b' to
navigate within a directory by its first and last files.

Alternatively, you can add `file_browser = require('file_browser')` to your
*~/.textadept/init.lua* and use `file_browser` in menus, scripts, and key
bindings. For example:

    local file_browser = require('file_browser')
    table.insert(textadept.menu.menubar[_L['File']], 3, {
      'Open Directory...', file_browser.init
    })
