vim.api.nvim_set_keymap("n", "q", "<Nop>", { desc = "Disable macros" })
vim.api.nvim_set_keymap("n", "Y", "yy$", { desc = "Yank to end of line", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "Move to the left window", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom window", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "Move to the top window", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "Move to the right window", noremap = true, silent = true })
vim.keymap.set("n", "dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.api.nvim_set_keymap(
    "n",
    "<leader>W.",
    "<C-W>s",
    { desc = "Split window horizontally", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-Right>",
    "<C-W-L>",
    { desc = "Move to the right window", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CRC>", { desc = "Resize window up", noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<C-Down>",
    ":resize -2<CR>",
    { desc = "Resize window down", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-Left>",
    ":vertical resize -2<CR>",
    { desc = "Resize window left", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-Right>",
    ":vertical resize +2<CR>",
    { desc = "Resize window right", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", { desc = "Move to the next buffer", noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<S-h>",
    ":bprevious<CR>",
    { desc = "Move to the previous buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { desc = "Exit insert mode", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { desc = "Indent left", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { desc = "Indent right", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"_dP', { desc = "Paste without yanking", noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move line down", noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move line up", noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move line down", noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move line up", noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Move to the left window" })
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Move to the bottom window" })
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Move to the top window" })
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Move to the right window" })
vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- use <C-\><C-n> as a backup
