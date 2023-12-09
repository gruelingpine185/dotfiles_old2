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
    -- text mode (autosnippet)
    s(
        {trig = '\'', dscr = 'Expand single quote', snippetType = 'autosnippet'},
        fmta('`<>\'<>', {i(1), i(2)})
    ),
    s(
        {trig = '\"', dscr = 'Expand double quote', snippetType = 'autosnippet'},
        fmta('``<>\'\'<>', {i(1), i(2)})
    )
}
