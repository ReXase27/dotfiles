local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim',
        '--branch=stable',
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        'lewis6991/gitsigns.nvim',
        'tpope/vim-sleuth',
        'folke/which-key.nvim',
        'nvim-lualine/lualine.nvim',
        { 'numToStr/Comment.nvim',         opts = {} },
        {
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            opts = {},
        },
        {
            'ellisonleao/gruvbox.nvim',
            priority = 1000,
            config = function () vim.cmd.colorscheme 'gruvbox' end,
        },
        {
            'folke/trouble.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = {},
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
        },

        {
            "rest-nvim/rest.nvim",
            dependencies = { { "nvim-lua/plenary.nvim" } },
            config = function ()
                require("rest-nvim").setup({})
            end
        },

        {
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
            'kristijanhusak/vim-dadbod-ui',
            dependencies = {
                { 'tpope/vim-dadbod',                     lazy = true },
                { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
            },
            cmd = {
                'DBUI',
                'DBUIToggle',
                'DBUIAddConnection',
                'DBUIFindBuffer',
            },
            init = function ()
                vim.g.db_ui_use_nerd_fonts = 1
            end,
        },


        {
            'neovim/nvim-lspconfig',
            { "williamboman/mason.nvim", config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
            'folke/neodev.nvim',
            { 'stevearc/conform.nvim', opts = {} },
            {
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'rafamadriz/friendly-snippets',

            },
            {
                'nvim-treesitter/nvim-treesitter',
                dependencies =
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                },
                build = ':TSUpdate',
                { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
            },
        },

        { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

        {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function ()
                    return vim.fn.executable 'make' == 1
                end
            },
        }
    },

    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()'
    },
    {})

require('neodev').setup()

require 'plugins.telescope'
require 'plugins.treesitter'
require 'plugins.neotree'
