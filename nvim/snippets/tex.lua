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
    -- Lists
    s(
        {trig = 'li', dscr = 'List item'},
        {t('\\item')}
    ),
    s(
        {trig = 'lit', dscr = 'List item (tagged)'},
        fmta('\\item[<>] ', {i(1, 'tag')})
    )
    s(
        {trig = 'ol', dscr = 'Ordered list'},
        fmta(
            [[
                \begin{enumerate}
                    <>
                \end{enumerate}
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'ul', dscr = 'Unordered list'},
        fmta(
            [[
                \begin{itemize}
                    <>
                \end{itemize}
            ]],
            {i(1)}
        )
    ),

}
