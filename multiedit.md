## [multiedit.lua](https://github.com/sneusse/ta-stuff/blob/master/multiedit.lua)

This is a drop-in replacement for most of the text navigation (cleft, cright,
csleft, csright, ...) supporting multiple cursors. The behaviour mimics the one
of sublime (or the one I would expect).

Also, I rolled a custom 'select word' function, which behaves more like the one
in sublime (yeah again...). It features a wrap around and updates your statusbar
where it tells you how often the word has been found. Furthermore, if you have
an active selection it will search for that one *exactly*. To fix some issues
with multi selection navigation, the selections (which can be from left to right
or from right to left) are layouted to be the same direction as the initial one.

## Parameters

There is one parameter to tune (`STAY_IN_LINE`) which will prevent the user from
navigating beyond the end or before the start of the line containing the
selection. True is the default as I prefer this behaviour.

## Misc notes

`buffer.multi_paste = buffer.MULTIPASTE_EACH` should be set, but does not work
as expected imho.

[View on github](https://github.com/sneusse/ta-stuff/)
