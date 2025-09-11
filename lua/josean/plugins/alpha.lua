return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "███████╗██╗██╗     ██╗      ██╗   ██╗ █████╗ ███╗   ██╗███████╗██╗",
            "██╔════╝██║██║     ██║      ██║   ██║██╔══██╗████╗  ██║██╔════╝██║",
            "███████╗██║██║     ██║      ██║   ██║███████║██╔██╗ ██║█████╗  ██║",
            "╚════██║██║██║     ██║      ██║   ██║██╔══██║██║╚██╗██║██╔══╝  ██║",
            "███████║██║███████╗███████╗ ╚██████╔╝██║  ██║██║ ╚████║███████╗██║",
            "╚══════╝╚═╝╚══════╝╚══════╝  ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ",
            "                    🚀 SILVANEI MARTINS 🚀                        ",
        }


        -- Botões do dashboard (mantendo seus atalhos atuais)
        dashboard.section.buttons.val = {
            dashboard.button("e", "📃  Novo Arquivo", "<cmd>ene<CR>"),
            dashboard.button("SPC ee", "🗂️  Explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("SPC ff", "🔎  Buscar Arquivo", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fs", "🔍  Buscar Palavra", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC wr", "⚙️  Restaurar Sessão", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", "❌  Sair do Neovim", "<cmd>qa<CR>"),
        }

        -- Rodapé
        dashboard.section.footer.val = "⚡ Ambiente NVIM do Silvanei Martins ⚡"

        -- Layout centralizado
        dashboard.opts.layout = {
            { type = "padding", val = 1 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        -- Inicializa o Alpha com as configs
        alpha.setup(dashboard.opts)
    end,
}