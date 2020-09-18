You can configure Textadept to be a "viewer" showing no menubar and read-only view.

In your *~/.textadept/init.lua*:

    args.register('-vm', '--view-mode', 0, function()
      -- Make all opened buffers read-only.
      events.connect(events.FILE_OPENED, function()
        buffer.read_only = true
      end)
      -- Hide the menubar.
      textadept.menu.menubar = nil
    end, 'View-only mode')

Then call Textadept from the command line like this:

    textadept --view-mode foo.lua bar.lua -e 'buffer:goto_line(9)'
