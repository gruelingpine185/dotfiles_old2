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
