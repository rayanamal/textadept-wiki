Helps with editing Archlinux's PKGBUILD files, as well as launching makepkg commands.

**Author:** [M Rawash](mailto:mrawash@gmail.com)

## Usage

### Commands

Currently there are 5 available commands:

* **Prepare**: launches `makepkg -g` for currently opened PKGBUILD. (keychain:
  `alt+l+p`)
* **Build**: launches `makepkg -f` for currently opened PKGBUILD. (keychain:
  `alt+l+b`)
* **Install**: launches `makepkg -i` for currently opened PKGBUILD. (keychain:
  `alt+l+i`)
* **Source**: launches `makepkg --source -f` for currently opened PKGBUILD.
  (keychain: `alt+l+s`)
* **Clean**: launches `rm -r {src,pkg,*pkg.tar.{gz,xz}}` in the parent directory
  of the currently opened PKGBUILD. (keychain: `alt+l+r`)

Note: due to the limits of `io.popen` in lua, I've introduced another function
that will launch commands in a terminal window, to use this function, add
`use_term=1` in your global, user, or *pkgbuild* own *init.lua* file; you can
change the default terminal (i.e. *xterm*) or how it's executed using the
variables `term_cmd` and `exec_cmd` (both optional), example:

    use_term = 1
    term_cmd='gnome-terminal -t "makepkg" -e '
    function exec_cmd(cmd)
      os.execute(term_cmd..'\"'..cmd..'\" &')
    end

## Snippets

See *snippets.lua* (or press `ctrl+alt+shift+i`) for a list of available
snippets.

## Install

Place the module directory in */usr/share/textadept/modules* or wherever you
load your modules from.

## Download

You can either download the tarball from
[here](ta-pkgbuild/pkgbuild-module-0-3-tar.gz), or
[use the package available in AUR](http://aur.archlinux.org/packages.php?ID=27483)
