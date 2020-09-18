This article is about how to add more folding symbols to the Textadept. If you
feel satisfied with default 2 kinds of triangles, this is not for you.

See the screenshot below to get an idea how does it look like:

![Click for better quality](https://foicica.com/wiki/more-fold-markers/file/fold.jpg)

What we need to do is to set proper symbols and colors for 7 different MARKNUMs
in view.lua. Since there're 4 values to set for every MARKNUM I define first a
simple helper function, and then use it:

    local function set_fold_mark(marknum, mark, fore, back, back_selected)
            buffer:marker_define(marknum, mark)
            buffer:marker_set_fore(marknum, fore or 0xFFFFFF)
            buffer:marker_set_back(marknum, back or 0x000000)
            buffer:marker_set_back_selected(marknum, back_selected or 0xFF9900)
    end --func set_fold_mark

    local mark_fore = 0xFFFFFF -- white
    local mark_back = 0x000000 -- black
    local mark_back_selected = 0xFF9900

    set_fold_mark(c.SC_MARKNUM_FOLDEROPEN, c.SC_MARK_BOXMINUS, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDER, c.SC_MARK_BOXPLUS, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDERSUB, c.SC_MARK_VLINE, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDERTAIL, c.SC_MARK_LCORNER, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDEREND, c.SC_MARK_BOXPLUSCONNECTED, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDEROPENMID, c.SC_MARK_BOXMINUSCONNECTED, mark_fore, mark_back, mark_back_selected)
    set_fold_mark(c.SC_MARKNUM_FOLDERMIDTAIL, c.SC_MARK_TCORNER, mark_fore, mark_back, mark_back_selected)

    buffer:marker_enable_highlight(true)

Now there is a single place for each color to amend.

Also note the very last line: it's what turns highlighting current fold block on
(with `mark_back_selected` color).

If you like this, just replace the `-- Fold Margin Markers.`-section in your
*view.lua* with code above.

To amend the size of folder symbols, change `buffer.margin_width_n[2]`.

Also, if you prefer circles or other symbols instead of boxes, you can find
available `SC_MARK_*` in */core/iface.lua*.
