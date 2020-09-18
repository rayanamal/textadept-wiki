## Automatic loading of modules in modules/common/

Create a file *~/.textadept/modules/common/init.lua* with the following in it:

    local lfs = require 'lfs'
    for filename in lfs.dir(_USERHOME..'/modules/common/') do
      if filename:find('%.lua$') and filename ~= 'init.lua' then
        require('common.'..filename:match('^(.+)%.lua$'))
      end
    end

Then add

    require 'common'

to your *~/.textadept/init.lua*

All "common" submodules that are placed in *modules/common* will be
automatically loaded without having to add another require statement.
