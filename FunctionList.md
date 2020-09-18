## Summary

It's very easy to write short functions that make TA much more useful for
editing tasks, but eventually you will reach a point where you run out of
keyboard shortcuts, or you add so many shortcuts that you cannot remember them
all. This short module attempts to solve that problem by allowing you to manage
scripts through a filtered list.

## Code

[MIT Licensed](http://www.opensource.org/licenses/mit-license.php)

    module ("_m.common.functionlist", package.seeall)

    local entries = {}

    -- name = A string representing the function name. Filtering is done based on this parameter
    -- desc = A string describing the function
    -- fun = The function itself
    -- short = An optional string describing any shortcut you may have assigned to this function
    --         This parameter does NOT influence any behavior, but serves as a reminder to the
    --         user
    function addEntry(name, desc, fun, short)
            entries[name] = {func = fun, description = desc, shortcut = short or ""}
    end

    -- Shows the menu and runs the selected command, or does nothing if no command was selected
    function menu()
            items = {}
            for key, value in pairs(entries) do
                    items[#items + 1] = key
                    items[#items + 1] = value.shortcut
                    items[#items + 1] = value.description
            end
            local choice = gui.filteredlist("Functions", {"Name", "Shortcut", "Description"}, items)
            if choice then entries[choice].func() end
    end

## Example usage

    local m_functionlist = _m.common.functionlist
    m_functionlist.addEntry("under", "Convets CamelCase to under_scores",
            function()
                    buffer:replace_sel(buffer:get_sel_text():gsub("(%u)",
                            function(s) return "_"..string.lower(s) end))
            end
    )
