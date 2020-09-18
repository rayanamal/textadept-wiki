Textadept uses [TRE](https://laurikari.net/tre/) as its regex engine for text
searches. Unfortunately, TRE does not allow for easy searching of UTF-8
codepoints (e.g. U+2318). Normally, UTF-8 codepoints would have to be broken up
into their individual bytes and searched for separately (e.g. \xe2\x8c\x98).
Adding the following to your *~/.textadept/init.lua* extends regex syntax to
silently convert "\u{codepoint}" sequences into the individual byte sequences
needed by TRE. Thus a search like "\u{2318}" would work as expected.

    local overriding_find = false
    events.connect(events.FIND, function(text, next)
      if not overriding_find and ui.find.regex then
        -- Substitute \u{codepoint} with \xXY byte sequences needed by TRE.
        text = text:gsub('\\u{(%x+)}', function(codepoint)
          local char = utf8.char(tonumber(codepoint, 16))
          return string.rep('\\x%X', #char):format(char:byte(1, #char))
        end)
        overriding_find = true
        events.emit(events.FIND, text, next)
        overriding_find = false
        return true -- prevent normal 'find' handling
      end
    end, 1)
