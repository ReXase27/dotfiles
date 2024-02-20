return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
        "folke/neodev.nvim",
    },
    config = function ()
        require("mason").setup {}
        require("mason-lspconfig").setup {}
        require("fidget").setup {}
        require("neodev").setup {}

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "gopls" },
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
                                    globals = { "vim" },
                                }
                            }
                        }
                    }
                end,

                ["gopls"] = function ()
                    require("lspconfig").gopls.setup {
                        -- gopls_cmd = { vim.fn.stdpath "data", "mason" },
                        fillstruct = "gopls",
                        dap_debug = true,
                        dap_debug_gui = true
                    }
                end,
            }
        }

        local lspconfig = require("lspconfig")

        lspconfig.dartls.setup {}

        local format_is_enabled = true
        vim.api.nvim_create_user_command("ToggleFormatOnSave", function ()
            format_is_enabled = not format_is_enabled
            print("Setting autoformatting to: " .. tostring(format_is_enabled))
        end, {})

        local _augroups = {}
        local get_augroup = function (client)
            if not _augroups[client.id] then
                local group_name = "kickstart-lsp-format-" .. client.name
                local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                _augroups[client.id] = id
            end

            return _augroups[client.id]
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
            callback = function (args)
                local client_id = args.data.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local bufnr = args.buf

                if not client.server_capabilities.documentFormattingProvider then
                    return
                end

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = get_augroup(client),
                    buffer = bufnr,
                    callback = function ()
                        if not format_is_enabled then
                            return
                        end

                        vim.lsp.buf.format {
                            async = false,
                            filter = function (c)
                                return c.id == client.id
                            end,
                        }
                    end,
                })
            end,
        })
    end
}
