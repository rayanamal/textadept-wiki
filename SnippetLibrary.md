## Purpose

This is a place to post snippets that are clever and/or useful.

## Banner Comment

This generates a banner comment that spans the distance between the current
column and the edge column (which I have set at 80).

    banner = [[/%<string.rep("*", buffer.edge_column - buffer.column[buffer.current_pos] - 1)>
     * %0
     %<string.rep("*", buffer.edge_column - buffer.column[buffer.current_pos] - 2)>/]],

## Include Guard

Generates an inclusion Guard for C/C++ header files. Defaults to the file's name without its extension and capitalized.

    incguard = [[#ifndef %1(%<(buffer.filename or ''):match('[^/]*$'):upper():match('^[^%.]+')>)_H
    #define %1_H

    %0

    #endif
    ]]
