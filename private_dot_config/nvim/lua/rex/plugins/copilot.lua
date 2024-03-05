return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false,
                    auto_trigger = false,
                    -- debounce = 75,
                    -- keymap = {
                    --     accept = "<C-a>",
                    --     next = "<C-n>",
                    --     prev = "<C-p>",
                    --     dismiss = "<C-c>",
                    -- },
                    panel = { enabled = false },
                },
            })
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup({
                config = function()
                    local has_words_before = function()
                        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                            return false
                        end
                        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                        return col ~= 0
                            and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$")
                                == nil
                    end
                    local cmp = require("cmp")
                    cmp.setup({
                        mapping = {
                            ["<Tab>"] = vim.schedule_wrap(function(fallback)
                                if cmp.visible() and has_words_before() then
                                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                                else
                                    fallback()
                                end
                            end),
                        },
                    })
                end,
            })
        end,
    },
}
