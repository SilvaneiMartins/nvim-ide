return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- lista de LSPs que serão instalados automaticamente
      ensure_installed = {
        "ts_ls", -- ✅ nome novo do antigo tsserver
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "eslint",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- formatter JS/TS
        "stylua",   -- formatter Lua
        "isort",    -- formatter Python
        "black",    -- formatter Python
        "pylint",   -- linter Python
        "eslint_d", -- linter JS/TS
      },
    })
  end,
}
