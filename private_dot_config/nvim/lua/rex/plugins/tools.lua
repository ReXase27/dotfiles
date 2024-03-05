return {
    "tpope/vim-sleuth",
    "folke/neoconf.nvim",
    { "folke/which-key.nvim", opts = {} },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    { "numToStr/Comment.nvim", opts = {} },

    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup()

            local statusline = require("mini.statusline")
            statusline.setup()
        end,
    },

    {
        "https://github.com/apple/pkl-neovim",
        lazy = true,
        event = "BufReadPre *.pkl",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        build = function()
            vim.cmd("TSInstall! pkl")
        end,
    },

    {
        "saecki/crates.nvim",
        config = function()
            require("crates").setup({})
        end,
    },
}
