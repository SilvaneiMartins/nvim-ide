return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
        "leoluz/nvim-dap-go",
        { "mfussenegger/nvim-dap-lldb", optional = true },
    },
    event = "VeryLazy",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("nvim-dap-virtual-text").setup()

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Python
        require("dap-python").setup()

        -- Go
        require("dap-go").setup()

        -- C/C++ (LLDB)
        dap.adapters.lldb = {
            type = "executable",
            command = "lldb-vscode",
            name = "lldb",
        }
        
        dap.configurations.c = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }
        
        dap.configurations.cpp = dap.configurations.c

        -- Keymaps
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        keymap.set("n", "<leader>dbb", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Toggle breakpoint" }))
        keymap.set("n", "<leader>dbc", dap.continue, vim.tbl_extend("force", opts, { desc = "Continue debugging" }))
        keymap.set("n", "<leader>dbn", dap.step_over, vim.tbl_extend("force", opts, { desc = "Step over" }))
        keymap.set("n", "<leader>dbs", dap.step_into, vim.tbl_extend("force", opts, { desc = "Step into" }))
        keymap.set("n", "<leader>dbo", dap.step_out, vim.tbl_extend("force", opts, { desc = "Step out" }))
        keymap.set("n", "<leader>dbr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "REPL aberto" }))
    end,
}
