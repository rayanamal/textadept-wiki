## XML tag closing script

[xmlcomplete.lua](XmlComplete/xmlcomplete.lua)

The goal of this script is to significantly drop the number of keystrokes needed
while composing XML and XHTML.

## Features

* Contains functions for closing XML tags as you type.
* Contains a function to close any tags in the document that are open at the current line.
* Contains a function to auto-close comments.
* Contains a function to auto-close PHP blocks.

## Installation

1. Enable multiple selection and multiple carets. This is necessary for the
   complete-as-you-type feature to work.
2. Place the script in *~/.textadept/modules/common/*.
3. `'require'` it from your xml and/or hypertext modules.
4. Assign key commands to the functions.

## Enabling multiple carets / multiple selection

Place the following in your theme's *buffer.lua*:

    buffer.multiple_selection = true
    buffer.additional_selection_typing = true
    buffer.additional_carets_visible = true

## Suggested key bindings

    ---
    -- Commands for the hypertext module.
    module('_m.hypertext.commands', package.seeall)

    require 'common.xmlcomplete'

    -- hypertext-specific key commands.
    local keys = _G.keys
    if type(keys) == 'table' then
            keys.hypertext = {
                    al = {
                            m = { io.open_file,
                            (_USERHOME..'/modules/hypertext/init.lua'):iconv('UTF-8', _CHARSET) },
                    },
                    ['cs\n'] = {completeClosingTag},
                    ['<'] = {autoTag},
                    ['/'] = {singleTag},
                    ['!'] = {completeComment},
                    ['?'] = {completePHP},
                    [' '] = {handleSpace},
                    cM = {selectToMatching},
                    cN = {selectMatchingTagName},
            }
    end

## Bugs

Inserting the less-than operator ("<") in PHP code while this module is
activated will not work as desired because of the automatic tag closing key
binding. I'm investigating a way around this.

## Changelog

* Version 0.8.1 - Aug 16 2010

    + Fixed a bug in one of the lua patterns. This has the nice side-effect of adding a "grow selection" feature to the selectToMatching function.

* Version 0.8 - Aug 15 2010

    + Bug fix for unbalanced beginundoaction / endundoaction.
    + Added the selectMatchingTagName function.
    + Added the selectToMatching function.

* Version 0.7 - Jun 25 2010

    + Added the ability to comment out text by selecting it and pressing the "!" key.

* Version 0.6 - Jun 02 2010

    + Fixed an infinite loop bug with the singleTag function.
* Version 0.5 - May 17 2010

    + Added encloseTag function.
* Version 0.4 - May 15 2010

    + Added beginundoaction and endundoaction to various functions.
    + Updated documentation comments.

* Version 0.3 - May 11 2010

## XML Reformatting function

This may only work on non-Windows systems. Requires HTML Tidy.

    local function reformat()
            local tidyString = 'tidy -i -xml -q -w '..buffer.edge_column
                    ..'  --indent-spaces '..buffer.indent..' --tab-size '..buffer.tab_width
            local text = buffer:get_text():gsub('"', '\\"')
            local p = io.popen('echo "'..text..'" | '..tidyString..' 2>&1')
            local out = p:read('*all')
            p:close()
            if buffer.use_tabs then
                    out = out:gsub(string.rep(" ", buffer.indent), "\t")
            end
            buffer:set_text(out)
    end
