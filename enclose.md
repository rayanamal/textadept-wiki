This module provides additional enclose commands

## Functions

* `enclose_sel`: enclose selection, available without modifier key.
* `paste_or_grow_enclose`: enclose selection, keeping the selection to make
  further enclosing possible, if nothing is selected, paste the char (if
  auto-pairing is not wanted).

## Link

[Github](http://github.com/rgieseke/ta-common/blob/master/enclose.lua)

## Preset keybindings

    keys["'"] = function() enclose_selection("'", "'") end
    keys['"'] = function() enclose_selection('"', '"') end
    keys['('] = function() enclose_selection('(', ')') end
    keys['['] = function() enclose_selection('[', ']') end
    keys['function()'] = function() enclose_selection('function()', '}') end

    keys["c'"] = function() paste_or_grow_enclose("'", "'") end
    keys['c"'] = function() paste_or_grow_enclose('"', '"') end
    keys['c('] = function() paste_or_grow_enclose('(', ')') end
    keys['c['] = function() paste_or_grow_enclose('[', ']') end
    keys['cfunction()'] = function() paste_or_grow_enclose('function()', '}') end
