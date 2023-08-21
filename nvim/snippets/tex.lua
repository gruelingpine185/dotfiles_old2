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
    ),

    -- Environments
    s(
        {trig = 'dc', dscr = 'Document class'},
        fmta('\\documentclass{<>}', {i(1, 'class')})
    ),
    s(
        {trig = 'bd', dscr = 'Begin Document environment'},
        fmta(
            [[
                \begin{document}
                    <>
                \end{document}
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'be', dscr = 'Begin environment'},
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {i(1, 'env'), i(2), rep(1)}
        )
    ),
    s(
        {trig = 'ol', dscr = 'Begin Ordered list'},
        fmta(
            [[
                \begin{enumerate}
                    \list <>
                \end{enumerate}
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'ul', dscr = 'Begin Unordered list'},
        fmta(
            [[
                \begin{itemize}
                    \list <>
                \end{itemize}
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'bdesc', dscr = 'Begin description environment'},
        fmta(
            [[
                \begin{description}
                    \list[<>] <>
                \end{description}
            ]],
            {i(1, 'tag'), i(2)}
        )
    ),
    s(
        {trig = 'bim', dscr = 'Begin inlined math environment'},
        fmta('$<>$', {i(1, 'math')})
    ),
    s(
        {trig = 'bm', dscr = 'Begin display math environment'},
        fmta(
            [[
                \[\[
                    <>
                \]\]
            ]],
            {i(1, 'math')}
        )
    )
}
