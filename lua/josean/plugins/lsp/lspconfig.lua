-- ============================================================
-- 🔧 Configuração visual e funcional dos diagnostics (LSP)
-- ============================================================

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
        "simrat39/rust-tools.nvim",
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- 🔹 Função base para keymaps
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

        -- 🔧 Configuração como os erros, warnings e dicas aparecem;
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN]  = " ",
                    [vim.diagnostic.severity.HINT]  = "󰠠 ",
                    [vim.diagnostic.severity.INFO]  = " ",
                },
            },
            --🔹 Mostra todos (não apenas erros)
            virtual_text = {
                source = "always", -- mostra de qual LSP veio o error 
                prefix = "●", -- símbolo bonito no início
                spacing = 2, -- espaçamento entre texto e código
            },
            underline = true, -- sublinha trechos com error
            update_in_insert = true, -- atualiza mesmo enquanto digital
            severity_sort = true, -- organiza por gravidade (erro > aviso)
            float = {
                border = "rounded", -- 🔹 borda arredondada
                source = "always", -- Mostra de onde veio o error (Ex: eslint, tsserver)
                focusable = false, -- não foca o popup automaticamente
                prefix = "●", -- símbolo no popup
                style = "minimal", -- estilo limpo e discreto
            }
        })

        -- ============================================================
        -- 🎨 Estilos visuais para sublinhar erros e avisos
        -- ============================================================

        -- undercurl = sublinhado ondulado
        -- sp = cor específica para o sublinhado (cor "special")
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF5555" }) -- vermelho
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#F1FA8C" }) -- amarelo
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#8BE9FD" }) -- azul claro
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#50FA7B" }) -- verde 

        -- ============================================================
        -- 💡 Atalhos úteis (caso queira lembrar)
        -- ============================================================
        -- ]d → vai para o próximo erro
        -- [d → volta para o erro anterior
        -- <leader>d → mostra o erro da linha em popup
        -- <leader>D → mostra todos os diagnostics do arquivo (via Telescope)
        -- ============================================================

      

        -- ===============================
        -- Novo formato para LSPs
        -- ===============================
        local servers = {
            tsserver    = {}, -- typescript
            html        = {},
            cssls       = {},
            graphql     = { filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" } },
            emmet_ls    = { filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact", "svelte" } },
            prismals    = {},
            pyright     = {},
            eslint      = { filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" } },
            lua_ls      = {
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
            -- ✅ TailwindCSS com suporte a templates customizados
            tailwindcss = {
                filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte" },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                "tw`([^`]*)", -- tw`text-lg bg-red-500`
                                'tw="([^"]*)', -- tw="..."
                                'tw={"([^"}]*)', -- tw={"..."}
                                "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
                            },
                        },
                    },
                },
            },
        }

        -- 🚀 Inicializa cada LSP (novo formato Neovim >= 0.11)
        for name, opts in pairs(servers) do
            opts.capabilities = capabilities
            opts.on_attach = on_attach
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        -- 🔹 Svelte precisa de autocmd extra
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

        -- ===============================
        -- Configuração do Rust via rust-tools
        -- ===============================
        local rust_tools = require("rust-tools")
        rust_tools.setup({
            server = {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)

                    local map = function(mode, keys, func, desc)
                        vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
                    end

                    -- Atalhos específicos do Rust
                    map("n", "<leader>rr", "<cmd>RustRunnables<CR>", "Rust Runnables")
                    map("n", "<leader>rd", "<cmd>RustDebuggables<CR>", "Rust Debuggables")
                    map("n", "<leader>rh", "<cmd>RustHoverActions<CR>", "Hover Actions")
                    map("n", "<leader>re", "<cmd>RustExpandMacro<CR>", "Expand Macro")
                    map("n", "<leader>rc", "<cmd>!cargo clippy<CR>", "Rodar Clippy")
                    map("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Formatar com RustFmt")
                end,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = { command = "clippy" },
                    },
                },
            },
        })
    end,
}