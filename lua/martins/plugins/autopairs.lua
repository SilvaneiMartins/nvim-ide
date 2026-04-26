return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        -- Configuração base
        autopairs.setup({
            check_ts = true, -- usa Treesitter para contexto
            ts_config = {
                lua = { "string" }, -- não adicionar pares dentro de strings em Lua
                javascript = { "template_string" },
                typescript = { "template_string" },
                javascriptreact = { "template_string" },
                typescriptreact = { "template_string" },
            },
            fast_wrap = {}, -- ativa fast wrap (Ctrl-e por padrão)
        })

        -- Regras customizadas para evitar problemas com aspas em teclados ABNT2
        autopairs.add_rules({
            Rule('"', '"')
                :with_pair(function(opts)
                    -- só duplica aspas se o próximo caractere não for uma letra/número/aspas
                    return opts.prev_char:match("[%w%s]") == nil
                end),

            Rule("'", "'")
                :with_pair(function(opts)
                    -- evita conflito de dead key em layouts ABNT2
                    return opts.prev_char:match("[%w%s]") == nil
                end),
        })

        -- Integração com nvim-cmp
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}