Textadept 11 had a feature that would allow you to load snippets from files inside one or more directories via a `textadept.snippets.paths` table. While Textadept 12 removed this feature, you can still have it by putting the following in your *~/.textadept/init.lua*:

```lua
local paths = {'/tmp/snippets'}
for _, path in ipairs(paths) do
  for basename in lfs.dir(path) do
    local filename = path .. '/' .. basename
    if lfs.attributes(filename, 'mode') ~= 'file' then goto continue end
    local f = io.open(filename)
    local text = f:read('a')
    f:close()
    local lang, trigger, ext = basename:match('^([^.]+)%.?([^.]*)%.?([^.]*)$')
    if type(snippets[lang]) == 'table' then
      snippets[lang][trigger] = text
    elseif ext == '' then
      trigger = lang
      snippets[trigger] = text
    end
    ::continue::
  end
end
```

Snippet filenames have the form "lang.trigger.ext" where *lang* is an optional lexer language the snippet is for, *trigger* is the snippet's trigger text, and *ext* is an optional file extension for the snippet (useful for editing it within Textadept to get syntax highlighting).

For example, suppose the directory */tmp/snippets* contained a *foo* file with the contents "bar", and a *lua.foo.lua* file with the contents "baz". On initialization, Textadept would create a global snippet "foo" that expands to "bar", and a Lua-specific snippet that expands "foo" to "baz".