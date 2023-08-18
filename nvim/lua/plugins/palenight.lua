local status, palenight = pcall(require, 'palenightfall')
if not status then
    return
end


palenight.setup({
    transparent = true
})
