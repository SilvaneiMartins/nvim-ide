-- DASHBOARD da IDE NEOVIM;
return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- 1. Lógica para Mensagem do Dia (Saudação)
        local function get_greeting()
            local hour = tonumber(os.date("%H"))
            if hour < 12 then
                return "🌅 Bom dia, Silvanei"
            elseif hour < 18 then
                return "🌞 Boa tarde, Silvanei"
            else
                return "🌙 Boa noite, Silvanei"
            end
        end

        -- 2. Configuração do Header (Mesmo do Snacks)
        dashboard.section.header.val = {
            [[ ██████  ██▓ ██▓  ██▒   █▓ ▄▄▄       ███▄    █ ▓█████  ██▓]],
            [[▒██    ▒ ▓██▒▓██▒ ▓██░   █▒▒████▄     ██ ▀█    █ ▓█   ▀ ▓██▒]],
            [[░ ▓██▄   ▒██▒▒██░  ▓██  █▒░▒██  ▀█▄  ▓██  ▀█ ██▒▒███   ▒██▒]],
            [[  ▒   ██▒░██░▒██░   ▒██ █░░░██▄▄▄▄██ ▓██▒  ▐▌██▒▒▓█  ▄ ░██░]],
            [[▒██████▒▒░██░░██████▒▒▀█░   ▓█   ▓██▒▒██░   ▓██░░▒████▒░██░]],
            [[▒ ▒▓▒ ▒ ░░▓  ░ ▒░▓  ░░ ▐░   ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░░ ▒░ ░░▓  ]],
            [[░ ░▒  ░ ░ ▒ ░░ ░ ▒  ░░ ░░    ▒   ▒▒ ░░ ░░   ░ ▒░ ░ ░  ░ ▒ ░]],
            [[░  ░  ░   ▒ ░  ░ ░     ░░    ░   ▒      ░   ░ ░    ░    ▒ ░]],
            [[      ░   ░      ░  ░   ░        ░  ░        ░    ░  ░ ░  ]],
            [[                        ░                                 ]],
            " ",
            " ",
            "                  🚀 SILVANEI MARTINS 🚀                   ",
        }

        dashboard.section.header.opts.hl = "DashboardHeader"

        -- 3. Seção de Saudação Dinâmica
        local greeting = {
            type = "text",
            val = get_greeting(),
            opts = {
                hl = "DashboardHeader",
                position = "center",
            },
        }

        -- 4. Botões (Tradução e Ações)
        dashboard.section.buttons.val = {
            dashboard.button("e", "📃  Novo Arquivo", "<cmd>ene<CR>"),
            dashboard.button("SPC ee", "🗂️  Explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("SPC ff", "🔎  Buscar Arquivo", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fs", "🔍  Buscar Palavra", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC wr", "⚙️  Restaurar Sessão", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", "❌  Sair do Neovim", "<cmd>qa<CR>"),
        }

        -- 5. Rodapé
        dashboard.section.footer.val = "⚡ Ambiente NVIM do Silvanei Martins ⚡"
        dashboard.section.footer.opts.hl = "Type"

        -- 6. Definição do Layout (Incluindo Saudação, Recent Files e Projects)
        -- Nota: Alpha não tem "recent_files" nativo como o Snacks, usamos um componente de texto ou botões.
        dashboard.opts.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 1 },
            greeting, -- Mensagem de bom dia
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 2 },
            -- Para arquivos recentes no Alpha, geralmente usa-se o plugin mru ou a função abaixo
            { type = "text", val = "Arquivos Recentes", opts = { hl = "Special", position = "center" } },
            { type = "padding", val = 1 },
            -- Aqui você pode adicionar uma lógica de MRU se desejar, ou manter o foco nos botões
            dashboard.section.footer,
        }

        -- Cores
        vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#7aa2f7", bold = true })

        alpha.setup(dashboard.opts)
    end,
}