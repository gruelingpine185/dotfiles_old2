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
    s(
        {trig = 'inc', dscr = 'Local include'},
        fmta('#include \"<>\"', {i(1, 'header')})
    ),
    -- s(
    --     {trig = 'Inc', dscr = 'External include'},
    --     fmt('#include <()>', {i(1, 'header')}),
    --     {delimiters = '()'}
    -- ),
    s(
        {trig = 'cpp', dscr = 'Extern C guards for C++'},
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
        {trig = 'grd', dscr = 'Header guards'},
        fmta(
            [[
                #ifndef <>
                #define <>


                <>

                #endif // <>
            ]],
            {i(1, 'macro'), rep(1), i(2), rep(1)}
        )
    )
}
