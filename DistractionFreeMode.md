Textadept can mimic the "distraction free" mode other editors may offer, where
most UI elements are hidden leaving just the editor window. Put the following
code in your *~/.textadept/init.lua*:

    local distraction_free = false
    local menubar = textadept.menu.menubar
    local margin_widths = {}
    local update_ui_hook
    local maximized = ui.maximized
    keys['ctrl+f11'] = function()
      if not distraction_free then
        textadept.menu.menubar = nil
        for i = 1, view.margins do
          margin_widths[i] = view.margin_width_n[i]
          view.margin_width_n[i] = 0
        end
        view.h_scroll_bar = false
        view.v_scroll_bar = false
        update_ui_hook = events.connect(events.UPDATE_UI,
                                        function()
          ui.statusbar_text, ui.buffer_statusbar_text = '', ''
        end)
        events.emit(events.UPDATE_UI)
        ui.maximized = true
      else
        textadept.menu.menubar = menubar
        for i = 1, view.margins do
          view.margin_width_n[i] = margin_widths[i]
        end
        view.h_scroll_bar = true
        view.v_scroll_bar = true
        events.disconnect(update_ui_hook)
        ui.maximized = maximized
      end
      distraction_free = not distraction_free
    end

Pressing "Ctrl+F11" will toggle the mode.
