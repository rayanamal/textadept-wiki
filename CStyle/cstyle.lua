--------------------------------------------------------------------------------
-- The MIT License
--
-- Copyright (c) 2009 Brian Schott
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

--------------------------------------------------------------------------------
-- Functions for C-style languages such as C,C++,C#,D, and Java
--------------------------------------------------------------------------------

require 'common.comments'

--------------------------------------------------------------------------------
-- Selects the scope that the cursor is currently inside of.
--------------------------------------------------------------------------------
function selectScope()
	local cursor = buffer.current_pos
	local depth = -1
	while depth ~= 0 do
		buffer:search_anchor()
		if buffer:search_prev(2097158, "[{}()]") < 0 then break end
		if buffer.current_pos == lockPrevent then break end
		if buffer.current_pos == 0 then break end
		if buffer:get_sel_text():match("[)}]") then
			depth = depth - 1
		else
			depth = depth + 1
		end
	end
	local scopeBegin = buffer.current_pos
	local scopeEnd = buffer:brace_match(buffer.current_pos)
	buffer:set_sel(scopeBegin, scopeEnd + 1)
end

-- Returns true if other functions should try to handle the event
function indent_after_brace()
	local buffer = buffer
	local line_num = buffer:line_from_position(buffer.current_pos)
	local prev_line = buffer:get_line(line_num - 1)
	local curr_line = buffer:get_line(line_num)
	if prev_line:find("{") then
		local indent = buffer.line_indentation[line_num - 1]
		if curr_line:find("}") then
			buffer:new_line()
			buffer.line_indentation[line_num] = indent + buffer.indent
			buffer.line_indentation[line_num + 1] = indent
			buffer:line_up()
			buffer:line_end()
		else
			buffer.line_indentation[line_num] = indent + buffer.indent
			buffer:line_end()
		end
		return false
	else
		return true
	end
end

-- Matches the closing } character with the indent level of its corresponding {
-- Does not properly handle the case of an opening brace inside a string.
function match_brace_indent()
	local buffer = buffer
	local style = buffer.style_at[buffer.current_pos]
	-- Don't do this if in a comment or string
	if style == 3 or style == 2 then return false end
	buffer:begin_undo_action()
	local line_num = buffer:line_from_position(buffer.current_pos)
	local brace_count = 1 -- +1 for closing, -1 for opening
	for i = line_num,0,-1 do
		local il = buffer:get_line(i)
		if il:find("{") then
			brace_count = brace_count - 1
		elseif il:find("}") then
			brace_count = brace_count + 1
		end
		if brace_count == 0 then
			buffer:line_up()
			buffer.line_indentation[line_num] = buffer.line_indentation[i]
			buffer:line_down()
			break
		end
	end
	buffer:end_undo_action()
	return false
end

-- Called this when the enter key is pressed
function enter_key_pressed()
	if buffer:auto_c_active() then return false end
	buffer:new_line()
	buffer:begin_undo_action()
	local cont = indent_after_brace()
	if cont then
		cont = continue_block_comment("/**", "*", "*/", "/%*", "%*", "%*/")
	end
	if cont then
		cont = continue_block_comment("/+", "+", "+/", "/%+", "%+", "%+/")
	end
	if cont then
		cont = continue_line_comment("//", "//")
	end
	buffer:end_undo_action()

end

function endline_semicolon()
	buffer:begin_undo_action()
	buffer:line_end()
	buffer:add_text(';')
	buffer:end_undo_action()
end

function newline_semicolon()
	buffer:begin_undo_action()
	buffer:line_end()
	buffer:add_text(';')
	buffer:new_line()
	buffer:end_undo_action()
end

function newline()
	buffer:begin_undo_action()
	buffer:line_end()
	buffer:new_line()
	buffer:end_undo_action()
end

function openBraceMagic()
	buffer:begin_undo_action()
	buffer:line_end()
	buffer:new_line()
	buffer:add_text("{")
	enter_key_pressed()
	buffer:new_line()
	buffer:add_text("}")
	match_brace_indent()
	buffer:line_up()
	buffer:line_end()
	buffer:end_undo_action()
end

-- Retruns a table consisting of the parts of a chained function call based on
-- the current cursor position.
-- For instance
-- instance.property.method(1, "123", var).
-- will return {"instance", "property", "method"}
function callStack(pos)
	local stack = {}
	local finish = pos - 1
	local start = finish
	while buffer.char_at[start] == string.byte(".") and start >= 0 do
		-- skip balanced parens
		if buffer.char_at[start - 1] == string.byte(")") then
			finish = finish - 1
			local depth = -1
			while depth < 0 and finish >= 0 do
				finish = finish - 1
				local style = buffer.style_at[finish]
				if style ~= 3 and style ~= 2 then
					if buffer.char_at[finish] == string.byte(")") then depth = depth - 1 end
					if buffer.char_at[finish] == string.byte("(") then depth = depth + 1 end
				end
			end
			start = finish
		end
		start = buffer:word_start_position(finish - 1) - 1
		table.insert(stack, 1, buffer:text_range(start + 1, finish))
		finish = start
	end
	return stack
end
