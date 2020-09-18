Add for example in your user *init.lua* or in a separate module:

    -- Indent Folding
    function collapse_fold(line)
      local line = line or buffer:line_from_position(buffer.current_pos)
        if buffer.fold_expanded[line] and buffer.line_visible[line] then
          buffer:toggle_fold(line)      -- colapse fold
          if not buffer.line_visible[line] then
            buffer:goto_line(buffer.fold_parent[line]) --set caret on parent fold line
          end
        end
    end

    function expand_fold(line)
      local line = line or buffer:line_from_position(buffer.current_pos)
      if not buffer.fold_expanded[line] and buffer.line_visible[line] then
        buffer:toggle_fold(line)
        buffer:goto_line(line+1) --set caret on the first child line of the fold
      end
    end

    function collapse_folds()
      for i = 0, buffer.line_count - 1 do
        collapse_fold(i)
      end
    end

    function expand_folds()
      for i = 0, buffer.line_count - 1 do
        expand_fold(i)
      end
    end

    keys['aright'] = expand_fold
    keys['aleft'] = collapse_fold
    keys['caright'] = expand_folds
    keys['caleft'] = collapse_folds

`aright` is the same as `ALT+right` key caright is the same as `CTRL+ALT+right`

Immediate testing of changes can be done with `F2` (To get a textadept command
prompt) and the issue the command reset().
