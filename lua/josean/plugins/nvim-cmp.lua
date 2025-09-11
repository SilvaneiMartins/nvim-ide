return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",              -- completar texto do buffer
    "hrsh7th/cmp-path",                -- completar paths
    "hrsh7th/cmp-nvim-lsp",            -- completar LSP
    "hrsh7th/cmp-nvim-lua",            -- completar API do Neovim Lua
    {
      "L3MON4D3/LuaSnip",              -- engine de snippets
      version = "v2.*",
      build = "make install_jsregexp", -- ⚠️ no Windows pode não funcionar, se der erro remova esta linha
    },
    "saadparwaiz1/cmp_luasnip",        -- integração com LuaSnip
    "rafamadriz/friendly-snippets",    -- coleção de snippets
    "onsails/lspkind.nvim",            -- ícones estilo VSCode
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- carrega snippets do friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- subir
        ["<C-j>"] = cmp.mapping.select_next_item(), -- descer
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),            -- abrir menu
        ["<C-e>"] = cmp.mapping.abort(),                   -- fechar menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirma sugestão
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- mostra ícone + texto
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
