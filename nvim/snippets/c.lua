local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep


return {
    -- Macros
    -- s(
    --     {trig = 'Inc', dscr = 'Global include'},
    --     {
    --         t('#include <'),
    --         fmta('<>', i(1, 'header')),
    --         t('>')
    --     }
    -- ),
    s(
        {trig = 'inc', dscr = 'Local include'},
        fmta('#include \"<>\"', {i(1, 'header')})
    ),
    s(
        {trig = '!', dscr = 'Header guards'},
        fmta(
            [[
                #ifndef <>
                #define <>


                <>

                #endif // <>
            ]],
            {i(1, 'macro'), rep(1), i(2), rep(1)}
        )
    ),
    s(
        {trig = '!!', dscr = 'Extern C guards for C++'},
        fmta(
            [[
                #ifdef __cplusplus
                extern "C" {
                #endif // __cplusplus
                <>
                #ifdef __cplusplus
                }
                #endif // __cplusplus
            ]],
            {i(1)}
        )
    ),
    s(
        {trig = 'td', dscr = 'Create typedef'},
        fmta('typedef <> <>;', {i(1, 'type'), i(2, 'name')})
    ),
    s(
        {trig = 'ts', dscr = 'Create typedef struct'},
        fmta('typedef struct <> <>;', {i(1, 'type'), rep(1)})
    ),
    s(
        {trig = 'an', dscr = 'Create NULL check assertion'},
        fmta('assert(<> != NULL);', {i(1, 'ptr')})
    ),
    s(
        {trig = 'if', dscr = 'Create if-statement'},
        fmta(
            [[
                if(<>) {
                    <>
                }
            ]],
            {i(1, 'expr'), i(2)}
        )
    ),
    s(
        {trig = 'ifn', dscr = 'Create if-not statement'},
        fmta(
            [[
                if(!<>) {
                    <>
                }
            ]],
            {i(1, 'expr'), i(2)}
        )
    ),
    s(
        {trig = 'iif', dscr = 'Create inlined if-statement'},
        fmta('if(<>) <>;', {i(1, 'expr'), i(2)})
    ),
    s(
        {trig = 'iifn', dscr = 'Create inlined if-not statement'},
        fmta('if(!<>) <>;', {i(1, 'expr'), i(2)})
    ),
    s(
        {trig = 'new', dscr = 'Malloc check'},
        fmta(
            [[
                <> <> = (<>) malloc(sizeof(<>));
                if(!<>) return <>;
            ]],
            {
                i(1, 'type'), i(2, 'name'), rep(1),
                i(3, 'type'), rep(2), i(4, 'NULL')
            }
        )
    )
}
