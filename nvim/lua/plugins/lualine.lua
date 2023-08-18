local status, lualine = pcall(require, 'lualine')
if not status then
    return
end


lualine.setup({
    options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' }
    }
})
