--------------------------------------------------------------------------------
-- The MIT License
--
-- Copyright (c) 2010 Brian Schott
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR THERWISE, ARISING FROM,
-- THE SOFTWARE.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- This file provides functions that will automatically close XML tags.
--
-- See the comments above each function for the key bindings that should be used
-- with the various functions. I do not recommend using autoTag in combination
-- with completeClosingTagBracket. The two functions are designed for two
-- different usage styles.
--
-- Changelog:
--     Version 0.8.1 - Aug 16 2010
--        * Fixed a bug in one of the lua patterns. This has the nice
--          side-effect of adding a "grow selection" feature to the
--          selectToMatching function
--     Version 0.8 - Aug 15 2010
--         * Bug fix for unbalanced begin_undo_action / end_undo_action
--         * Added the selectMatchingTagName function
--         * Added the selectToMatching function
--     Version 0.7 - Jun 25 2010
--         * Added the ability to comment out text by selecting it and pressing
--           the "!" key.
--     Version 0.6 - Jun 02 2010
--         * Fixed an infinite loop bug with the singleTag function
--     Version 0.5 - May 17 2010
--         * Added encloseTag function.
--     Version 0.4 - May 15 2010
--         * Added begin_undo_action and end_undo_action to various functions.
--         * Updated documentation comments.
--     Version 0.3 - May 11 2010
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Returns the name of the tag at the current cursor position, or nil
--------------------------------------------------------------------------------
local function currentTagName()
	local style = buffer.style_at[buffer.current_pos]
	if style == 16 or style == 17 then
		local oldPos = buffer.current_pos
		buffer:search_anchor()
		buffer:search_prev(4, "<")
		local restoreStart = buffer.current_pos + 1
		buffer:search_anchor()
		buffer:search_next(2097158, "[ >]")
		local restoreEnd = buffer.anchor - 1
		buffer:set_selection(restoreStart, restoreEnd)
		local tagName = buffer:get_sel_text()
		local backwards = false
		if tagName:match("^/") then
			backwards = true
			restoreStart = restoreStart + 1
			tagName = tagName:sub(2)
		end
		buffer:goto_pos(oldPos)
		return tagName, backwards, restoreStart, restoreEnd
	else
		return nil
	end
end

--------------------------------------------------------------------------------
-- Multi-selects the tag matching the one at the cursor position
--------------------------------------------------------------------------------
function selectMatchingTagName()
	-- Check for tag style
	local tagName, backwards, restoreStart, restoreEnd = currentTagName()
	if tagName == nil then return end
	local depth = 1
	while depth ~= 0 do
		buffer:search_anchor()
		if backwards then
			buffer:search_prev(4, tagName)
		else
			buffer:search_next(4, tagName)
		end

		buffer.current_pos = buffer.current_pos - 1
		if buffer:get_sel_text():match("^<") then
			if backwards then
				depth = depth - 1
			else
				depth = depth + 1
			end
		elseif buffer:get_sel_text():match("^/") then
			if backwards then
				depth = depth + 1
			else
				depth = depth - 1
			end
		end
		buffer.current_pos = buffer.current_pos + 1
		if depth == 0 then
			break
		elseif backwards == false then
			buffer:goto_pos(buffer.anchor)
		end
	end
	buffer:add_selection(restoreStart, restoreEnd)
end

