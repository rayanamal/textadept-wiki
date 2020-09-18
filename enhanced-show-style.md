This module allows you to enable two features in the "show style" tooltip:

* showing the actual bytes that appear in the saved version of the file, if
  `buffer.encoding` is not `'UTF-8'`
* showing the names of the characters (code points)

Any combination of these options will display acceptably. Being able to see the
names of characters is often handy; it helps you to identify invisible
characters like the infamous byte-order mark (U+FEFF) or the left-to-right mark
(U+200E), and to distinguish look-alikes such as Latin a and Cyrillic а, or
different spellings of the same character such as á (the letter a with an acute
accent as one code point) and á (as two code points). Showing the actual bytes
saved in the file might help with debugging weird encoding issues in a script.

To install, unpack the files from
[the zip](enhanced-show-style/enhanced-show-style.zip) into
*~/.textadept/modules/common/* and insert
`enhanced_show_style = require 'common.enhanced-show-style'` into your
*~/.textadept/init.lua*. To enable the features, set the options
`enhanced_show_style.show_saved_bytes = true` and
`enhanced_show_style.show_codepoint_names = true`.
