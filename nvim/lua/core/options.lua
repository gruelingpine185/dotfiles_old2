local options = {
    backup = false,               -- creates a backup file
    clipboard = 'unnamedplus',    -- allows neovim to access the system clipboard
    mouse = 'a',                  -- allow mouse use
    spelllang = 'en_us',
    smartcase = true,             -- smart case
    smartindent = true,           -- make indenting smarter again
    splitbelow = true,            -- force horizontal splits below current window
    splitright = true,            -- force vertical splits right of current window
    swapfile = false,             -- creates a swapfile
    writebackup = false,          -- dont' allow file already opened to be edited
    expandtab = true,             -- convert tabs to spaces
    shiftwidth = 4,               -- number of spaces inserted for each indentation
    tabstop = 4,                  -- insert 2 spaces for a tab
    number = true
}

local globals = {
    mapleader = ';',
    maplocalleader = ',',

    -- latex & vimtex
    tex_flavor = 'latex',
    Tex_DefaultTargetFormat = 'pdf',
    vimtex_view_method = 'zathura',
    vimtex_view_general_viewer = 'zathura',
    vimtex_indent_enabled = 1,
    vimtex_syntax_enabled = 1,
    vimtex_view_enabled = 1,
    vimtex_view_automatic = 1
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(globals) do
    vim.g[k] = v
end


local opts = {noremap = true, silent = true}
local terminal_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap


-- Clear all highlights
keymap('', '<ESC>', ':nohls<CR>', opts)

-- TODO: Gotta get ftplugin/ working
-- TODO: Get a better fix than https://github.com/lervag/vimtex/issues/2203


-- Vimtex
keymap('n', '<localleader>v', ':call jobstart(\'zathura main.pdf\')<CR>', opts)  -- open zathura
keymap('n', '<localleader>c', ':VimtexCompile<CR>', opts)   -- compiles files
keymap('n', '<localleader>l', ':VimtexClean<CR>', opts)     -- remove extra files
