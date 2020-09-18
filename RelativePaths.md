## Purpose

The purpose of this article is to describe how Textadept can be modified to use
relative file references. When implemented Texadept is a truly portable
application. Easy to put on a USB stick to carry around. Or use a synchronising
tool to maintain copies on several machines. Both the Linux and Windows binary
can live in the same folder.

## Steps to make it happen

To make it happen the following utility functions are implemented `stringSplit`,
`pathSplit`, `pathRelative`, `pathBackTrack`. On the test system those functions
are placed in this file: *_USERHOME/modules/pathutils.lua*.

The `load` and `save` functions in *session.lua* are modified. The variable
named filename in both the function call and locally inside the functions, with
different meaning, makes confusions when refactoring the code. So the call
argument is renamed to `filenameSession`. Code is added in the functions to make
filenames in the session file relative to textadept `_HOME`.

## The file-structure

used to implement and test the changes:

    [somepath]/textadept/app_3.7_beta
    [somepath]/textadept/app_3.7_beta_2
    [somepath]/textadept/app_3.7_beta_3
    [somepath]/textadept/data
    [somepath]/textadept/data/core
    [somepath]/textadept/data/modules

In the version folders both the *nix and windows versions are merged together.
Basically a package manager was used to first extract the *nix version. Then the
windows version. The windows extract was not allowed to overwrite anything.

## Initiating textadept

Textadept is initiated like this on the different platforms:

    cd [somepath]/textadept
    ./app_3.7_beta_2/textadept -u ../data/

Or on linux (ubuntu 10.04) with wine

    wine ~/my-apps/textadept/app_3.7_beta_2/textadept.exe -u ../data/

Or on windows (XP personal) ( win+r )

    c:\my-apps\textadept\app_3.7_beta_2\textadept.exe -u ../data/

## Implementing the modifications

### 1: Modify ./core/args.lua

If userhome is given as a relative path (like `-u ../data/`) we need to add the
full path at line 82. `lfs` does not understand paths like this `../data/`

    userhome = arg[i + 1]
    if not lfs.attributes(userhome) then userhome = _G._HOME .. '/' .. userhome end
    break

on the test system `userhome .. "/core/?.lua` is added to the front of
`package.path` (at the bottom of the file). This change makes it possible to
have modified versions of core files in the userhome path. Textadept will use
these development files in require calls and such.

    package.path = userhome .. "/core/?.lua;" .. package.path
    register('-u', '--userhome', 1, function() end, 'Sets alternate _USERHOME')

