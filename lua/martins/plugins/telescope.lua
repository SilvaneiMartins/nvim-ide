return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim", -- integração com Trouble
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },

    cmd = "Telescope",

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")

        telescope.setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                layout_config = {
                    horizontal = { preview_width = 0.55 },
                    vertical = { mirror = false },
                },
                layout_strategy = "horizontal",
                sorting_strategy = "ascending",
                winblend = 10, -- transparência leve
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-t>"] = trouble_telescope.open, -- envia para Trouble
                        ["<esc>"] = actions.close,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-t>"] = trouble_telescope.open,
                    },
                },
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                },
                live_grep = {
                    theme = "ivy",
                },
                oldfiles = {
                    theme = "dropdown",
                    previewer = false,
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    sort_lastused = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- tenta carregar fzf sem quebrar se não existir
        pcall(telescope.load_extension, "fzf")

        -- 🔹 Keymaps aprimorados
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        -- Busca e arquivos
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", vim.tbl_extend("force", opts, { desc = "🔍 Buscar Arquivos" }))
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", vim.tbl_extend("force", opts, { desc = "🔎 Buscar Texto" }))
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", vim.tbl_extend("force", opts, { desc = "📁 Buffers Abertos" }))
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", vim.tbl_extend("force", opts, { desc = "📘 Help Tags" }))
        keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", vim.tbl_extend("force", opts, { desc = "📂 Arquivos Recentes" }))
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", vim.tbl_extend("force", opts, { desc = "⌨️ Keymaps" }))
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", vim.tbl_extend("force", opts, { desc = "📝 TODOs" }))

        -- Integração direta com Trouble
        keymap.set("n", "<leader>fr", "<cmd>TroubleToggle lsp_references<cr>", vim.tbl_extend("force", opts, { desc = "📎 Referências (Trouble)" }))
        keymap.set("n", "<leader>fd", "<cmd>TroubleToggle document_diagnostics<cr>", vim.tbl_extend("force", opts, { desc = "📋 Erros do Documento (Trouble)" }))
        keymap.set("n", "<leader>fw", "<cmd>TroubleToggle workspace_diagnostics<cr>", vim.tbl_extend("force", opts, { desc = "🧩 Erros do Workspace (Trouble)" }))
        keymap.set("n", "<leader>fq", "<cmd>TroubleToggle quickfix<cr>", vim.tbl_extend("force", opts, { desc = "🧰 Quickfix (Trouble)" }))
    end,
}
