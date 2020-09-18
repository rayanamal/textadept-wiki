## Introduction

Sometimes it is desirable to open Textadept with a file, wait until that file is
closed, and then quit Textadept. For example, this situation applies to using
Textadept as a version control system's commit editor.

Put the following in your *~/.textadept/init.lua*:

    args.register('-w', '--wait', 1, function(filename)
      textadept.session.save_on_quit = false
      io.open_file(filename)
      filename = lfs.abspath(filename)
      events.connect(events.BUFFER_DELETED, function()
        local found = false
        for i = 1, #_BUFFERS do
          if _BUFFERS[i].filename == filename then
            found = true
            break
          end
        end
        if not found then quit() end
      end)
    end, "Opens the given file and quits after closing that file")

Then invoke Textadept like this:

    textadept -f -w [filename]

The `-f` flag forces a new instance of Textadept to open, and the `-w` flag is
the one added above to wait for the opened file to be closed before quitting.
