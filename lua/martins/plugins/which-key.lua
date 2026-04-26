return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,

  config = function()
    local wk = require("which-key")

    wk.setup({})

    wk.add({
      -- 🔹 Rust
      { "<leader>r",  group = "Rust" },
      { "<leader>rr", "<cmd>RustRunnables<CR>",       desc = "Runnables" },
      { "<leader>rd", "<cmd>RustDebuggables<CR>",     desc = "Debuggables" },
      { "<leader>rh", "<cmd>RustHoverActions<CR>",    desc = "Hover Actions" },
      { "<leader>re", "<cmd>RustExpandMacro<CR>",     desc = "Expand Macro" },
      { "<leader>rc", "<cmd>!cargo clippy<CR>",       desc = "Rodar Clippy" },
      {
        "<leader>rf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar (RustFmt)",
      },

      -- 🔹 TypeScript
      { "<leader>ts",  group = "TypeScript" },
      { "<leader>tso", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organizar imports" },
      { "<leader>tsr", "<cmd>TypescriptRenameFile<CR>",      desc = "Renomear arquivo" },
      {
        "<leader>tsf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>tsi", "<cmd>TSToolsAddMissingImports<CR>",  desc = "Add imports faltando" },
      { "<leader>tsu", "<cmd>TSToolsRemoveUnused<CR>",       desc = "Remover não usados" },

      -- 🔹 Python
      { "<leader>py",  group = "Python" },
      { "<leader>pyr", "<cmd>!python3 %<CR>",           desc = "Rodar arquivo atual" },
      { "<leader>pyt", "<cmd>!pytest<CR>",              desc = "Rodar pytest" },
      {
        "<leader>pyf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código (Black)",
      },
      { "<leader>pyl", "<cmd>!pylint %<CR>",            desc = "Rodar pylint no arquivo" },

      -- 🔹 JavaScript
      { "<leader>js",  group = "JavaScript" },
      { "<leader>jsr", "<cmd>!node %<CR>",              desc = "Rodar arquivo atual" },
      {
        "<leader>jsf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código (Prettier/ESLint)",
      },
      { "<leader>jso", "<cmd>EslintFixAll<CR>",         desc = "Corrigir com ESLint" },
      { "<leader>jst", "<cmd>!npm test<CR>",            desc = "Rodar test (npm)" },

      -- 🔹 HTML & CSS
      { "<leader>hl",  group = "HTML/CSS" },
      {
        "<leader>hlf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>hlv", "<cmd>EmmetInstall<CR>",         desc = "Emmet Expand" },
      { "<leader>hlp", "<cmd>!prettier --write %<CR>",  desc = "Formatar com prettier" },

      -- 🔹 Lua
      { "<leader>lua",  group = "Lua" },
      {
        "<leader>luaf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>luad", "<cmd>LuaSnipEdit<CR>",          desc = "Editar snippets" },
      { "<leader>luar", "<cmd>luafile %<CR>",            desc = "Rodar arquivo atual" },

      -- 🔹 C/C++
      { "<leader>c",  group = "C/C++" },
      { "<leader>cc", desc = "CMake: Configure" },
      { "<leader>cb", desc = "CMake: Build" },
      { "<leader>ct", desc = "CMake: Test" },
      { "<leader>cR", desc = "CMake: Run" },
      { "<leader>co", desc = "Overseer: Open task list" },
      { "<leader>cq", desc = "Overseer: Quick action" },
      { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch header/source" },
      {
        "<leader>cf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format (clang-format)",
      },

      -- 🔹 Go
      { "<leader>go",  group = "Go" },
      { "<leader>gor", "<cmd>GoRun<CR>",                 desc = "Run" },
      { "<leader>got", "<cmd>GoTest<CR>",                desc = "Test" },
      { "<leader>gob", "<cmd>GoBuild<CR>",               desc = "Build" },
      { "<leader>goi", "<cmd>GoInstall<CR>",             desc = "Install" },
      { "<leader>goo", "<cmd>GoImports<CR>",             desc = "Organize imports" },
      { "<leader>gog", "<cmd>GoImpl<CR>",                 desc = "Generate interface" },
      { "<leader>gocv", "<cmd>GoCoverageToggle<CR>",     desc = "Toggle coverage" },
      {
        "<leader>gof",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format (gofmt)",
      },

      -- 🔹 Diagnostics (Trouble)
      { "<leader>x",  group = "Diagnostics (Trouble)" },
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Erros do Workspace" },
      { "<leader>xf", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Erros do Arquivo Atual" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Lista de soluções rápidas" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Lista de localização" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",        desc = "Referências do LSP" },

      -- 🔹 Debug (DAP)
      { "<leader>db", group = "Debug (DAP)" },
      { "<leader>dbb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
      { "<leader>dbc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
      { "<leader>dbn", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step over" },
      { "<leader>dbs", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step into" },
      { "<leader>dbo", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step out" },
      { "<leader>dbr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "REPL" },

      -- 🔹 Testing (Neotest)
      { "<leader>test", group = "Testing" },
      { "<leader>test", "<cmd>lua require'neotest'.run.run()<CR>", desc = "Run test" },
      { "<leader>testf", "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<CR>", desc = "Run file tests" },
      { "<leader>testa", "<cmd>lua require'neotest'.run.run(vim.fn.getcwd())<CR>", desc = "Run all tests" },
      { "<leader>tests", "<cmd>lua require'neotest'.summary.toggle()<CR>", desc = "Summary" },

      -- 🔹 Git
      { "<leader>git", group = "Git" },
      { "<leader>gitb", "<cmd>GitBlameToggle<CR>", desc = "Git blame" },
    }, {
      mode = "n",
      silent = true,
      noremap = true,
    })
  end,
}
