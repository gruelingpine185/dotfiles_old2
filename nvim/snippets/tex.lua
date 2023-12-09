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


local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local in_textzone = function()
    return in_mathzone() == 0
end


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
            trig = '([%]])%]',
            dscr = 'Prevent extra close bracket',
            regTrig = true,
            snippetType = 'autosnippet'
        },
        f(function(args, snip) return snip.captures[1] end)
    ),
    s(
        {
            trig = '([%}])%}',
            dscr = 'Prevent extra close brace',
            regTrig = true,
            snippetType = 'autosnippet'
        },
        f(function(args, snip) return snip.captures[1] end)
    ),

    -- general (autosnippets)
    s(
        {
            trig = '(',
            dscr = 'Expand parenthesis',
            snippetType = 'autosnippet'
        },
        fmta('(<>)<>', {i(1), i(2)})
    ),
    s(
        {
            trig = '[',
            dscr = 'Expand square brackets',
            snippetType = 'autosnippet'
        },
        fmta('[<>]<>', {i(1), i(2)})
    ),
    s(
        {
            trig = '{',
            dscr = 'Expand curly brace',
            snippetType = 'autosnippet'
        },
        fmta('{<>}<>', {i(1), i(2)})
    ),

    -- text mode
    s(
        {trig = 'bdef', dscr = 'Begin definition environment'},
        fmta(
            [[
                \begin{definition}[<>
                    <>
                \end{definition}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'beg', dscr = 'Begin example environment'},
        fmta(
            [[
                \begin{example}[<>
                    <>
                \end{example}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'prf', dscr = 'Create proof'},
        fmta(
            [[
                \begin{altproof}[<>]
                    <>
                \end{altproof}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        )
    ),
    s(
        {trig = 'lmm', dscr = 'Create lemma'},
        fmta(
            [[
                \begin{lemma}[<>]
                    <>
                \end{lemma}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'prob', dscr = 'Create problem'},
        fmta(
            [[
                \begin{problem}[<>]
                    <>
                \end{problem}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),

    s(
        {trig = 'sec', dscr = 'Create section'},
        fmta(
            [[
                \section{<>}
                    <>
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'tab', dscr = 'Create table'},
        fmta(
            [[
                \begin{table}[h!]
                    \centering
                    \begin{tabular}{|c|c|c|}
                        \hline
                        <>
                        \hline
                        \hline
                        <>
                        \hline
                        \end{tabular}
                \end{table}
                <>
            ]],
            {i(1, 'names'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'thm', dscr = 'Create theorem'},
        fmta(
            [[
                \begin{theorem}[<>]
                    <>
                \end{theorem}
                <>
            ]],
            {i(1, 'title'), i(2), i(3)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'ba', dscr = 'Begin align environment'},
        fmta(
            [[
                \begin{align}
                    <>
                \end{align}
                <>
            ]],
            {i(1), i(2)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'bm', dscr = 'Begin display math environment'},
        fmta(
            [[
                \[
                    <>
                \]
                <>
            ]],
            {i(1), i(2)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'ol', dscr = 'Begin Ordered list'},
        fmta(
            [[
                \begin{enumerate}
                    \item <>
                \end{enumerate}
                <>
            ]],
            {i(1), i(2)}
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'ul', dscr = 'Begin Unordered list'},
        fmta(
            [[
                \begin{itemize}
                    \item <>
                \end{itemize}
                <>
            ]],
            {i(1), i(2)}
        ),
        {condition = in_textzone}
    ),

    -- text mode (autosnippets)
    s(
        {
            trig = '\'',
            dscr = 'Expand single quote',
            snippetType = 'autosnippet'
        },
        fmta('`<>\'<>', {i(1), i(2)}),
        {condition = in_textzone}
    ),
    s(
        {
            trig = '\"',
            dscr = 'Expand double quote',
            snippetType = 'autosnippet'
        },
        fmta('``<>\'\'<>', {i(1), i(2)}),
        {condition = in_textzone}
    ),
    s(
        {
            trig = 'mm',
            dscr = 'Begin display math environment',
            snippetType = 'autosnippet'
        },
        fmta('$<>$<>', {i(1), i(2)})
    )
}
