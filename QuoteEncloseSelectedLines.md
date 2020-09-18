## Summary

Function adds at the begin and the end of each line a single quote and adds a
comma at the end of each line. I often have lists with one item per line which I
need to use in sql IN clauses, so I put the functionality into a function for
convenience.

## This is what it looks like

select the lines call the function

## Function Source

    local function trim(s)
      return (s:gsub("^%s*(.-)%s*$", "%1"))
    end

    ---
    -- adds at the begin and the end of each line a single
    -- quote and a adds a comma at the end of each line.
    local function quote_enclose_selected_lines()
      local buffer = buffer
      local sel_text = buffer:get_sel_text()
      local result = ''
      if #sel_text == 0 then return end
      local i, lstr = 1, #sel_text -- i=1, lstr=length of selected text
      while i <= lstr do
        local x, y = string.find(sel_text, "\r?\n", i)
        -- now i=begin of line, x=begin of match, y=end of match
        if x then result = result.."'"..trim(string.sub(sel_text, i, x - 1)).."',\n"
        else
          result = result.."'"..trim(string.sub(sel_text, i, lstr)).."'"
          break
        end
        i = y + 1 -- position of next line
      end

      buffer:replace_sel(result)
    end

## How to use/call the function

I put the code into my SQL Module's *commands.lua* file and call it by pressing
'Alt-c s'. See the attached file below for details.

## Download

[sql_commands.lua](QuoteEncloseSelectedLines/sql-commands.lua)
