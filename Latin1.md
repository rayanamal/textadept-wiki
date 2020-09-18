## Introduction

I'm living in Belgium and we use 3 official languages: Dutch, French and German. With the ISO-Latin-1 character set we can cover most of the characters used.

Our desktops have special keyboards which can handle these characters. But, quite a lot of developers prefer US keyboards and then it is often tedious to enter these accented characters.

So, I came up with a solution for Textadept!

## A small Lua script

I put the function `specialcharinsert` in my `.textadept/init.lua`:

    --[[ This function uses a list of pairs:
        The first element is a mnemonic code for the real character
        The second element is the character in UTF-8.
        Notice that you do not have to restrict yourself to characters.
    --]]
    local function specialcharinsert()
      local chars = {'a', '\195\160',
                    'a', '\195\161',
                    'a', '\195\162',
                    'a', '\195\163',
                    'a', '\195\164',
                    'a', '\195\165',
                    'a', '\195\166',
                    'a', '\195\128',
                    'a', '\195\129',
                    'a', '\195\130',
                    'a', '\195\131',
                    'a', '\195\132',
                    'a', '\195\133',
                    'a', '\195\134',
                    'c', '\195\167',
                    'c', '\195\135',
                    'e', '\195\168',
                    'e', '\195\169',
                    'e', '\195\170',
                    'e', '\195\171',
                    'e', '\195\136',
                    'e', '\195\137',
                    'e', '\195\138',
                    'e', '\195\139',
                    'i', '\195\172',
                    'i', '\195\173',
                    'i', '\195\174',
                    'i', '\195\175',
                    'i', '\195\140',
                    'i', '\195\141',
                    'i', '\195\142',
                    'i', '\195\143',
                    'o', '\195\178',
                    'o', '\195\179',
                    'o', '\195\180',
                    'o', '\195\181',
                    'o', '\195\182',
                    'o', '\195\184',
                    'o', '\195\146',
                    'o', '\195\147',
                    'o', '\195\148',
                    'o', '\195\149',
                    'o', '\195\150',
                    'o', '\195\152',
                    'n', '\195\177',
                    'n', '\195\145',
                    'u', '\195\185',
                    'u', '\195\186',
                    'u', '\195\187',
                    'u', '\195\188',
                    'u', '\195\153',
                    'u', '\195\154',
                    'u', '\195\155',
                    'u', '\195\156',
                    'u', '\195\157',
                    'u', '\195\189',
                    'u', '\195\191',
                    'u', '\195\157',
                    'u', '\195\189',
                    'u', '\195\191',
                    '<', '\194\171',
                    '<', '\194\171\194\187',
                    '<', '\194\187',
                    '>', '\194\171',
                    '>', '\194\171\194\187',
                    '>', '\194\187',
                    '1', '\194\178',
                    '1', '\194\179',
                    '1', '\194\185',
                    '1', '\194\186',
                    '1', '\194\188',
                    '1', '\194\189',
                    '1', '\194\190',
                    '1', '\194\170',
                    '+', '\194\177',
                    '+', '\195\151',
                    '+', '\195\183',
                    '.', '\194\161',
                    '.', '\194\162',
                    '.', '\194\163',
                    '.', '\194\164',
                    '.', '\194\165',
                    '.', '\194\166',
                    '.', '\194\167',
                    '.', '\194\168',
                    '.', '\194\169',
                    '.', '\194\170',
                    '.', '\194\172',
                    '.', '\194\173',
                    '.', '\194\174',
                    '.', '\194\175',
                    '.', '\194\176',
                    '.', '\194\180',
                    '.', '\194\181',
                    '.', '\194\182',
                    '.', '\194\183',
                    '.', '\194\184',
                    '.', '\194\191',
                    '.', '\195\158',
                    '.', '\195\159',
                    '.', '\195\190',}
      local button, i = ui.dialogs.filteredlist{
        title = 'Chars', columns = {'Mnemo', 'Char'}, items = chars
      }
      if button == 1 then
        buffer:insert_text(-1, chars[i * 2])
        buffer:char_right()
      end
    end

## Binding to a key

You can bring this functionality in the user interface by binding it to a key or by putting it in the context menu.

E.g., to bind `specialcharinsert` to `Ctrl+1`, put the following line in
`.textadept/init.lua`:

    keys['c1'] = specialcharinsert

## What about other characters ?

This functionality is not restricted to ISO-Latin-1. Let us add Unicode
Character *GREEK SMALL LETTER ALPHA* (`U+03B1`) with mnemonic letter `a`. The
UTF-8 code for *GREEK SMALL LETTER ALPHA* is `0xCE 0xB1` (hexadecimal notation).
From Lua 5.2 onwards, we can enter in the `chars` table the line

    'a', '\xCE\xB1',

on an appropriate place in *.textadept/init.lua*

## Acknowledgement

*Robert G.* from the Textadept Mailing List made several suggestions to make
this code snippet more useful and instructive.

Thank you

Richard Philips
