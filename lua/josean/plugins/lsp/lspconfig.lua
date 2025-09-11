return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Habilitar capacidades extras para integração com nvim-cmp
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Função central para keymaps quando o LSP conecta
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

    -- Configuração global de diagnósticos
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰠠 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      virtual_text = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- 🔧 Configuração dos LSPs
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.html.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.svelte.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- Atualiza ao salvar arquivos JS/TS (necessário para Svelte)
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

    lspconfig.graphql.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
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
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- corrige "undefined-global"
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
        },
      },
    })
  end,
}
