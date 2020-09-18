## OVERVIEW

A short description of my most frequently used modules follows.

Following each description is the .zip file that contains those module's text
files.

At a minimum this would consist of:

* the module itself (an init.lua file)
* a README file describing the module and explaining how to incorporate the
  module along with key binding(s) suggestions
* a LICENSE file (MIT license + contact information)
* additional files if needed

A listing of the modules follows:

### CenterLine:

Centers the line containing the cursor and moves to the following line to allow
repetition.

#### Download

[cl.zip](gmc/cl.zip)

### FindSetWord:

Performs a quick forward/backward search for an assigned word. Consists of two
assignable modules: **FindWord** and **SetWord**. The word may be specified by:

* selecting a portion of text which then becomes the sought for word (matches
  within a word)
* providing an optional argument which then becomes the sought for word (matches
  whole word); this provides a convenient way to set persistent bookmarks (e.g.:
  "--\` " within a Lua file)
* having the word at the cursor selected via "SetWord" (matches whole word)

"Word" in this case is defined as a lexical word, i.e.: any sequence of ASCII
characters between 33 and 126, NOT a textadept "word" which is really a
programming language word - however a simple code modification is incorporated
in case you prefer the textadept definition.

The forward/backward nature of the search is specified by the initial argument.
So you may assign key bindings to perform any of the search types mentioned
above (to include multiple, distinct bookmarks),

Finally, the forward/backward search "wraps". That is, it will wrap to the
beginning of document if needed on a forward search, and end of document for a
backward search.

The key to using **FindWord** is that, once the word is "set", it is persistent.
That is, after the word is located, you can change it without modifying the set
word.

#### Download

[fsw.zip](gmc/fsw.zip)

### Quick Format:

Immediately formats the paragraph containing the cursor. The indents are based
on the containing paragraph. The first line of the paragraph determines the
initial paragraph indent and the second line of the paragraph determines the
indent for the remainder. Line wrap is determined by the value of
buffer.edge_column (or a default of "80" if buffer.edge_column < 1).

After formatting, the cursor is positioned on the subsequent paragraph to allow
repetition.

#### Download

[qf.zip](gmc/qf.zip)

### TARP (TextAdept Recorder/Player):

A reasonably complete textadept macro facility. It consists of the following
modules:

* **ToggleMacro**: toggles the macro record state on/off.
* **ReplayMacro**: (re)plays the currently recorded (or loaded) macro.
* **ShowMacro**: allows review (but no modification) of the currently recorded
  (or loaded) macro.
* **SaveMacro**: allows naming and saving to disk the currently recorded macro
  (with comments).
* **LoadMacro**: allows loading any previously saved macro into TARP as the
  currently active macro.

#### Download

[tarp.zip](gmc/tarp.zip)
