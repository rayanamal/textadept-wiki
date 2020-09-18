    -- Highlight trailing whitespace
    local tw_indicator = _SCINTILLA.next_indic_number()
    buffer.indic_style[tw_indicator] = buffer.INDIC_ROUNDBOX
    buffer.indic_fore[tw_indicator] = 0x0000FF
    events.connect(events.UPDATE_UI, function(updated)
      if updated ~= buffer.UPDATE_CONTENT then return end
      buffer.target_start = 0
      buffer.search_flags = buffer.FIND_REGEXP
      buffer.indicator_current = tw_indicator
      buffer:indicator_clear_range(0, buffer.length)
      while true do
        buffer.target_end = buffer.length
        if buffer:search_in_target('[ \t]+$') == -1 then break end
        buffer:indicator_fill_range(
          buffer.target_start, buffer.target_end - buffer.target_start)
        buffer.target_start = buffer.target_end
      end
    end)