### 2. _USERHOME/modules/pathutils.lua

    ---[[ I have placed these functions in the above referenced _USERHOME/modules/pathutils.lua
      ---
      -- Splits a string according to a given split pattern.
      -- Compatibility: Lua-5.1
      -- SOURCE: function split(str, pat) in: http://lua-users.org/wiki/SplitJoin
      -- TODO: StringSplit should have a common textadept/lua place to live
      -- @param str The string to be splitted
      -- @param pat The splitt pattern.
      -- @return array containing the splitted string without pat parts.
      -- @usage stringSplit('c:\\windows\\system32\\kernel32.dll', '[^\\/]+')
      function stringSplit(str, pat)
        local t = {}  -- NOTE: use {n = 0} in Lua-5.0
        local fpat = "(.-)" .. pat
        local last_end = 1
        local s, e, cap = str:find(fpat, 1)
        while s do
            if s ~= 1 or cap ~= "" then
        table.insert(t,cap)
            end
            last_end = e+1
            s, e, cap = str:find(fpat, last_end)
        end
        if last_end <= #str then
            cap = str:sub(last_end)
            table.insert(t, cap)
        end
        return t
      end

      ---
      -- Split a path formated string into it''s folder/file parts
      -- TODO: pathSplit belongs in a utility module/file?
      -- @param path The path to be splitted in it's respective parts.
      -- @return array with the path parts.
      -- @usage parts = pathSplit('c:\\users\\guest/documents/myNotes.txt')
      function pathSplit(path)
        local pat =  '[\\/]+'
        return stringSplit(path, pat)
      end
      ---
      -- Compares the path parts of two paths and returns the common part and the unique parts.
      -- TODO: pathRelative belongs in a utility module/file?
      -- @param path1 A path formated string
      -- @param path2 A path formated string
      -- @param sep Optional path sepperator. Defaults to the pattern '/'. The returned paths use this seperator. If the returned result is to be passed on to cmd.exe you need to use sep='\\'
      -- @return commonPath, path1r, path2r
      -- @usage commonPath, path1r, path2r = pathRelative('c:\\users\\guest\\apps\\textadeapt\\3.7Beta\\', 'c:\\users\\guest\\docs\\notes\\mynote.txt'); assert(commonPath=='c:/users/guest/'); assert( path1r=='/apps/textadeapt/3.7Beta/'); assert( path2r=='/docs/notes/mynote.txt')
      function pathRelative(path1, path2, sep)
        sep = sep or "/"

        local a1 = pathSplit(path1)
        local a2 = pathSplit(path2)
        local i
        local c=0
        local maxn=0
        local pathCommon
        local path1r = ''
        local path2r = ''
        maxn = table.maxn(a1)
        if maxn > table.maxn(a2) then maxn = table.maxn(a2) end
        for i = 1, maxn do
          if a1[i] == a2[i] and c==0 then
            if pathCommon == nil then
              pathCommon = a1[i]
            else
              pathCommon = pathCommon .. sep .. a1[i]
            end
          else
            if c==0 then c=i end
              path1r = path1r .. sep .. a1[i]
              path2r = path2r .. sep .. a2[i]
          end

        end
        if table.maxn(a1) > table.maxn(a2) then
          for i = table.maxn(a2)+1, table.maxn(a1) do
            path1r = path1r .. sep .. a1[i]
          end
        elseif table.maxn(a1) < table.maxn(a2) then
          for i = table.maxn(a1)+1, table.maxn(a2) do
            path2r = path2r .. sep .. a2[i]
          end
        end
        return pathCommon, path1r, path2r
      end
      ---
      -- @param path The path we want to walk/refrence backwards.
      -- @param backcmd The pattern used to walk/reference backwards. Defaults to ..
      -- @return The command needed to walk/reference backwards
      -- @usage ret = pathBackTrack('/apps/textadept/3.7Beta/'); assert(ret == '/../../../')
      -- TODO: pathBackTrack belongs in a utility module/file
      function pathBackTrack(path, backcmd)
        backcmd = backcmd or '%.%.'
        return string.gsub(path, '[^\\/]+', backcmd)
      end
    --]]

### 3: Modify _HOME/modules/textadept/session.lua

