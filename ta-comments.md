## Download

[comments.lua](ta-comments/comments.lua)

## Installation

Place the scripts into a folder called "common" in your modules directory. For
example: "~/.textadept/modules/common/comments.lua".

## Usage

Call these functions from the "commands.lua" file for your language. Example:

    ['\n'] = function()
        buffer:new_line()
        buffer:begin_undo_action()
        local cont = continue_block_comment("/*", "*", "*/", "/%*", "%*", "%*/")
        if cont then
            continue_line_comment("//", "//")
        end
        buffer:end_undo_action()
    end,

This will auto-continue comments for languages like C++, and Java. This example
happens to be for C++. The syntax for calling these functions is explained in
the documentation comments of the script. Remember that the `*` and `+`
characters must be escaped with the `%` character when they are used in
patterns.
