return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        { "WhoIsSethDaniel/mason-tool-installer.nvim", version = "*" },
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
            ensure_installed = {
                "tsserver",               -- ✅ TypeScript
                "html",                   -- HTML
                "cssls",                  -- CSS
                "tailwindcss",            -- TailwindCSS
                "svelte",                 -- Svelte
                "lua_ls",                 -- Lua
                "graphql",                -- GraphQL
                "emmet_ls",               -- Emmet
                "prisma-language-server", -- ✅ Prisma
                "pyright",                -- Python
                "eslint",                 -- ESLint
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",  -- formatter JS/TS
                "stylua",    -- formatter Lua
                "isort",     -- formatter Python
                "black",     -- formatter Python
                "pylint",    -- linter Python
                "eslint_d",  -- linter JS/TS
            },
            run_on_start = true, -- instala tudo ao abrir o Neovim
        })
    end,
}
