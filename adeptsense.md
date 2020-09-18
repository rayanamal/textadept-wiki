## Overview

Adeptsense was a Textadept module framework for code autocompletion and
documentation support for programming languages. It was built-in to Textadept
starting from version 3.7 beta up to and including version 7.2.

## Download

Adeptsense is no longer maintained, but is available
[here](adeptsense/adeptsense.lua) and under Textadept's MIT license.

You can place it in *~/.textadept/modules/textadept/* and `require` it from your
*~/.textadept/init.lua*:

    textadept.adeptsense = require('textadept.adeptsense')

## Available Adeptsenses

Adeptsenses for the following languages are available for download (though no
longer maintained):

* [Java](adeptsense/java.zip)
* [PHP](adeptsense/php.zip)
* [RHTML](adeptsense/rhtml.zip)
* [Ruby](adeptsense/ruby.zip)
* [Ruby on Rails](adeptsense/rails.zip) (requires Ruby Adeptsense)

They are normal language modules, so you may place them in your
*~/.textadept/modules/* for installation.

The following Adeptsenses are available for reference, but Textadept's official
modules already have a similar form of autocompletion.

* [Lua](adeptsense/lua.zip)
* [CSS](adeptsense/css.zip)
* [HTML](adeptsense/html.zip)
* [reST](adeptsense/rest.zip)
