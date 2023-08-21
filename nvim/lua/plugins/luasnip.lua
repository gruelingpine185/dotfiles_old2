local status, luasnip = pcall(require, 'luasnip')
if not status then
    return
end


require('luasnip.loaders.from_lua').load({
    paths = '~/.config/nvim/snippets/'
})


luasnip.config.set_config({
    history = true,
    update_events = 'TextChanged,TextChangedI',
    enable_atuosnippets = true
})
