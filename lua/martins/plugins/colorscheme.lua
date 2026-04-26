return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            local theme = require("martins.core.theme")

            theme.apply()
            theme.setup_commands()
        end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
    { "rebelot/kanagawa.nvim", priority = 1000 },
    { "sainnhe/gruvbox-material", priority = 1000 },
    { "Mofiqul/dracula.nvim", name = "dracula", priority = 1000 },
    { "navarasu/onedark.nvim", priority = 1000 },
    { "EdenEast/nightfox.nvim", priority = 1000 },
    { "shaunsingh/nord.nvim", priority = 1000 },
    { "sainnhe/everforest", priority = 1000 },
}
