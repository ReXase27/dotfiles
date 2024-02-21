return {
    "tpope/vim-sleuth",
    "folke/neoconf.nvim",
    { "folke/which-key.nvim",  opts = {} },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = "onedark",
                component_separators = "|",
                section_separators = "",
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    { "numToStr/Comment.nvim", opts = {} },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require("copilot").setup {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-a>",
                        next = "<C-n>",
                        prev = "<C-p>",
                        dismiss = "<C-c>",
                    },
                },
            }
        end,
    },

    -- languages & libraries
    {
        {
            "ray-x/go.nvim",
            dependencies = {
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
            },
            config = function ()
                require("go").setup {
                    icons = false,
                    dap_debug_keymap = false,
                    dap_debug_gui = false,
                }
            end,
            event = { "CmdlineEnter" },
            ft = { "go", "gomod" },
            build = ':lua require("go.install").update_all_sync()'
        },
        {
            "mrcjkb/rustaceanvim",
            version = "^4",
            ft = { "rust" },
        },
        {
            "https://github.com/apple/pkl-neovim",
            lazy = true,
            event = "BufReadPre *.pkl",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
            },
            build = function ()
                vim.cmd("TSInstall! pkl")
            end,
        },
    },
}
