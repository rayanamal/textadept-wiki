As stated in the
[manual](https://orbitalquark.github.io/textadept/manual.html#Themes), you can’t
change GUI controls in Textadept itself. If you want to change the statusbar
color, you have to modify a resource file where GTK+ reads how to draw various
elements of the interface. The file to modify depends on your platform:

* on Linux: *~/.gtkrc-2.0* (create it if needed -- the location can also depend
  on your distro);
* on Windows: *textadept-install-folder\share\themes\MS-Windows\gtk-2.0\gtkrc*;
* on macOS: *Textadept.app/Contents/Resources/share/themes/Gnome-Cupertino/gtk-2.0/gtkrc*.

In this file, paste these lines (obviously replacing “FFFFFF” with the color of your choice):

    style "custombg" { bg[NORMAL] = "#FFFFFF" }
    widget "textadept*" style "custombg"

Note that the color name is not in RGB but in BGR!

Unfortunately there’s no way to change only the statusbar background color: we
can only change the backround color af the whole window. You need to restart
Textadept for the change to take effect, the `reset()` command is not enough in
that case.

Note that this is only for GTK+ 2.

For Windows and macOS, since we modify a Textadept resource file, this has to be
repeated after each update.
