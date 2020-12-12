This function will open a terminal window with the working directory set to the
location of the file being edited.

1. Be sure to replace "Terminal" with "gnome-terminal", "konsole", or "xterm" if
   you don't use XFCE's Terminal program.
2. Also check that "--working-directory" is the correct option for setting the
   working directory of your terminal program.

Code:

    function openTerminalHere()
            terminalString = "Terminal"
            pathString = "~"
            if buffer.filename then
                    pathString = buffer.filename:match(".+/")
            end
            io.popen(terminalString.." --working-directory="..pathString.." &")
    end

Assign a key binding to trigger the function. Example:

    keys['ctrl+T'] = openTerminalHere
