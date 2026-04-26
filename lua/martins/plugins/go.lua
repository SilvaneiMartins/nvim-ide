return {
    "ray-x/go.nvim",
    lazy = true,
    ft = { "go", "gomod", "gosum", "gotmpl" },
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
        local go = require("go")

        go.setup({
            go = "go",
            goimport = "gopls",
            gofmt = "goimports",
            max_line_len = 120,
            tag_transform = false,
            test_dir = "",
            comment_placeholder = " ",
            lsp_cfg = false, -- configuramos LSP manualmente
            lsp_gofumpt = false,
            lsp_on_attach = nil,
            verbose = false,
            dap_debug = true,
            dap_debug_keymap = true,
            dap_debug_ui = true,
            notify = true,
            auto_format = true,
            sign_priority = 40,
            diagnostic = {
                hdlr = true,
                underline = true,
                virtual_text = { space = 0 },
                signs = { "error", "warning" },
            },
            linter = "golangci-lint",
            linter_flags = { "--timeout", "5m" },
            lint_on_save = true,
            test_on_save = false,
            test_efm = false,
            test_timeout = "30s",
            test_verbose = false,
            run_in_floaterm = false,
        })

        -- Keymaps para Go
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        -- Executar teste
        keymap.set("n", "<leader>gt", function()
            go.test.test()
        end, vim.tbl_extend("force", opts, { desc = "Run go test" }))

        -- Executar arquivo
        keymap.set("n", "<leader>gr", function()
            go.run.run("normal")
        end, vim.tbl_extend("force", opts, { desc = "Run go file" }))

        -- Build
        keymap.set("n", "<leader>gb", function()
            go.run.build()
        end, vim.tbl_extend("force", opts, { desc = "Build go project" }))

        -- Install
        keymap.set("n", "<leader>gi", function()
            go.run.install()
        end, vim.tbl_extend("force", opts, { desc = "Install go binary" }))

        -- Organizar imports
        keymap.set("n", "<leader>go", function()
            go.imports.add(true)
        end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))

        -- Generate interface
        keymap.set("n", "<leader>gg", function()
            go.impl.interfaces()
        end, vim.tbl_extend("force", opts, { desc = "Generate interface" }))

        -- Generate coverage
        keymap.set("n", "<leader>gcv", function()
            go.coverage.toggle("popup")
        end, vim.tbl_extend("force", opts, { desc = "Toggle coverage" }))
    end,
}
