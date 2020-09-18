## Adjust the the line number margin for files with more than 10000 lines

Add

    events.connect(events.FILE_OPENED, function()
      local buffer = buffer
      local c = _SCINTILLA.constants
      local width = #(buffer.line_count..'')
      width = width > 4 and width or 4
      buffer.margin_width_n[0] = 4 + width * buffer:text_width(c.STYLE_LINENUMBER, '9')
    end)

to your *~/.textadept/init.lua* to set the line number margin to an appropriate
value for large files.
