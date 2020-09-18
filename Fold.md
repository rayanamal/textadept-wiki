## Introduction

One of the reasons that Textadept is a pleasure to use is that the software uses
the available space very efficiently: most of the window is filled with your
text.

Code folding augments this feature. The software which handles the folding is in
*textadept/lexers/lexer.lua*.

The function `M.fold` shows the different ways to accomplish folding:

* If the lexer for your specific programming language contains a `lexer._fold`,
  this function handles the folding specifics
* Otherwise, if the lexer contains a table `lexer._foldsymbols`, folding is
  derived from that table.
* Finally, folding can work through *indentation*

This text shows a simple example of folding by means of `lexer._fold`

## An example

For my job I develop library software. This software is used by people with very
different language backgrounds. Translations are done by means of text files
which contains `lgcodes`. These are identifiers which are then translated in
several languages. Such a text file - developers call them lfiles - is
structured in a very simple way.

An example:

    lgcode colSectionIdentity:
        N: «Identiteit»
        E: «Identity»
        F: «Identité»

    lgcode colSectionIdentityInfo:
        N: «Dit onderdeel van het formulier toont een beknopt
            overzicht van de collecties»
        E: «This part of the form shows a concise overview of
            the collections»
        F: «Cet élément du formulaire affiche un bref aperçu
            des collections»

    lgcode colSectionStatus:
        N: «Status»
        E: «Status»
        F: «Statut»

    lgcode colSectionStatusInfo:
        N: «Dit onderdeel van het formulier toont diverse
            elementen in verband met het bewerken van de
            collectiedata»
        E: «This part of the form shows different elements
            related to editing the collection data»
        F: «Cet élément du formulaire affiche divers éléments
            en rapport avec l'édition des données
            de la collection»

To work easily with this kind of file, I made a lexer for Textadept.
(*.textadept/lexers/lfile.lua*)

## Folding for lfiles

Folding is very simple: a folding point just before `lgcode`. The descriptive
approach - using `lexer._foldsymbols` - is very attractive, but I could not make
it work: beginning folding points are easy but ending folding points are - in
this case at least - more difficult.

So, in the lexer file (*.textadept/lexers/lfile.lua*), I put a function
`M._fold` (`M` is the table which is returned by the lexer file)

    --
    -- Simple folding (documentaton is found in
    -- textadept/lexers/lexer.lua)
    -- Folds *text*, a chunk of text starting at position *start_pos*
    -- on line number *start_line* with a beginning fold level of
    -- *start_level* in the buffer.
    -- Called by the Scintilla lexer; **do not call from Lua**.
    -- @param text The text in the buffer to fold.
    -- @param start_pos The position in the buffer *text* starts at.
    -- @param start_line The line number *text* starts on.
    -- @param start_level The fold level *text* starts on.
    -- @return table of fold levels.
    -- @name _fold
    function M._fold(text, start_pos, start_line, start_level)
      local regex = '^lgcode'
      local header = lexer.FOLD_HEADER
      local folds = {}
      local line_num = start_line
      local current_level = prev_level
      for line in text:gmatch('.-\r?\n') do
        if line:find(regex) then folds[line_num] = header
        else folds[line_num] = header + 1 end
        line_num = line_num + 1
      end
      return folds
    end

This function works very well. I am sure this function can be easily extended in
more complex settings.

Richard Philips
