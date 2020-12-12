While editing code, I tend to keep a REPL open in
[tmux](http://tmux.sourceforge.net/) to try out the code I'm writing.

Adding the following code to my *~/.textadept/init.lua* file, enables me to send
the selected text in TextAdept to *tmux* using *Ctrl-t*. A little bit easier for
my fingers ...

    local function send_selection_to_tmux()
      local txt = buffer:get_sel_text();
      spawn("tmux set-buffer '" .. txt .. "\n'");
      spawn("tmux paste-buffer -d");
    end

    keys['ctrl+t'] = send_selection_to_tmux
