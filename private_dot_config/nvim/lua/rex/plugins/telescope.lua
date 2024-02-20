return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function ()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
        config = function ()
            pcall(require("telescope").load_extension, "fzf")

            local function find_git_root()
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir
                local cwd = vim.fn.getcwd()
                if current_file == "" then
                    current_dir = cwd
                else
                    current_dir = vim.fn.fnamemodify(current_file, ":h")
                end

                local git_root = vim.fn.systemlist("git -C " ..
                    vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
                if vim.v.shell_error ~= 0 then
                    print "Not a git repository. Searching on current working directory"
                    return cwd
                end
                return git_root
            end

            local function live_grep_git_root()
                local git_root = find_git_root()
                if git_root then
                    require("telescope.builtin").live_grep {
                        search_dirs = { git_root },
                    }
                end
            end

            vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

            vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
                { desc = "[?] Find recently opened files" })
            vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
                { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>/", function ()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = "[/] Fuzzily search in current buffer" })

            local function telescope_live_grep_open_files()
                require("telescope.builtin").live_grep {
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                }
            end
            vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
            vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin,
                { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
            vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string,
                { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
            vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics,
                { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "[S]earch [R]esume" })

            vim.defer_fn(function ()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = { "c", "cpp", "go", "lua", "rust", "tsx", "javascript", "typescript", "vimdoc", "vim", "bash" },

                    auto_install = false,
                    sync_install = false,
                    ignore_install = {},
                    modules = {},
                    highlight = { enable = true },
                    indent = { enable = true },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<c-space>",
                            node_incremental = "<c-space>",
                            scope_incremental = "<c-s>",
                            node_decremental = "<M-space>",
                        },
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["aa"] = "@parameter.outer",
                                ["ia"] = "@parameter.inner",
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                            },
                        },
                        move = {
                            enable = true,
                            set_jumps = true,
                            goto_next_start = {
                                ["]m"] = "@function.outer",
                                ["]]"] = "@class.outer",
                            },
                            goto_next_end = {
                                ["]M"] = "@function.outer",
                                ["]["] = "@class.outer",
                            },
                            goto_previous_start = {
                                ["[m"] = "@function.outer",
                                ["[["] = "@class.outer",
                            },
                            goto_previous_end = {
                                ["[M"] = "@function.outer",
                                ["[]"] = "@class.outer",
                            },
                        },
                        swap = {
                            enable = true,
                            swap_next = {
                                ["<leader>a"] = "@parameter.inner",
                            },
                            swap_previous = {
                                ["<leader>A"] = "@parameter.inner",
                            },
                        },
                    },
                }
            end, 0)

            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
            }
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

}
