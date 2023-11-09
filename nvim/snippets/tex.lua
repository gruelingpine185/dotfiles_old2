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

local in_textzone = function()
    return in_mathzone() == 0
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
        ),
        {condition = in_textzone}
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
        })},
        {condition = in_textzone}
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
        {trig = 'tt', dscr = 'regular text'},
        fmta('\\text{<>}', {i(1)})
    ),
    s(
        {trig = '\'', dscr = 'Single quotes', snippetType = 'autosnippet'},
        fmta('`<>\'', i(1))
    ),
    s(
        {trig = '"', dscr = 'Double quotes', snippetType = 'autosnippet'},
        fmta('``<>\'\'', i(1))
    ),
    s(
        {trig = '(', dscr = 'Parenthesis', snippetType = 'autosnippet'},
        fmta('(<>)', i(1))
    ),
    s(
        {trig = '[', dscr = 'Square brackets', snippetType = 'autosnippet'},
        fmta('[<>]', i(1))
    ),
    s(
        {trig = '{', dscr = 'Curly braces', snippetType = 'autosnippet'},
        fmta('{<>}', i(1))
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
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'ssec', dscr = 'Create section'},
        fmta(
            [[
                \subsection{<>}
                    <>
            ]],
            {i(1, 'title'), i(2)}
        ),
        {condition = in_textzone}
    ),

    -- Lists
    s(
        {trig = '-', dscr = 'List item', snippetType = 'autosnippet'},
        {t('\\item ')},
        {condition = in_enumerate and line_begin}
    ),
    s(
        {trig = '-', dscr = 'List item (tagged)', snippetType = 'autosnippet'},
        fmta('\\item[<>] <>', {i(1, 'tag'), i(2)}),
        {condition = in_description and line_begin}
    ),

    -- Environments
    s(
        {trig = 'dc', dscr = 'Document class'},
        fmta('\\documentclass{<>}', {i(1, 'class')}),
        {condition = in_textzone}
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
        ),
        {condition = in_textzone}
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
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'beg', dscr = 'Begin example environment'}, -- custom
        fmta(
            [[
                \begin{example}[<>
                    <>
                \end{example}
            ]],
            {i(1), i(2)}
        )
    ),
    s(
        {trig = 'ba', dscr = 'Begin align environment'},
        fmta(
            [[
                \begin{align}
                    <>
                \end{align}
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'bdef', dscr = 'Begin definition environment'}, -- custom
        fmta(
            [[
                \begin{definition}[<>]
                    <>
                \end{definition}
            ]],
            {i(1, 'def'), i(2)}
        ),
        {condition = in_textzone}
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
        ),
        {condition = in_textzone}
    ),
    s(
        {trig = 'mm', dscr = 'Begin display math environment', snippetType = 'autosnippet'},
        fmta('$<>$ ', {i(1)})
        -- {condition = in_textzone}
    ),
    -- Math
    s(
        {trig = 'oo', dscr = 'Expands infinity', snippetType = 'autosnippet'},
        t('\\infty'),
        {condition = in_mathzone}
    ),
    s(
        {trig = '\\inftyl', dscr = 'Expands infinity', snippetType = 'autosnippet'},
        t('\\infty^{+}'),
        {condition = in_mathzone}
    ),
    s(
        {trig = '\\inftyr', dscr = 'Expands infinity', snippetType = 'autosnippet'},
        t('\\infty^{-}'),
        {condition = in_mathzone}
    ),
    s(
        {trig = 's>=', dscr = 'Expands set notation [x, \\infty)'},
        fmta('[\\, <>, \\infty\\,)', {i(1)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 's<=', dscr = 'Expands set notation (\\infty, x]'},
        fmta('(\\infty, <>\\,)', {i(1)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'si', dscr = 'Set inclusive (x, y)'},
        fmta('[\\, <>, <>\\,]', {i(1), i(2)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'sx', dscr = 'Set exclusive (x, y)'},
        fmta('(\\, <>, <>\\,)', {i(1), i(2)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'fn', dscr = 'Expands f(x)', snippetType = 'autosnippet'},
        fmta('<>(<>)', {i(1, 'f'), i(2, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'fo', dscr = 'Expands f(x) circle g(x)', snippetType = 'autosnippet'},
        fmta('<> \\circ <>', {i(1, 'f'), i(2, 'g')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = '/', dscr = 'Expands a fraction', snippetType = 'autosnippet'},
        fmta('\\frac{<>}{<>}', {i(1, 'y'), i(2, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'pm', dscr = 'Expands plus or minus', snippetType = 'autosnippet'},
        t('\\pm '),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'rt', dscr = 'Expands root', snippetType = 'autosnippet'},
        fmta('\\sqrt[<>]{<>} ', {i(2, '2'), i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = '-([A-Za-z%d])', dscr = 'Expands negative sign', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return ' -' .. snip.captures[1] end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)-', dscr = 'Expands minus sign', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ' - ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)+', dscr = 'Expands plus sign', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ' + ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)*', dscr = 'Expands multiplication sign', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ' \\cdot ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)/', dscr = 'Expands division sign', snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ' / ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'dlr([%[%(%{])', dscr = 'Expands dynamic separator groups', regTrig = true, snippetType = 'autosnippet'},
        fmta('<>',
            c(
                1,
                {
                    sn(nil, {t('\\left('), i(1), t('\\right)')}),
                    sn(nil, {t('\\left['), i(1), t('\\right]')}),
                    sn(nil, {t('\\left{'), i(1), t('\\right}')})
                }
            )
        ),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'lr([%[%(])', dscr = 'Expands separator groups', regTrig = true, snippetType = 'autosnippet'},
        fmta('<>',
            c(
                1,
                {
                    sn(nil, {t('('), i(1), t(')')}),
                    sn(nil, {t('('), i(1), t(']')}),
                    sn(nil, {t('['), i(1), t(']')}),
                    sn(nil, {t('['), i(1), t(')')}),
                }
            )
        ),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)to', dscr = 'Expands approaches (\\to)', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ' \\to ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.),', dscr = 'Expands comma with space', regTrig = true, snippetType = 'autosnippet'},
        f(function(args, snip) return snip.captures[1] .. ', ' end),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)lim', dscr = 'Expands limit', regTrig = true, snippetType = 'autosnippet'},
        fmta(
            '<>\\lim_{<>}{<>}',
            {f(function(args, snip) return snip.captures[1] end), i(1), i(2)}
        ),
        {condition = in_mathzone}
    ),
    s(
        {trig = '([^%s]+)pp(-?[A-Za-z%d]+)', dscr = 'Expands exponent', regTrig = true, snippetType = 'autosnippet'},
        {f(function(args, snip) return snip.captures[1] .. '^{' .. snip.captures[2] .. '}' end)},
        {condition = in_mathzone}
    ),
    s(
        {trig = '([^%s]+)ss(-?[A-Za-z%d]+)', dscr = 'Expands subscript', regTrig = true, snippetType = 'autosnippet'},
        {f(function(args, snip) return snip.captures[1] .. '_{' .. snip.captures[2] .. '}' end)},
        {condition = in_mathzone}
    ),
    s(
        {trig = '!=', dscr = 'Expands inqeuivelance symbol', snippetType = 'autosnippet'},
        t(' \\neq '),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'apx', dscr = 'Expands approximation symbol', snippetType = 'autosnippet'},
        t(' \\approx'),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'lg', dscr = 'Expands log function', snippetType = 'autosnippet'},
        fmta('\\log_{<>} <>', {i(1), i(2)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'ln', dscr = 'Expands ln function', snippetType = 'autosnippet'},
        fmta('\\ln <> ', {i(1)}),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(%d+)deg', dscr = 'Expands degree symbol', regTrig = true, snippetType = 'autosnippet'},
        {f(function(args, snip) return snip.captures[1] .. '\\degree' end)},
        {condition = in_mathzone}
    ),
    s(
        {trig = 't', dscr = 'Expands theta symbol'},
        t('\\theta'),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'sin', dscr = 'Expands sin symbol', snippetType = 'autosnippet'},
        fmta('\\sin <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'cos', dscr = 'Expands cosine symbol', snippetType = 'autosnippet'},
        fmta('\\cos <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'tan', dscr = 'Expands tangent symbol', snippetType = 'autosnippet'},
        fmta('\\tan <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'csc', dscr = 'Expands cosicant symbol', snippetType = 'autosnippet'},
        fmta('\\csc <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'sec', dscr = 'Expands secant symbol', snippetType = 'autosnippet'},
        fmta('\\sec <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'cot', dscr = 'Expands cotangent symbol', snippetType = 'autosnippet'},
        fmta('\\cot <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'asin', dscr = 'Expands arcsin symbol', snippetType = 'autosnippet'},
        fmta('\\arcsin <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'acos', dscr = 'Expands arccosine symbol', snippetType = 'autosnippet'},
        fmta('\\arccos <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = 'atan', dscr = 'Expands arctangent symbol', snippetType = 'autosnippet'},
        fmta('\\arctan <> ', {i(1, 'x')}),
        {condition = in_mathzone}
    ),
    s(
        {trig = '(.)pi', dscr = 'Expands pi symbol', regTrig = true, snippetType = 'autosnippet'},
        {f(function(args, snip) return snip.captures[1] .. '\\pi' end)},
        {condition = in_mathzone}
    )
}
