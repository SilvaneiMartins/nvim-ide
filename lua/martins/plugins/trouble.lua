return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("trouble").setup({
            position = "bottom",
            height = 12,
            icons = true,
            mode = "workspace_diagnostics",
            fold_open = "",
            fold_closed = "",
            group = true,
            padding = true,
            indent_lines = true,
            auto_open = false,
            auto_close = false,
            auto_preview = true,
            use_diagnostic_signs = true,
        })
        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Abrir Trouble" })
    end,
}
