-- Copyright 2007-2009 Mitchell mitchell<att>caladbolg.net. See LICENSE.

---
-- Commands for the sql module.
module('_m.sql.commands', package.seeall)


local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

---
-- adds at the begin and the end of each line a single
-- quote and a adds a comma at the end of each line.
local function sql_quote_enclose()
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
      result = result.."'"..trim(string.sub(sel_text, i, #sel_text)).."'"
      break
    end
    i = y + 1 -- position of next line
  end

  buffer:replace_sel(result)
end


-- sql-specific key commands.
local keys = _G.keys
if type(keys) == 'table' then
  keys.sql = {
    al = {
      m = { io.open,
            (_HOME..'/modules/sql/init.lua'):iconv('UTF-8', _CHARSET) },
    },
    ac = {
      s = { sql_quote_enclose }
    },
  }
end
