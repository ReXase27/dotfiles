return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
        "folke/neodev.nvim",
    },
    config = function ()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("fidget").setup {}
        require("mason").setup {}

        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls" },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                ["lua_ls"] = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        }

        require("lspconfig").gopls.setup {
            gopls_cmd = { vim.fn.stdpath "data", "mason" },
            fillstruct = "gopls",
            dap_debug = true,
            dap_debug_gui = true
        }
    end
}
