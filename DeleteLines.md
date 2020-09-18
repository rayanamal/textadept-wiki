Deletes lines from the beginning of the selection to the end, or the current
line if there is no selection.

    -- Deletes the lines spanned by the selection or delete current line if no selection.
    function delete_lines()
      buffer:begin_undo_action()
      if buffer.selection_empty then
        buffer:line_delete()
      else
        local start_line = buffer:line_from_position(buffer.selection_start)
        local end_line = buffer:line_from_position(buffer.selection_end)
        local start_pos = buffer:position_from_line(start_line)
        local end_pos = buffer:position_from_line(end_line + 1)
        buffer:delete_range(start_pos, end_pos - start_pos)
      end
      buffer:end_undo_action()
    end
