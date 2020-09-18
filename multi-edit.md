## Overview

This modules aims to provide access to some of Scintilla's multi-cursor
features.

## Functions

* `add_position` -- Adds a multi-cursor at the current cursor position.
* `add_multiple` -- Adds cursors on all lines from the first multi-cursor to the
  current cursor, all of which should be at the same column on each line.
* `selectAll` -- Selects all occurrences of the word at the current cursor
  position. This acts like a search-and-replace.

## Download

* [modules/common/multiedit.lua](multi-edit/multiedit.lua)
* [modules/common/findall.lua](multi-edit/findall.lua)

Both of these files are required. Be sure to

    require 'common.multiedit'

## Enabling multiple carets / multiple selection

Place the following in your theme's *buffer.lua*:

    buffer.multiple_selection = true
    buffer.additional_selection_typing = true
    buffer.additional_carets_visible = true

## Example Keybindings

Place the following in *~/.textadept/init.lua*:

    local m_multiedit = _m.common.multiedit
    keys.cj = { m_multiedit.add_position }
    keys.cJ = { m_multiedit.add_multiple }
    keys.cr = { m_multiedit.selectAll }
