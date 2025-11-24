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
      { "<leader>t",  group = "TypeScript" },
      { "<leader>to", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organizar imports" },
      { "<leader>tr", "<cmd>TypescriptRenameFile<CR>",      desc = "Renomear arquivo" },
      {
        "<leader>tf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>ti", "<cmd>TSToolsAddMissingImports<CR>",  desc = "Add imports faltando" },
      { "<leader>tu", "<cmd>TSToolsRemoveUnused<CR>",       desc = "Remover não usados" },

      -- 🔹 Python
      { "<leader>p",  group = "Python" },
      { "<leader>pr", "<cmd>!python3 %<CR>",           desc = "Rodar arquivo atual" },
      { "<leader>pt", "<cmd>!pytest<CR>",              desc = "Rodar pytest" },
      {
        "<leader>pf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código (Black)",
      },
      { "<leader>pl", "<cmd>!pylint %<CR>",            desc = "Rodar pylint no arquivo" },

      -- 🔹 JavaScript
      { "<leader>j",  group = "JavaScript" },
      { "<leader>jr", "<cmd>!node %<CR>",              desc = "Rodar arquivo atual" },
      {
        "<leader>jf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código (Prettier/ESLint)",
      },
      { "<leader>jo", "<cmd>EslintFixAll<CR>",         desc = "Corrigir com ESLint" },
      { "<leader>jt", "<cmd>!npm test<CR>",            desc = "Rodar test (npm)" },

      -- 🔹 HTML & CSS
      { "<leader>h",  group = "HTML/CSS" },
      {
        "<leader>hf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>hv", "<cmd>EmmetInstall<CR>",         desc = "Emmet Expand" },
      { "<leader>hp", "<cmd>!prettier --write %<CR>",  desc = "Formatar com prettier" },

      -- 🔹 Lua
      { "<leader>l",  group = "Lua" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Formatar código",
      },
      { "<leader>ld", "<cmd>LuaSnipEdit<CR>",          desc = "Editar snippets" },
      { "<leader>lr", "<cmd>luafile %<CR>",            desc = "Rodar arquivo atual" },

      -- 🔹 Diagnostics (Trouble)
      { "<leader>x",  group = "Diagnostics (Trouble)" },
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Erros do Workspace" },
      { "<leader>xf", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Erros do Arquivo Atual" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Lista de soluções rápidas" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Lista de localização" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",        desc = "Referências do LSP" },
    }, {
      mode = "n",
      silent = true,
      noremap = true,
      -- sem prefix aqui, porque já estamos colocando <leader> explícito em cada lhs
    })
  end,
}
