If you are on a Unix-based system of some sort there are quite a few useful
command-line utilities available to you. One of these is `bc`, a command-line
calculator. This script runs the currently selected text through `bc`. This
allows you to type "1 + 1" in your textadept buffer, select it, run this
function, and the selected text will be replaced with "2".

Place this in your *~/.textadept/init.lua*

    function replaceMath()
        local text = buffer:get_sel_text()
        local p = io.popen('echo "'..text..'" | bc 2>&1')
        local out = p:read('*all')
        p:close()
        buffer:replace_sel(out:gsub("\n", ""))
    end

    keys['ctrl+M'] = replaceMath

`bc` is quite powerful. Selecting the text

    x = 2
    2 * x

and running this function will replace the text with "4", as you'd expect.

On Debian/Ubuntu based systems you can install `bc` with
`sudo apt-get install bc`.
