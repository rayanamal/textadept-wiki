By default, when you run Textadept from the command line with filename
arguments, Textadept will open only those files, and not any files from the
previous session (which is located in *~/.textadept/session*):

    textadept file1 file2 ... fileN

If you want to Textadept to open files from the previous session in addition to
files specified on the command line, you can use the `-s` switch:

    textadept -s session file1 file2 ... fileN

(Note: `session` is the name of the default, previous session.)

However, if you happen to forget the `-s session` parameter, you can still have
Textadept "import" the previous session's files by putting the following in your
*~/.textadept/init.lua* and selecting the "File > Import default session" menu
item.

    local function import_default_session()
      io.close_all_buffers()
      textadept.session.load(_USERHOME..'/session')
      for i = 1, #arg do
        local filename = lfs.abspath(arg[i], arg[-1])
        if lfs.attributes(filename) then -- not a switch
          io.open_file(filename)
        end
      end
    end
    local file_menu = textadept.menu.menubar[_L['_File']]
    table.insert(file_menu, #file_menu - 2,
                {'Import Default Session', import_default_session})
