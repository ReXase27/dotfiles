return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
        notify_on_error = false,
    },
    config = function()
        local slow_format_filetypes = {}
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
            },
            format_on_save = function(bufnr)
                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end
                local function on_format(err)
                    if err and err:match("timeout$") then
                        slow_format_filetypes[vim.bo[bufnr].filetype] = true
                    end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
            end,
        })

        vim.api.nvim_create_user_command("ToggleAutoformat", function(args)
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
    end,
}
