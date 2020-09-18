**Note:** Modern versions of Textadept come with a ".desktop" file in the *src/*
directory. You can place that in *~/.local/share/applications* or wherever your
desktop manager reads them from.

Also, you will likely need to update the `Icon=` value to point to the absolute
path to Textadept's *core/images/textadept.svg* (as noted in the .desktop file).

---

For older versions of Textadept:

## .desktop file

    [Desktop Entry]
    Name=Textadept
    GenericName=Textadept Text Editor
    Comment=Edit text files
    Exec=textadept %U
    Terminal=false
    Type=Application
    StartupNotify=true
    MimeType=text/*;
    Icon=/usr/share/icons/hicolor/scalable/apps/textadept.svg
    Categories=GTK;TextEditor;Development;
    X-GNOME-FullName=Textadept Text Editor

## Installation

1. Modify the line that starts with "Icon=" so that it points to where you've
   actually placed Textadept's icon.
2. Place this file in "~/.local/share/applications/" and call it
   "textadept.desktop".
3. Make sure that the textadept executable is on your $PATH.
4. Textadept should now appear in your Gnome/XFCE/KDE menus.
