## Download

Download [this](ta-filebrowser/init.lua) to a
*~/.textadept/modules/file_browser/* folder. Then add
`_M.file_browser = require 'file_browser'` to your *~/.textadept/init.lua*.

## Usage

Go to the command entry and type:

    _M.file_browser.init('path/to/project')

Pressing spacebar on any entry activates it. (Directories are opened/closed and
files are opened in a split view).
