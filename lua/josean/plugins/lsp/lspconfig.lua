return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
    --🔹 Adicionando suport ao Rust
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

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

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰠠 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      virtual_text = { severity = vim.diagnostic.severity.ERROR }, -- 🔧 só mostra erro inline
      update_in_insert = false,
      severity_sort = true,
    })

    -- 🔧 LSP servers
    lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })

    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr) -- chama seu keymap base
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = vim.api.nvim_create_augroup("svelte_onsave", { clear = true }),
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    lspconfig.graphql.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact", "svelte" },
    })

    lspconfig.prismals.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
    })

    --🔹 Adicionando: configuração do Rust via rust-tools
    local rust_tools = require("rust-tools")

    rust_tools.setup({
        server = {
            capabilities = capabilities,
            on_attach = function (client, bufnr)
                on_attach(client, bufnr) -- herda serus keymaps globais

                -- atalhos extraas só para Rust
                local map = function (mode, keys, func, desc)
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, silent = true, desc = desc })
                end
                
                -- Atalhos específicos do Rust
                map("n", "<leader>rr", "<cmd>RustRunnables<CR>", "Rust Runnables")
                map("n", "<leader>rd", "<cmd>RustDebuggables<CR>", "Rust Debuggables")
                map("n", "<leader>rh", "<cmd>RustHoverActions<CR>", "Hover Actions")
                map("n", "<leader>re", "<cmd>RustExpandMacro<CR>", "Expand Macro")

                --🔧 Rodar Clippy manualmente
                map("n", "<leader>rc", "<cmd>!cargo clippy<CR>", "Rodar Clippy")

                --🔧 Formatar com RustFmt
                map("n", "<leader>rf", function ()
                    vim.lsp.buf.format({ async = true })
                end, "Formatar com RustFmt")
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
