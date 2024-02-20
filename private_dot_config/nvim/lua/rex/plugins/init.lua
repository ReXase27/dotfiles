return {
    {
        "nvim-lua/plenary.nvim",
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

    require("rex.plugins.autoformat"),
    require("rex.plugins.debug"),
}
