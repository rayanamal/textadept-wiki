If you want to close a file by double-clicking in its tab, you must catch the
double-click event over the tab bar in *textadept.c*, notify the lua code using
a new event and finally connect that event to close the selected buffer.

Note that you need to recompile *textadept* in order to apply the changes made
to *textadept.c*

## 1) Catch the event

Locate **t_tabbuttonpress** function in *textadept.c* (near line 1860) and
reeplace it with the following code:

    /** Signal for a tabbar mouse click. */
    static int t_tabbuttonpress(GtkWidget*_, GdkEventButton *event, void*__) {
      if ((event->type != GDK_BUTTON_PRESS || event->button != 3) &&
          (event->type != GDK_2BUTTON_PRESS || event->button != 1)) {
        return FALSE;
      }
      GtkNotebook *tabs = GTK_NOTEBOOK(tabbar);
      for (int i = 0; i < gtk_notebook_get_n_pages(tabs); i++) {
        GtkWidget *page = gtk_notebook_get_nth_page(tabs, i);
        GtkWidget *label = gtk_notebook_get_tab_label(tabs, page);
        int x0, y0;
        gdk_window_get_origin(gtk_widget_get_window(label), &x0, &y0);
        GtkAllocation allocation;
        gtk_widget_get_allocation(label, &allocation);
        if (event->x_root > x0 + allocation.x + allocation.width) continue;
        gtk_notebook_set_current_page(tabs, i);
        if (event->type == GDK_BUTTON_PRESS) {
          //left-click
          return (lL_showcontextmenu(lua, (void *)event, "tab_context_menu"), TRUE);
        }
        //double-click
        lL_event(lua, "tab_double_click", -1);
        return TRUE;
      }
      return FALSE;
    }

## 2) Compile textadept

Follow the instructions given in textadept manual to
[compile from source code](https://orbitalquark.github.io/textadept/manual.html#Compiling).

## 3) Register the new event

Locate **ta_events** in *core/events.lua* (near line 356) and add the new event
`tab_double_click` to the list.

    local ta_events = {
      'appleevent_odoc', 'buffer_after_switch', 'buffer_before_switch',
      'buffer_deleted', 'buffer_new', 'csi', 'error', 'find', 'focus',
      'initialized', 'keypress', 'menu_clicked', 'mouse', 'quit', 'replace',
      'replace_all', 'reset_after', 'reset_before', 'resume', 'suspend',
      'tab_double_click',
      'view_after_switch', 'view_before_switch', 'view_new'
    }

## 4) Process the new event

Finally, connect it in your *init.lua* file:

    events.connect(events.TAB_DOUBLE_CLICK, function() io.close_buffer() end)
