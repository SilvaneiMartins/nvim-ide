return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lspsaga").setup({
            ui = {
                border = "rounded",
                code_action = "💡",
            },
            symbol_in_winbar = {
                enable = true,
                separator = " › ",
            },
            lightbulb = {
                enable = false,
            },
            scroll_preview = {
                scroll_down = "<C-f>",
                scroll_up = "<C-b>",
            },
        })

        -- Keymaps para Lspsaga
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
        keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
        keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
        keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
        keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    end,
}
