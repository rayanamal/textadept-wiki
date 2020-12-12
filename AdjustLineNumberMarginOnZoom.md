Add the following lines to *~/.textadept/init.lua* to adjust the line number
margin on zoom:

    -- adjust line number margin on zoom
    events.connect('events.zoom', function()
      local width = #(buffer.line_count..'')
      width = width > 4 and width or 4
      view.margin_width_n[1] = 4 + width * view:text_width(view.STYLE_LINENUMBER, '9')
    end)