--------------------------------------------------------------------------------
-- Selects all text within the tag containing the cursor
--------------------------------------------------------------------------------
function selectToMatching()
	local oldPos = buffer.current_pos
	local pattern = "<[^>!?]*[^/>]>"
	local count = 1
	local tagName = nil
	-- Search forward, finding all tags. Stop when an end tag is found that did
	-- not have a matching opening tag during this search.
	while count ~= 0 do
		buffer:search_anchor()
		-- Prevent an infinite loop in the (likely) event of malformed xml
		if buffer:search_next(0x00200000, pattern) == -1 then
			buffer:set_sel(oldPos, oldPos)
			return
		end
		if buffer:get_sel_text():match("</") then
			count = count - 1
		else
			count = count + 1
		end
		-- Note the name of the ending tag so that the next loop can run a bit
		-- faster.
		tagName = buffer:get_sel_text():match("</(%S+)>")
		buffer:char_right()
	end
	-- Save the end position of the ending tag
	local endPos = buffer.current_pos
	-- Back up the position of the cursor to before the ending tag
	buffer:search_anchor()
	buffer:search_prev(4, "<")
	-- Search for the matching opening tag
	local startPattern = "</*"..tagName
	count = 1
	while count ~= 0 do
		buffer:search_anchor()
		-- Prevent an infinite loop in the (likely) event of malformed xml
		if buffer:search_prev(0x00200000, startPattern) == -1 then
			buffer:set_sel(oldPos, oldPos)
			return
		end
		if buffer:get_sel_text():match("</") then
			count = count + 1
		else
			count = count - 1
		end
	end
	local startPos = buffer.current_pos
	-- Set the selection
	buffer:set_sel(startPos, endPos)
end

