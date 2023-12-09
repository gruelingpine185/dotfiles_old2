local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep


return {
    -- general regex (autosnippets)
    s(
        {
            trig = '([%(])%)',
            dscr = 'Prevent extra close parenthesis',
            regTrig = true,
            snippetType = 'autosnippet'
        },
        f(function(args, snip) return snip.captures[1] end)
    ),
    s(
        {
            trig = '([%]])%)',
            dscr = 'Prevent extra close bracket',
            regTrig = true,
            snippetType = 'autosnippet'
        },
        f(function(args, snip) return snip.captures[1] end)
    ),
    s(
        {
            trig = '([%}])%)',
            dscr = 'Prevent extra close brace',
            regTrig = true,
            snippetType = 'autosnippet'
        },
        f(function(args, snip) return snip.captures[1] end)
    ),

    -- general (autosnippets)
    s(
        {trig = '(', dscr = 'Expand parenthesis', snippetType = 'autosnippet'},
        fmta('(<>)<>', {i(1), i(2)})
    ),
    s(
        {trig = '[', dscr = 'Expand square brackets', snippetType = 'autosnippet'},
        fmta('[<>]<>', {i(1), i(2)})
    ),
    s(
        {trig = '{', dscr = 'Expand curly brace', snippetType = 'autosnippet'},
        fmta('}<>}<>', {i(1), i(2)})
    ),

    -- text mode (autosnippets)
    s(
        {trig = '\'', dscr = 'Expand single quote', snippetType = 'autosnippet'},
        fmta('`<>\'<>', {i(1), i(2)})
    ),
    s(
        {trig = '\"', dscr = 'Expand double quote', snippetType = 'autosnippet'},
        fmta('``<>\'\'<>', {i(1), i(2)})
    )
}
