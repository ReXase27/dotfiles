return {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function ()
        require("rest-nvim").setup {
            result_split_in_place = false,
            stay_in_current_window_after_split = false,
            skip_ssl_verification = false,
            encode_url = true,
            highlight = {
                enabled = true,
                timeout = 150,
            },
            result = {
                show_url = true,
                show_curl_command = false,
                show_http_info = true,
                show_headers = true,
                show_statistics = false,
                formatters = {
                    json = "jq",
                    html = function (body)
                        return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
                    end
                },
            },
            jump_to_request = false,
            env_file = ".env",
            env_pattern = "\\.env$",
            env_edit_command = "tabedit",
            custom_dynamic_variables = {},
            yank_dry_run = true,
            search_back = true,
        }

        vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>RestNvim", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>rp", "<Plug>RestNvimPreview", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>rl", "<Plug>RestNvimLast", { noremap = true, silent = true })
    end
}
