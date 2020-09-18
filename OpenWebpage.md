## Open webpage or selected link in web browser

Pressing `Ctrl-r` in HTML files opens the current file in your browser. If text
is selected (an url) this will be loaded.

Add the following to your *~/.textadept/init.lua* or your hypertext module:

    keys.html = {
        cr = function ()
          local url
          local sel = buffer:get_sel_text()
          if #sel == 0 then
            url = buffer.filename
          else
            url = sel
          end
          local cmd
          if WIN32 then
            cmd = string.format('start "" "%s"', url)
            local p = io.popen(cmd)
            if not p then error(l.MENU_BROWSER_ERROR..url) end
          else
            cmd = string.format(OSX and 'open "file://%s"' or 'xdg-open "%s" &', url)
            if os.execute(cmd) ~= 0 then error(_L['Error loading webpage:']..url) end
          end
        end,
    }
