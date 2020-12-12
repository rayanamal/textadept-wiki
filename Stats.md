This function will show line, word, and character counts for the current buffer
(and the current selection). Lines are counted as in Scintilla, i.e. a void file
is considered having one line. The definition of word is the same as in the Unix
utility "wc" (a sequence of non-blank characters). Character count is different
from byte count (several bytes can be one character).

Code:

    function stats()
        local n_lines = buffer.line_count
        local _, n_words = string.gsub(buffer:get_text(), "%S+", "")
        local n_chars = buffer:count_characters(1, buffer.length + 1)
        if buffer.selection_empty then
            ui.dialogs.msgbox {title = 'Statistics',
                text = string.format("Buffer:\n\n%d lines\n%d words\n%d characters",
                    n_lines, n_words, n_chars),
                icon = 'gtk-dialog-info'}
        else
            local n_lines_s = buffer:line_from_position(buffer.selection_end) - buffer:line_from_position(buffer.selection_start) + 1
            local _, n_words_s = string.gsub(buffer:text_range(buffer.selection_start, buffer.selection_end), "%S+", "")
            local n_chars_s = buffer:count_characters(buffer.selection_start, buffer.selection_end)
            ui.dialogs.msgbox {title = 'Statistics',
                text = string.format("Selection / Buffer:\n\n%d / %d lines\n%d / %d words\n%d / %d characters",
                    n_lines_s, n_lines, n_words_s, n_words, n_chars_s, n_chars),
                icon = 'gtk-dialog-info'}
        end
    end

Assign a key binding to trigger the function. Example:

    keys['ctrl+I'] = stats
