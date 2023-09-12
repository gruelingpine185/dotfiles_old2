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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local in_env = function(env)
    local inside = vim.fn['vimtex#syntax#is_inside'](env)
    return (inside[1] > 0 and inside[2] > 0)
end

local in_enumerate = function()
    return in_env('enumerate')
end

local in_description = function()
    return in_env('description')
end

return {
    -- General
    s(
        {trig = '!', dscr = 'Create outline template'},
        fmta(
            [[
                \documentclass{<>}

                \input{preamble}
                \title{<>}
                \author{Adrian Bostic}
                \date{\today}


                \begin{document}
                    \maketitle

                    <>
                \end{document}
            ]],
            {i(1, 'class'), i(2, 'title'), i(3)}
        )
    ),
    s(
        {trig = '!!', dscr = 'Create preamble template'},
        {t({
            '% Language & encoding',
            '\\usepackage[utf8]{inputenc}',
            '\\usepackage[T1]{fontenc}',
            '\\usepackage[english]{babel}',
            '',
            '% Math',
            '\\usepackage{amsmath, amsfonts, mathtools, amsthm, amssymb}',
            '\\usepackage{mathrsfs}',
            '\\usepackage{bm}',
            '',
            '\\newcommand{\\N}{\\ensuremath{\\mathbb{N}}}',
            '\\newcommand{\\R}{\\ensuremath{\\mathbb{R}}}',
            '\\newcommand{\\Z}{\\ensuremath{\\mathbb{Z}}}',
            '\\newcommand{\\Q}{\\ensuremath{\\mathbb{Q}}}',
            '\\newcommand{\\C}{\\ensuremath{\\mathbb{C}}}',
            '',
            '% Make characters shorter',
            '\\let \\implies \\Rightarrow',
            '\\let \\impliedby \\Leftarrow',
            '\\let \\iff \\Leftrightarrow',
            '\\let \\epsilon \\varepsilon'
        })}
    ),
    s(
        {trig = 'it', dscr = 'Italic text'},
        fmta('\\textit{<>}', {i(1)})
    ),
    s(
        {trig = 'bf', dscr = 'Bold text'},
        fmta('\\textbf{<>}', {i(1)})
    ),
    s(
        {trig = '\'', dscr = 'Single quotes'},
        fmta('`<>\'', i(1))
    ),
    s(
        {trig = '"', dscr = 'Double quotes'},
        fmta('``<>\'\'', i(1))
    ),

    -- Markup
    s(
        {trig = 'sec', dscr = 'Create section'},
        fmta(
            [[
                \section{<>}
                    <>
            ]],
            {i(1, 'title'), i(2)}
        )
    ),
    s(
        {trig = 'ssec', dscr = 'Create section'},
        fmta(
            [[
                \subsection{<>}
                    <>
            ]],
            {i(1, 'title'), i(2)}
        )
    ),

    -- Lists
    s(
        {trig = 'li', dscr = 'List item'},
        {t('\\item ')}
    ),
    s(
        {trig = 'lit', dscr = 'List item (tagged)'},
        fmta('\\item[<>] <>', {i(1, 'tag'), i(2)})
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
                    \item <>
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
                    \item <>
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
                    \item[<>] <>
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
                \begin{displaymath}
                    <>
                \end{displaymath}
            ]],
            {i(1, 'math')}
        )
    ),

    -- Math
    s(
        {trig = 's', dscr = 'Set with set builder notation'},
        fmta('\\{\\, <>\\,\\}', {i(1)})
    ),
    s(
        {trig = 's>=', dscr = 'Expands set notation [x, \\infty)'},
        fmta('[\\, <>, \\infty\\,)', {i(1)})
    ),
    s(
        {trig = 's<=', dscr = 'Expands set notation (\\infty, x]'},
        fmta('(\\infty, <>\\,)', {i(1)})
    ),
    s(
        {trig = 'si', dscr = 'Set inclusive (x, y)'},
        fmta('[\\, <>, <>\\,]', {i(1), i(2)})
    ),
    s(
        {trig = 'sx', dscr = 'Set exclusive (x, y)'},
        fmta('(\\, <>, <>\\,)', {i(1), i(2)})
    ),
    s(
        {trig = 'fn', dscr = 'Expands f(x)'},
        fmta('<>(<>)', {i(1, 'f'), i(2, 'x')})
    ),
    s(
        {trig = 'f/g', dscr = 'Expands a fraction'},
        fmta('\\frac{<>}{<>}', {i(1, 'y'), i(2, 'x')})
        {trig = 'rt', dscr = 'Expands root', snippetType = 'autosnippet'},
        fmta('\\sqrt[<>]{<>} ', {i(2, '2'), i(1, 'x')}),
        {condition = in_mathzone}
    )
}