Save the modified version in *_USERHOME/modules/textadept/session.lua* if you
modified package.path as described above.

    -- Copyright 2007-2011 Mitchell mitchell<att>caladbolg.net. See LICENSE.

    require 'pathutils' -- On my system: _USERHOME/modules/pathutils.lua

    local L = _G.locale.localize

    ---
    -- Session support for the textadept module.
    module('_m.textadept.session', package.seeall)

    -- Markdown:
    -- ## Settings
    --
    -- * `DEFAULT_SESSION`: The path to the default session file.
    -- * `SAVE_ON_QUIT`: Save the session when quitting. Defaults to true and can be
    --   disabled by passing the command line switch '-n' or '--nosession' to
    --   Textadept.

    -- settings
    DEFAULT_SESSION = _USERHOME..'/session'
    SAVE_ON_QUIT = true
    -- end settings

    ---
    -- Loads a Textadept session file.
    -- Textadept restores split views, opened buffers, cursor information, and
    -- project manager details.
    -- @param filenameSession The absolute path to the session file to load. Defaults to
    --   DEFAULT_SESSION if not specified.
    -- @return true if the session file was opened and read; false otherwise.
    -- @usage _m.textadept.session.load(filename)
    function load(filenameSession)
      local not_found = {}
      local f = io.open(filenameSession or DEFAULT_SESSION, 'rb')
      if not f then
        io.close_all()
        return false
      end
      local current_view, splits = 1, { [0] = {} }
      local lfs_attributes = lfs.attributes
      for line in f:lines() do
        if line:find('^buffer:') then
          local anchor, current_pos, first_visible_line, filename =
            line:match('^buffer: (%d+) (%d+) (%d+) (.+)$')

          filename2, foo = string.gsub(filename, "%[TEXTADEPTHOME%]", _G._HOME)

          if not filename2:find('^%[.+%]$') then
            -- message and error buffer?
            if lfs_attributes(filename2) then
              io.open_file(filename2)
            else
              not_found[#not_found + 1] = filename2
            end
          else
            --any file
            new_buffer()
            buffer._type = filename2
            events.emit('file_opened', filename2)
          end

          -- Restore saved buffer selection and view.
          local anchor = tonumber(anchor) or 0
          local current_pos = tonumber(current_pos) or 0
          local first_visible_line = tonumber(first_visible_line) or 0
          local buffer = buffer
          buffer._anchor, buffer._current_pos = anchor, current_pos
          buffer._first_visible_line = first_visible_line
          buffer:line_scroll(0,
            buffer:visible_from_doc_line(first_visible_line))
          buffer:set_sel(anchor, current_pos)

        elseif line:find('^%s*split%d:') then
          -- Restore splitt's'
          local level, num, type, size =
            line:match('^(%s*)split(%d): (%S+) (%d+)')
          local view = splits[#level] and splits[#level][tonumber(num)] or view
          splits[#level + 1] = { view:split(type == 'true') }
          splits[#level + 1][1].size = tonumber(size) -- could be 1 or 2
        elseif line:find('^%s*view%d:') then

          local level, num, buf_idx = line:match('^(%s*)view(%d): (%d+)$')
          local view = splits[#level][tonumber(num)] or view
          buf_idx = tonumber(buf_idx)
          if buf_idx > #_BUFFERS then buf_idx = #_BUFFERS end
          view:goto_buffer(buf_idx)
        elseif line:find('^current_view:') then
          -- Set current view/focus buffer
          local view_idx = line:match('^current_view: (%d+)')
          current_view = tonumber(view_idx) or 1
        elseif line:find('^size:') then
          --Set window size
          local width, height = line:match('^size: (%d+) (%d+)$')
          if width and height then gui.size = { width, height } end
        end
      end
      -- Close session file
      f:close()
      -- Update GUI
      _VIEWS[current_view]:focus()
      _SESSIONFILE = filenameSession or DEFAULT_SESSION
      if #not_found > 0 then
        -- Display error/notify msg.
        gui.dialog('msgbox',
                  '--title', L('Session Files Not Found'),
                  '--text', L('The following session files were not found'),
                  '--informative-text',
                  string.format('%s', table.concat(not_found, '\n')))
      end
      return true
    end


      events.connect('arg_none', function() if SAVE_ON_QUIT then load() end end)

    ---
    -- Saves a Textadept session to a file.
    -- Saves split views, opened buffers, cursor information, and project manager
    -- details.
    -- @param filenameSession The absolute path to the session file to save. Defaults to
    --   either the current session file or DEFAULT_SESSION if not specified.
    -- @usage _m.textadept.session.save(filename)
    function save(filenameSession)
      local session = {}
      local buffer_line = "buffer: %d %d %d %s" -- anchor, cursor, line, filename
      local split_line = "%ssplit%d: %s %d" -- level, number, type, size
      local view_line = "%sview%d: %d" -- level, number, doc index
      -- Write out opened buffers.
      for _, buffer in ipairs(_BUFFERS) do
        local filename = buffer.filename or buffer._type

        --Filter out [MESSAGES] buffers
        if not filename:match('^%[.*%]$') then
          local current = buffer.doc_pointer == gui.focused_doc_pointer
          local anchor = current and 'anchor' or '_anchor'
          local current_pos = current and 'current_pos' or '_current_pos'
          local top_line = current and 'first_visible_line' or '_first_visible_line'
          -- Make a relative file reference
          local filename2
          local pathCommon, path1r, path2r
          pathCommon, path1r, path2r = pathRelative(_G._HOME, filename)
          if pathCommon == nil then
            -- can''t find common path so use original filename
            filename2 = filename
          else
            filename2 = "[TEXTADEPTHOME]/" .. pathBackTrack(path1r) .. path2r
          end
          -- Buld array with session info
          session[#session + 1] = buffer_line:format(buffer[anchor] or 0,
                                                    buffer[current_pos] or 0,
                                                    buffer[top_line] or 0,
                                                    filename2)
        end
      end
      -- Write out split views.
      local function write_split(split, level, number)
        local c1, c2 = split[1], split[2]
        local vertical, size = tostring(split.vertical), split.size
        local spaces = (' '):rep(level)
        session[#session + 1] = split_line:format(spaces, number, vertical, size)
        spaces = (' '):rep(level + 1)
        if type(c1) == 'table' then
          write_split(c1, level + 1, 1)
        else
          session[#session + 1] = view_line:format(spaces, 1, c1)
        end
        if type(c2) == 'table' then
          write_split(c2, level + 1, 2)
        else
          session[#session + 1] = view_line:format(spaces, 2, c2)
        end
      end -- local function write_split end
      local splits = gui.get_split_table()
      if type(splits) == 'table' then
        write_split(splits, 0, 0)
      else
        session[#session + 1] = view_line:format('', 1, splits)
      end
      -- Write out the current focused view.
      local current_view = view
      for i = 1, #_VIEWS do
        if _VIEWS[i] == current_view then
          current_view = i
          break
        end
      end
      session[#session + 1] = ("current_view: %d"):format(current_view)
      -- Write out other things.
      local size = gui.size
      session[#session + 1] = ("size: %d %d"):format(size[1], size[2])
      -- Write the session.

      local f = io.open(filenameSession or _SESSIONFILE or DEFAULT_SESSION, 'wb')
      if f then
        f:write(table.concat(session, '\n'))
        f:close()
      end
    end --function save

      events.connect('quit', function() if SAVE_ON_QUIT then save() end end, 1)

      local function no_session() SAVE_ON_QUIT = false end
      args.register('-n', '--nosession', 0, no_session, 'No session functionality')

    --[[
    if not package.loaded['session'] then
      print("Run self test: session.lua")

      print("End self test: session.lua SUCCESS")
    end
    --]]

## A typical session file

looks like this

    buffer: 3907 3907 109 [TEXTADEPTHOME]//../data/modules/textadept/session.lua
    buffer: 306 306 0 [TEXTADEPTHOME]//../data/session
    buffer: 395 395 0 [TEXTADEPTHOME]//../data/init.lua
    buffer: 2288 2288 48 [TEXTADEPTHOME]//core/args.lua
    buffer: 0 0 0 [TEXTADEPTHOME]//../app_3.7_beta_2_org/core/args.lua
    buffer: 4789 4789 65 [TEXTADEPTHOME]//../app_3.7_beta_2_org/modules/textadept/session.lua
    buffer: 2781 2781 78 [TEXTADEPTHOME]//../data/modules/pathutils.lua
    buffer: 2013 2013 5 [TEXTADEPTHOME]//../data/modules/pathutils-test.lua
    split0: true 705
    view1: 1
    split2: false 451
      view1: 8
      view2: 9
    current_view: 1
    size: 1280 949

## Tested with

This was written and tested with `textadept_3.7_beta_2`. It seems to work with
`textadept_3.7_beta_3`. When moving to the new release the described
modifications in *[TA-PATH]/core/args.lua* was implemented. After that the new
release was tested on Ubuntu 10.04, windows XP and running with wine on Ubuntu.

## Hacking further

If you like to hack on Textadept and implement the suggested changes in
*args.lua*. Then you might want to make sure *args.lua* is processed before any
of the other core files by moving the line `require 'args.lua'` so it is the
first to be loaded in *_HOME/core/init.lua*

## New releases of Textadept

Changes to *args.lua* (and *_HOME/core/init.lua*) has to be done in each new
release until (by popular demand) the changes are implemented in the
distribution.
