-- bootstrap Packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
	    'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end

    return false
end


local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- LaTeX syntax highlighting
    use 'lervag/vimtex'

    -- Risc-V syntax highlighting
    use 'kylelaker/riscv.vim'

    -- use({
    --     'iamcco/markdown-preview.nvim',
    --     run = 'cd app && npm install',
    --     setup = function() vim.g.mkdp_filetypes = {'markdown'} end,
    --     ft = {'markdown'}
    -- })

    -- Start screen
    use {
        'goolord/alpha-nvim',
        config = function() require('plugins.alpha') end
    }

    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup() end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end
    }

    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    }

    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function() require('octo').setup() end
    }
    
    -- Snippet engine
    use {
        'L3MON4D3/LuaSnip',
        tag = 'v2.*',
        config = function() require('plugins.luasnip') end
    }
    
    -- Autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.cmp') end
    }

    use 'saadparwaiz1/cmp_luasnip'
    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Zen mode
    use {
        'Pocco81/true-zen.nvim',
        config = function()
             require('true-zen').setup {}
        end
    }

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('plugins.lualine') end
    }

    -- Git integration
    use 'airblade/vim-gitgutter'

    -- Colorschemes
    use 'AlexvZyl/nordic.nvim'

    use {
        'JoosepAlviste/palenightfall.nvim',
        config = function() require('plugins.palenight') end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
