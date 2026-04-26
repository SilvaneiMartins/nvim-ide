-- Caminho onde o lazy.nvim vai ser clonado (funciona no Windows/Linux/macOS)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
        { "Falha ao clonar lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPressione qualquer tecla para sair...." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Certifique-se de configurar `mapleader` e `maplocalleader` antes de
-- carregar lazy.nvim para que os mapeamentos estejam corretos.
-- Este também é um bom lugar para configurar outras opções (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    -- Importa automaticamente todos os arquivos de plugin dentro de lua/martins/plugins
    { import = "martins.plugins" },
    { import = "martins.plugins.lsp" },

    -- Arquivos de Programas
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            -- Carrega a config modular de Rust que foi criado em lua/martins/plugins/lsp/rust.lua
            -- require("martins.plugins.lsp.rust").setup() 
        end,
    }
}, {
    checker = {
        enabled = true, -- verifica atualizações de plugin em background
        notify = false,
    },
    change_detection = {
        notify = false, -- não mostrar popup quando plugins forem atualizados
    },
    install = {
        colorscheme = { "tokyonight", "habamax", "tokyonight-night" },
    },
    performance = {
        rtp = {
            -- desabilita plugins nativos do Vim que você provavelmente não usa
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})