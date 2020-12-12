## Combining closing and unsplitting a message or error buffer

If you often do an unsplit after closing a message or error buffer you can
combine these into one key command in your *~/.textadept/init.lua*:

    keys['ctrl+w'] = function()
      if buffer._type then
        buffer:close()
        ui.goto_view(-1)
        view:unsplit()
      else
        buffer:close()
      end
    end

NOTE: The above code is simple but doesn't work as intended when you have a
vertical split and you run the program/script in the left hand split. It's a
subtle point but `ui.goto_view(-1)` does not go back to the previously active
view, instead it goes to the view with view number one less than that of the
current view.

To get the desired behavior you need to goto the view above the current view
(the message buffer) before you do the unsplit, the only way I've found to do
this is to recursively search the split table, see `ui.get_split_table()`.

Anyway here's the code that should work regardless of how the views are split.

    function is_view(t)
      return not (t[1] or t[2])
    end

    function get_view_num(v)
      return _G._VIEWS[v]
    end

    -- Find upper view in horizontal split given view number
    -- of the lower view
    -- vnum is view number of lower view in horizontal split
    -- t is the split table to search (recursively)
    -- Returns view number of upper view or 0 if no such view
    function split_walker(vnum, t)
      local result = 0
      if is_view(t) then
        return 0
      else
        if ((not t.vertical) and is_view(t[2])
             and get_view_num(t[2]) == vnum) then
          return get_view_num(t[1])
        else
          result = split_walker(vnum, t[2])
          if result == 0 then
            result = split_walker(vnum, t[1])
          end
        end
      end
      return result
    end

    -- Goto view above the current view if there is one
    function goto_view_above()
        cur_view_num = _G._VIEWS[_G.view]
        t = ui.get_split_table()
        view_above = split_walker(cur_view_num , t)
        if view_above > 0 then
          ui.goto_view(_G._VIEWS[view_above])
        end
    end

    keys['ctrl+w'] = function()
      if buffer._type then
        buffer:close()
        goto_view_above()
        view:unsplit()
      else
        buffer:close()
      end
    end
