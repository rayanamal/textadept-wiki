**Note: this may no longer be accurate as of Textadept 9.0.** On keyboards with
different locales, Ctrl+ß might be Ctrl+S (assuming the keyboard has an English
'S' instead of 'ß' on it). Similarly, Ctrl-[Cyrillic character] usually
evaluates to Ctrl-[Latin equivalent].

To add locale dependent keyboard short cuts with value below 256, for example
`ß` you could use something like:

    -- Ctrl+ß
    keys['c'..string.char(223)] = function()
      ui.statusbar_text = "Ctrl-ß works."
    end
