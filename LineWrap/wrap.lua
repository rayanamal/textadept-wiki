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
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--------------------------------------------------------------------------------

textadept = _G.textadept

module('_m.common.wrap', package.seeall)

local wrapper_mark = 2

function line_has_marker(line)
	return buffer:marker_get(line) % (2 ^ (wrapper_mark + 1)) >= (2 ^ wrapper_mark)
end

function wrap_lines()
	-- Make the whole operation seem like one action to the user
	buffer:begin_undo_action()

	-- If there is text selected, only wrap the selected lines. Otherwise wrap
	-- the current paragraph
	if #buffer:get_sel_text() == 0 then
		buffer:para_up()
		buffer:para_down_extend()
		buffer:char_left_extend()
	end

	local startLine = buffer:line_from_position(buffer.selection_start)
	local currLine = 0

	-- Strip out the newline characters and fix the spacing
	local indent = buffer.line_indentation[startLine]
	local text = buffer:get_sel_text()
	text = string.gsub(text, "%s+", " ")
	buffer:replace_sel(text)
	buffer.line_indentation[startLine] = indent

	-- Add a blank line at the end of the wrapped area and add a marker
	-- indicating that the loop below should stop
	buffer:goto_line(startLine)
	buffer:line_end()
	buffer:new_line()
	currLine = buffer:line_from_position(buffer.current_pos)
	buffer:marker_add(currLine, wrapper_mark)

	buffer:goto_line(startLine)
	currLine = startLine

	while not line_has_marker(currLine) do
		buffer:goto_pos(buffer:find_column(currLine, buffer.edge_column))
		if buffer.column[buffer.current_pos] < buffer.edge_column then
			-- If the current column is less than the edge column, the line is
			-- not as long as it could be, so bring the next line up to this one
			buffer:line_down()
			buffer:home()
		else
			if not string.char(buffer.char_at[buffer.current_pos]):match(" ") then
				-- Don't move the cursor left if it's at a space or newline
				buffer:word_left()
				if buffer.column[buffer.current_pos] == 0 then
					buffer:word_right_end()
				else
					if not string.char(buffer.char_at[buffer.current_pos]):match("%p") then
						buffer:delete_back()
					end
				end
			else
				buffer:char_right()
				buffer:delete_back()
			end
			buffer:new_line()
		end
		currLine = buffer:line_from_position(buffer.current_pos)
	end

	-- Delete the marker set for the end of the wrap.
	buffer:marker_delete_all(wrapper_mark)
	buffer:end_undo_action()
end