--------------------------------------------------------------------------------
-- For internal use. Returns the name of any tag open at the cursor position
--------------------------------------------------------------------------------
local function findOpenTag()
	local buffer = buffer
	local stack = {}
	local endLine = buffer:line_from_position(buffer.current_pos)
	for i = 0, endLine do
		local first = 0;
		local last = 0;
		text = buffer:get_line(i)
		first, last = text:find("</?[^%s>%?!]+.->", last)
		while first ~= nil and text:sub(first, last):find("/>") == nil do
			local tagName = text:match("<(/?[^%s>%?!]+).->", first)
			if tagName:find("^/") then
				if #stack == 0 then
					return nil
				elseif "/"..stack[#stack] == tagName then
					table.remove(stack)
				else
					break
				end
			else
				table.insert(stack, tagName)
			end
			first, last = text:find("</?[^%s>%?!]+.->", last)
		end
	end
	return stack[#stack]
end

--------------------------------------------------------------------------------
-- Call this one whenever you want a tag closed
--------------------------------------------------------------------------------
function completeClosingTag()
	buffer:begin_undo_action()
	local buffer = buffer
	local tagName = findOpenTag()
	if tagName ~= nil then
		buffer:add_text("</"..tagName..">")
	end
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Call this function when a '>' character is inserted. It is not recommended to
-- use this with autoTag.
--
-- ['>'] = {completeClosingTagBracket},
--------------------------------------------------------------------------------
function completeClosingTagBracket()
	buffer:begin_undo_action()
	local buffer = buffer
	local pos = buffer.current_pos
	buffer:insert_text(pos, ">")
	local tagName = findOpenTag()
	if tagName ~= nil then
		buffer:set_selection(pos + 1, pos + 1)
		buffer:add_text("</"..tagName..">")
	end
	buffer:set_sel(pos + 1, pos + 1)
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Uses the multiple-cursor feature to close tags as you type them. It is not
-- recommended to use this with completeClosingTagBracket
--
-- ['<'] = {autoTag},
--------------------------------------------------------------------------------
function autoTag()
	buffer:begin_undo_action()
	local pos = buffer.current_pos
	buffer:insert_text(pos, "<></>")
	buffer:set_selection(pos + 4, pos + 4, 0)
	buffer:add_selection(pos + 1, pos + 1)
	buffer:end_undo_action()
end

local function toggleComment()
	buffer:begin_undo_action()
	local text = buffer:get_sel_text()
	local first = text:match("<!%-%-(.-)%-%->")
	if first == nil then
		buffer:replace_sel("<!--"..text.."-->")
	else
		buffer:replace_sel(first)
	end
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Opens an XML/HTML comment. Use this only if using autoTag.
--
-- ['!'] = {completeComment},
--------------------------------------------------------------------------------
function completeComment()
	buffer:begin_undo_action()
	local text = buffer:get_sel_text()
	if #text > 0 then
		toggleComment()
	else
		local pos = buffer.current_pos
		buffer:set_selection(pos, pos + 4)
		if buffer:get_sel_text() == "></>" then
			buffer:replace_sel("!--  -->")
			buffer:set_selection(pos + 4, pos + 4)
		else
			buffer:set_selection(pos, pos)
			buffer:add_text("!")
		end
	end
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Call this in response to a ? being inserted. Use this only if using autoTag.
--
-- ['?'] = {completePHP},
--------------------------------------------------------------------------------
function completePHP()
	buffer:begin_undo_action()
	local pos = buffer.current_pos
	buffer:set_selection(pos, pos + 4)
	if buffer:get_sel_text() == "></>" then
		buffer:replace_sel("?php  ?>")
		buffer:set_selection(pos + 5, pos + 5)
	else
		buffer:set_selection(pos, pos)
		buffer:add_text("?")
	end
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Bind this to a '/' character being inserted. This cancels the above function
-- for tags like <br/>. Use this only if using autoTag.
--
-- ['/'] = {singleTag},
--------------------------------------------------------------------------------
function singleTag()
	buffer:begin_undo_action()
	if buffer.selections > 1 then
		local pos = buffer.current_pos
		buffer:set_sel(pos - 1, pos)
		if buffer:get_sel_text() =="<" then
			buffer:set_selection(pos, pos + 4)
			if buffer:get_sel_text() == "></>" then
				buffer:replace_sel("/>")
				buffer:set_selection(pos + 1, pos + 1)
				buffer:end_undo_action()
				return
			else
				buffer:set_selection(pos, pos)
			end
		else
			buffer:set_selection(pos, pos)
		end
		buffer:set_sel(pos, pos + 2)
		local text = buffer:get_sel_text()
		if text == "><" then
			local doKill = true
			while text:find("></[^>%s]+>") == nil do
				if buffer.selection_end == buffer.line_end_position then
					doKill = false
				end
				buffer:char_right_extend()
				text = buffer:get_sel_text()
			end
			buffer:replace_sel("/>")
			buffer:set_selection(pos, pos)
		else
			buffer:set_selection(pos, pos)
			buffer:add_text("/")
		end
	else
		buffer:add_text("/")
	end
	buffer:end_undo_action()
end

function handleBackspace()
	if buffer.selections == 2 then
		buffer:begin_undo_action()
		local pos1 = buffer.current_pos
		buffer:rotate_selection()
		local pos2 = buffer.current_pos
		buffer:set_sel(pos1 - 1, pos1 + 5)
		if buffer:get_sel_text() == "<></>" then
			buffer:replace_sel("")
			buffer:goto_pos(pos1)
			buffer:end_undo_action()
		else
			buffer:set_sel(pos2, pos2)
			buffer:add_selection(pos1, pos1)
			buffer:end_undo_action()
			return false
		end
	else
		return false
	end
end

--------------------------------------------------------------------------------
-- Call this when the spacebar is pressed. Use this only if using autoTag.
--
-- [' '] = {handleSpace},
--------------------------------------------------------------------------------
function handleSpace()
	buffer:begin_undo_action()
	local pos = buffer.current_pos
	if buffer.selections > 1 then
		buffer:clear_selections()
		buffer:set_sel(pos, pos)
		buffer:add_text(" ")
	else
		if #buffer:get_sel_text() > 0 then
			buffer:replace_sel(" ")
		else
			buffer:add_text(" ")
		end
	end
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Enclose the selection in a tag
--------------------------------------------------------------------------------
function encloseTag()
	buffer:begin_undo_action()
	local text = buffer:get_sel_text()
	local start = buffer.selection_start
	buffer:replace_sel("<>"..text.."</>")
	local leftCursorPos = start + 1
	local rightCursorPos = start + 4 + #text
	buffer:set_selection(rightCursorPos, rightCursorPos)
	buffer:add_selection(leftCursorPos, leftCursorPos)
	buffer:end_undo_action()
end

--------------------------------------------------------------------------------
-- Toggles line comments on the selected lines
--------------------------------------------------------------------------------
function toggleLineComment()
	buffer:begin_undo_action()
	local initial = buffer:line_from_position(buffer.current_pos)
	local first = initial
	local last = buffer:line_from_position(buffer.anchor)
	if first > last then first, last = last, first end
	for i = first, last do
		buffer:goto_line(i)
		buffer:home()
		buffer:line_end_extend()
		toggleComment()
	end
	buffer:goto_line(initial)
	buffer:end_undo_action()
end
