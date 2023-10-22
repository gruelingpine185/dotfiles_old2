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
    number = true,
    conceallevel = 2
}

local globals = {
    mapleader = ';',
    maplocalleader = ',',

    -- latex & vimtex
    tex_flavor = 'latex',
    tex_conceal = 'abdmgs',
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


-- Telescope
keymap('n', '<leader>b', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>t', ':Telescope colorscheme<CR>', opts)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>f', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fb', ':Telescope file_browser<CR>', opts)

-- Vimtex
keymap('n', '<localleader>v', ':call jobstart(\'zathura main.pdf\')<CR>', opts)  -- open zathura
keymap('n', '<localleader>c', ':VimtexCompile<CR>', opts)   -- compiles files
keymap('n', '<localleader>l', ':VimtexClean<CR>', opts)     -- remove extra files

keymap('i', '<a-down>', '<esc>:m .+1<CR>==gi', opts)    -- move line down
keymap('i', '<a-up>', '<esc>:m .-2<CR>==gi', opts)      -- move line up
keymap('n', '<a-down>', ':m .+1<CR>==', opts)           -- move line down
keymap('n', '<a-up>', ':m .-2<CR>==', opts)             -- move like up
keymap('v', '<a-down>', ':m \'>+1<CR>gv=gv', opts)      -- move block down
keymap('v', '<a-up>', ':m \'<-2<CR>gv=gv', opts)        -- move block up

