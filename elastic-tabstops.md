## What are elastic tabstops?

The elastic tabstops mechanism positions tabstops automatically to fit the text
between them and to align them with matching tabstops on adjacent lines. This
means only a single tab has to be inserted between elements (columns), rather
than inserting manually the required number of spaces or tabs to align elements
on adjacent lines.

Elastic tabstops were invented by Nick Gravgaard in 2006. More information is
available on his website: http://nickgravgaard.com/elastic-tabstops/.

## About this module

This Textadept module was ported by Joshua Krämer from the implementation for
Scintilla available here:
https://github.com/nickgravgaard/ElasticTabstopsForScintilla.

## Usage samples

This image (taken from Nick Gravgaard’s website) shows the automatic
re-alignment of tabstops:

![sample 1](http://666kb.com/i/cx2xunelg7r6598ik.gif)

Those are screenshots of Textadept with the Elastic tabstops module:

![sample 2](http://666kb.com/i/cx3o4dhxby9c7w3fn.png)

![sample 3](http://666kb.com/i/cx2ybf2gq6bm5ub18.png)

![sample 4](http://666kb.com/i/cx2ycat42ebz1awkc.png)

## Installation

Download this file: [init.lua](elastic-tabstops/init.lua) (version 2015-05-16).

Create the folder *~/.textadept/modules/elastic_tabstops/* and place the
downloaded file *init.lua* in it.

Then add the following line to *~/.textadept/init.lua*:

    require('elastic_tabstops').enable()

Restart Textadept. The Elastic tabstops mechanism will now be applied to all
buffers.
