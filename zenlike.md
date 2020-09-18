## Summary

This module provides snippets similar to those found in the "Zen Coding" modules
for various other editors.

If you find a bug, please let me know. You can find my email address by looking
at the license block of the script to get my name, and the Textadept mailing
list for my email address. (This wiki is frequented by spammers)

[modules/hypertext/zen.lua](zenlike/zen.lua)

## Suggested key bindings

    ---
    -- Commands for the hypertext module.
    module('_m.hypertext.commands', package.seeall)

    require 'hypertext.zen'

    local function tabkey()
            if _m.textadept.snippets._insert() == true then return true end
            if #buffer:get_sel_text() == 0
                            and _m.hypertext.zen.process_zen() == true then
                    return true
            else
                    return false
            end
    end

    -- hypertext-specific key commands.
    local keys = _G.keys
    if type(keys) == 'table' then
            keys.hypertext = {
                    al = {
                            m = { io.open_file,
                            (_USERHOME..'/modules/hypertext/init.lua'):iconv('UTF-8', _CHARSET) },
                    },
                    ['\t']= {tabkey},
            }
    end

## History

* 0.3 - Added support for the `$` operator. Fixed behavior with the `-` and `_`
  characters. Added a few more tags to the SPECIAL_TAGS table.
* Version 0.2 (Jul 5 2010) Updated to work with Textadept 3.
* Version 0.1 (Jun 5 2010) First 'real' release. Thanks to Robert Gould for
  adding support for more of the Zen syntax and fixing a few bugs.
