return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        { "folke/neodev.nvim", opts = {} },
        -- dart & flutter
        {
            "akinsho/flutter-tools.nvim",
            lazy = false,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "stevearc/dressing.nvim",
            },
            config = true,
        },
        {
            "stevearc/conform.nvim",
        },
    },

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("neovim-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
                map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                map("<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "[W]orkspace [L]ist Folders")
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = require("lspconfig")[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        local lsp_config = require("lspconfig")

        lsp_config.rust_analyzer.setup({})
        lsp_config.sourcekit.setup({})
        lsp_config.clangd.setup({
            cmd = { "clangd", "--offset-encoding=utf-16" },
        })
        lsp_config.neocmake.setup({})
        lsp_config.gopls.setup({})

        -- formatting
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                swift = { "swift_format" },
            },
            notify_on_error = false,
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        })
    end,
}
