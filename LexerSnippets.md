## Style keywords

Style following occurrences of variable names declared with keyword "var".

    local l = require('lexer')
    local token, style, color, word_match = l.token, l.style, l.color, l.word_match
    local P, R, S = lpeg.P, lpeg.R, lpeg.S

    local M = { _NAME = 'lexer_name' }

    local ws = token(l.WHITESPACE, l.space^1)
    local variable_list = {}
    local variable = token(l.VARIABLE, P('var') * P(function(patt, i)
      variable_list[patt:match('[%w_]+', i)] = true
      return i
    end) * l.word)
    local potential_variable = P(function(patt, i)
      return variable_list[patt:match('[%w_]+', i)] and i or nil
    end) * token(l.VARIABLE, l.word)

    -- identifiers
    local identifier = token(l.IDENTIFIER, l.word)

    M._rules = {
      { 'whitespace', ws },
      { 'variable', variable },
      { 'potential_variable', potential_variable },
      { 'identifier', identifier },
    }

    return M
