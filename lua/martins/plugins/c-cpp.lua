return {
    "stevearc/overseer.nvim",
    lazy = true,
    ft = { "c", "cpp", "cmake" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local overseer = require("overseer")

        overseer.setup({
            task_list = {
                direction = "bottom",
                min_height = 20,
                max_height = 40,
                default_detail = 1,
            },
            form = {
                border = "rounded",
                zindex = 40,
            },
            confirm = {
                border = "rounded",
                zindex = 40,
            },
            templates = { "builtin", "user" },
            dap = true,
            auto_submit = false,
        })

        -- Registrar tasks customizadas para CMake
        overseer.register_template({
            name = "cmake_configure",
            builder = function()
                return {
                    cmd = "cmake",
                    args = { "-B", "build", "-DCMAKE_BUILD_TYPE=Debug" },
                    cwd = vim.fn.getcwd(),
                }
            end,
            condition = { callback = function() return vim.fn.filereadable("CMakeLists.txt") == 1 end },
        })

        overseer.register_template({
            name = "cmake_build",
            builder = function()
                return {
                    cmd = "cmake",
                    args = { "--build", "build" },
                    cwd = vim.fn.getcwd(),
                }
            end,
            condition = { callback = function() return vim.fn.filereadable("CMakeLists.txt") == 1 end },
        })

        overseer.register_template({
            name = "cmake_test",
            builder = function()
                return {
                    cmd = "ctest",
                    args = { "--output-on-failure" },
                    cwd = vim.fn.getcwd() .. "/build",
                }
            end,
            condition = { callback = function() return vim.fn.filereadable("CMakeLists.txt") == 1 end },
        })

        overseer.register_template({
            name = "cmake_run",
            builder = function()
                return {
                    cmd = "./build/main",
                    cwd = vim.fn.getcwd(),
                }
            end,
            condition = { callback = function() return vim.fn.filereadable("CMakeLists.txt") == 1 end },
        })

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        -- Keymaps para CMake
        keymap.set("n", "<leader>cc", function()
            overseer.run_template({ name = "cmake_configure" })
        end, vim.tbl_extend("force", opts, { desc = "CMake: Configure" }))

        keymap.set("n", "<leader>cb", function()
            overseer.run_template({ name = "cmake_build" })
        end, vim.tbl_extend("force", opts, { desc = "CMake: Build" }))

        keymap.set("n", "<leader>ct", function()
            overseer.run_template({ name = "cmake_test" })
        end, vim.tbl_extend("force", opts, { desc = "CMake: Test" }))

        keymap.set("n", "<leader>cR", function()
            overseer.run_template({ name = "cmake_run" })
        end, vim.tbl_extend("force", opts, { desc = "CMake: Run" }))

        keymap.set("n", "<leader>co", "<cmd>OverseerOpen<CR>", vim.tbl_extend("force", opts, { desc = "Overseer: Open" }))
        keymap.set("n", "<leader>cq", "<cmd>OverseerQuickAction<CR>", vim.tbl_extend("force", opts, { desc = "Overseer: Quick action" }))
    end,
}
