This function adds a final newline to the file, depending on your buffer EOL
mode, if one is not present. It's suitable for connecting to the before-save
event.

    function final_newline()
        local len = buffer.length
        local last = string.char(buffer.char_at[len-1]) -- very last char is NUL
        if buffer.eol_mode == buffer.EOL_LF and last ~= '\n' then
            buffer:insert_text(len, '\n')
        elseif buffer.eol_mode == buffer.EOL_CR and last ~= '\r' then
            buffer:insert_text(len, '\r')
        elseif buffer.eol_mode == buffer.EOL_CRLF and last ~= '\n' then
            local last1 = string.char(buffer.char_at[len-2])
            if last1 ~= '\r' then
                buffer:insert_text(len, '\r\n')
            end
        end
    end

    events.connect(events.FILE_BEFORE_SAVE, final_newline)
