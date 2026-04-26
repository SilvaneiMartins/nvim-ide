-- ============================================================
-- 🔧 Configuração visual e funcional dos diagnostics (LSP)
-- ============================================================

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },

    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        ------------------------------------------------------------
        -- 🔹 Keymaps padrão LSP
        ------------------------------------------------------------
        local on_attach = function(_, bufnr)
            local map = function(mode, keys, func, desc)
                vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
            end

            map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Referências")
            map("n", "gD", vim.lsp.buf.declaration, "Ir para declaração")
            map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Ir para definição")
            map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Implementações")
            map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Tipo da definição")
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
            map("n", "<leader>rn", vim.lsp.buf.rename, "Renomear símbolo")
            map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics do buffer")
            map("n", "<leader>d", vim.diagnostic.open_float, "Diagnostics da linha")
            map("n", "[d", vim.diagnostic.goto_prev, "Diag. anterior")
            map("n", "]d", vim.diagnostic.goto_next, "Próximo diag.")
            map("n", "K", vim.lsp.buf.hover, "Documentação")
            map("n", "<leader>rs", ":LspRestart<CR>", "Reiniciar LSP")
        end

        ------------------------------------------------------------
        -- 💡 Diagnósticos (erros e avisos)
        ------------------------------------------------------------
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            virtual_text = {
                source = "always",
                prefix = "●",
                spacing = 2,
            },
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
                focusable = false,
                prefix = "●",
                style = "minimal",
            },
        })

        -- 🔹 Cores para undercurl de erros
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF5555" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#F1FA8C" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#8BE9FD" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#50FA7B" })

        ------------------------------------------------------------
        -- 🌐 Servidores gerais
        ------------------------------------------------------------
        local servers = {
            ts_ls = {},
            html = {},
            cssls = {},
            graphql = {
                filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            },
            emmet_ls = {
                filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact", "svelte" },
            },
            prismals = {},
            pyright = {},
            eslint = {
                filetypes = {
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                        completion = { callSnippet = "Replace" },
                    },
                },
            },
            tailwindcss = {
                filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte" },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                "tw`([^`]*)",
                                'tw="([^"]*)',
                                'tw={"([^"}]*)',
                                "tw%.%w+`([^`]*)",
                            },
                        },
                    },
                },
            },
        }

        for name, opts in pairs(servers) do
            opts.capabilities = capabilities
            opts.on_attach = on_attach
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        ------------------------------------------------------------
        -- 🧩 Suporte a Svelte
        ------------------------------------------------------------
        vim.lsp.config("svelte", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePost", {
                    group = vim.api.nvim_create_augroup("svelte_onsave", { clear = true }),
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end,
                })
            end,
        })
        vim.lsp.enable("svelte")

        ------------------------------------------------------------
        -- 🦀 Configuração aprimorada do Rust (rust-analyzer)
        ------------------------------------------------------------
        vim.lsp.config("rust_analyzer", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                local map = function(mode, keys, func, desc)
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
                end

                -- Keybinds específicos do Rust
                map("n", "<leader>rc", "<cmd>!cargo clippy<CR>", "Rodar Clippy")
                map("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Formatar com RustFmt")
                map("n", "<leader>rt", "<cmd>!cargo test<CR>", "Rodar Testes")
                map("n", "<leader>rb", "<cmd>!cargo build<CR>", "Build Cargo")
            end,
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        buildScripts = { enable = true },
                    },
                    checkOnSave = { command = "clippy" },
                    imports = {
                        granularity = { group = "module" },
                        prefix = "crate",
                    },
                    procMacro = { enable = true },
                    completion = {
                        autoimport = { enable = true },
                        callable = { snippets = "add_parentheses" },
                        postfix = { enable = true },
                    },
                    files = {
                        excludeDirs = { "target", "node_modules" },
                    },
                    -- Inlay hints (dicas visuais no código)
                    inlayHints = {
                        enable = true,
                        chainingHints = { enable = true },
                        parameterHints = { enable = true },
                        typeHints = { enable = true },
                    },
                },
            },
        })
        vim.lsp.enable("rust_analyzer")

        ------------------------------------------------------------
        -- 🔨 C/C++ (clangd)
        ------------------------------------------------------------
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                local map = function(mode, keys, func, desc)
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
                end

                -- Keybinds específicos de C/C++
                map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", "Switch header/source")
                map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format (clang-format)")
            end,
            cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            settings = {
                clangd = {
                    InlayHints = {
                        Enabled = true,
                        ParameterHints = true,
                        TypeHints = true,
                        ChainingHints = true,
                    },
                },
            },
        })
        vim.lsp.enable("clangd")

        ------------------------------------------------------------
        -- 🐹 Go (gopls)
        ------------------------------------------------------------
        vim.lsp.config("gopls", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                local map = function(mode, keys, func, desc)
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
                end

                -- Keybinds específicos de Go
                map("n", "<leader>gr", "<cmd>!go run .<CR>", "Run")
                map("n", "<leader>gt", "<cmd>!go test ./...<CR>", "Test")
                map("n", "<leader>gb", "<cmd>!go build<CR>", "Build")
                map("n", "<leader>gf", function() vim.lsp.buf.format({ async = true }) end, "Format (gofmt)")
            end,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        shadow = true,
                    },
                    staticcheck = true,
                    gofumpt = false,
                    usePlaceholders = true,
                    completeUnimported = true,
                    directoryFilters = { "-.git", "-.vscode", "-node_modules" },
                    semanticTokens = true,
                },
            },
            filetypes = { "go", "gomod", "gosum", "gotmpl" },
        })
        vim.lsp.enable("gopls")
    end,
}