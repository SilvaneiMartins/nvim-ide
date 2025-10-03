-- Caminho onde o lazy.nvim vai ser clonado (funciona no Windows/Linux/macOS)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- versão estável
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Importa automaticamente todos os arquivos de plugin dentro de lua/josean/plugins
    { import = "josean.plugins" },
    { import = "josean.plugins.lsp" },

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
            -- Carrega a config modular de Rust que foi criado em lua/josean/plugins/lsp/rust.lua
            -- require("josean.plugins.lsp.rust").setup() 
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
        colorscheme = { "tokyonight", "habamax" }, -- já baixa o tema no primeiro uso
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