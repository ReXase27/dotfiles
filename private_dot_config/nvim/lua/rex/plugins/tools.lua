return {
    "tpope/vim-sleuth",
    "folke/neoconf.nvim",
    { "numToStr/Comment.nvim", opts = {} },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "folke/which-key.nvim",
        even = "VimEnter",
        config = function()
            require("which-key").setup({})
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
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
