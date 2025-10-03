return {
    "folke/which-key.nvim",
    
    event = "VeryLazy",
    
    init = function ()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    config = function ()
        local wk = require("which-key")

        wk.setup({})

        wk.register({
            -- 🔹 Rust
            r = {
                name = "Rust",
                r = { "<cmd>RustRunnables<CR>", "Runnables" },
                d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
                h = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
                e = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
                c = { "<cmd>!cargo clippy<CR>", "Rodar Clippy" },
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar (RustFmt)" },
            },

            -- 🔹 TypeScript
            t = {
                name = "TypeScript",
                o = { "<cmd>TypescriptOrganizeImports<CR>", "Organizar impotos" },
                r = { "<cmd>TypescriptRenameFile<CR>", "Renomear arquivos"},
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar código" },
                i = { "<cmd>TSToolsAddMissingImports<CR>", "Adicionar importes faltando" },
                u = { "<cmd>TSToolsRemoveUnused<CR>", "Remover não utilizado" },
            },

            -- 🔹 Python
            p = {
                name = "Python",
                r = { "<cmd>!python3 %<CR>", "Rodar arquivo atual" },
                t = { "<cmd>!pytest<CR>", "Rodar pytest" },
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar código (Black)" },
                l = { "<cmd>!pylint %<CR>", "Rodar pylint no arquivo" },
            },

            -- 🔹 JavaScript
            j = {
                name = "JavaScript",
                r = { "<cmd>!node %<CR>", "Rodar arquivo atual" },
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Rodar código (Prettier/ESLint)" },
                o = { "<cmd>EslintFixAll<CR>", "Corrigir com ESLint" },
                t = { "<cmd>!npm test<CR>", "Rodar test (npm)" },
            },

            -- 🔹 HTML & CSS
            h = {
                name = "HTML/CSS",
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar código"},
                v = { "<cmd>EmmetInstall<CR>", "Emmet Expand" },
                p = { "<cmd>!prettier --write %<CR>", "Formatar com prettier" },
            },

            -- 🔹 Lua
            l = {
                name = "Lua",
                f = { function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar código"},
                d = { "<cmd>LuaSnipEdit<CR>", "Editar snippets" },
                r = { "<cmd>luafile %<CR>", "Rodar arquivo atual" },
            }
        }, { prefix = "<leader>" })
    end
}
