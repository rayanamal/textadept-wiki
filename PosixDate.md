## Posix Date function

This function reads a POSIX timestamp (seconds since epoch) and inserts a date
string. Add this function to your *key_commands.lua*.

    function ()
            local text = buffer:get_sel_text()
            local pos, time, date
            if #text>0 then
                    date = " "..os.date("%c",tonumber(text))
                    pos = buffer:word_end_position(buffer.current_pos,true)
            else
                    date = os.date()
                    pos = buffer.current_pos
            end
            buffer:insert_text(pos, date)
            buffer:goto_pos(pos+#date)
    end
