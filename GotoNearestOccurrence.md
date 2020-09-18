## Summary

This is basically a really quick "Find Next". Calling this function will take
you to the next (or previous) occurrence of the word under the cursor.

## The code

    function goto_nearest_occurrence(reverse)
            local buffer = buffer
            local s, e = buffer.selection_start, buffer.selection_end
            if s == e then
                    s, e = buffer:word_start_position(s), buffer:word_end_position(s)
            end
            local word = buffer:text_range(s, e)
            if word == '' then return end
            buffer.search_flags = buffer.FIND_WHOLEWORD + buffer.FIND_MATCHCASE
            if reverse then
                    buffer.target_start = s - 1
                    buffer.target_end = 0
            else
                    buffer.target_start = e + 1
                    buffer.target_end = buffer.length
            end
            if buffer:search_in_target(word) == -1 then
                    if reverse then
                            buffer.target_start = buffer.length
                            buffer.target_end = e + 1
                    else
                            buffer.target_start = 0
                            buffer.target_end = s - 1
                    end
                    if buffer:search_in_target(word) == -1 then return end
            end
            buffer:set_sel(buffer.target_start, buffer.target_end)
    end

    keys.ck = function() goto_nearest_occurrence(false) end
    keys.cK = function() goto_nearest_occurrence(true) end
