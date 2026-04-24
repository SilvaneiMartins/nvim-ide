return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
    },
    event = "VeryLazy",
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    jestConfigFile = "jest.config.js",
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                }),
            },
        })

        -- Keymaps
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        keymap.set("n", "<leader>test", function()
            require("neotest").run.run()
        end, vim.tbl_extend("force", opts, { desc = "Run test" }))

        keymap.set("n", "<leader>testf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, vim.tbl_extend("force", opts, { desc = "Run file tests" }))

        keymap.set("n", "<leader>testa", function()
            require("neotest").run.run(vim.fn.getcwd())
        end, vim.tbl_extend("force", opts, { desc = "Run all tests" }))

        keymap.set("n", "<leader>tests", function()
            require("neotest").summary.toggle()
        end, vim.tbl_extend("force", opts, { desc = "Toggle test summary" }))
    end,
}
