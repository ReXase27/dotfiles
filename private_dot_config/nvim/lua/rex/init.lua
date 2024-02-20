vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("rex.config")
require("rex.keymap")
require("rex.lazy")

local rex_group = vim.api.nvim_create_augroup("ReXase27", {})
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

vim.api.nvim_create_autocmd("BufWritePre", {
    group = rex_group,
    callback = function ()
        vim.cmd("silent! %s/\\s\\+$//e")
    end,
    pattern = "*",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = rex_group,
    callback = function (e)
        local nmap = function (keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set("n", keys, func, { buffer = e.buf, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function ()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
        vim.api.nvim_buf_create_user_command(e.buf, "Format", function (_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
    end
})
