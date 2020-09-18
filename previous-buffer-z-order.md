By default Textadept can only switch to the previous buffer in the buffer list,
not the previous buffer actually visited. In order to switch to the most
recently used buffer (z-order), put the following in your
*~/.textadept/init.lua*:

    local last_buffer = buffer
    -- Save last buffer. Useful after ui.switch_buffer().
    events.connect(events.BUFFER_BEFORE_SWITCH,
                  function() last_buffer = buffer end)
    keys[YOUR_KEY_HERE] = function()
      if _BUFFERS[last_buffer] then
        view:goto_buffer(last_buffer)
      end
    end

where `YOUR_KEY_HERE` is your desired key binding (e.g. `'al'` for Alt+L.)

You can also bind a key to `ui.switch_buffer(true)`, which lists buffers in
z-order.
