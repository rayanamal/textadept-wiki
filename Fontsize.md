## Adjust font size independently from the theme file

Add to your *~/.textadept/init.lua*:

    local function fontsize()
      local c = _SCINTILLA.constants
      local buffer = buffer
      buffer.zoom = 2 -- e.g. add 2 points to the font size
      buffer.margin_width_n[0] = 4 + 3 * buffer:text_width(c.STYLE_LINENUMBER, '9')
    end

    events.connect(events.BUFFER_AFTER_SWITCH, fontsize)
    events.connect(events.VIEW_AFTER_SWITCH, fontsize)
