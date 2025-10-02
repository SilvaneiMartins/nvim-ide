-- Configuração Rust

local M = {}

M.setup = function ()
    local rt = require("rust-tools")

    rt.setup({
        server = {
            on_attach = function (_, bufnr)
                local opts = { buffer = bufnr, noremap = true, silent = true }

                -- Atalhos úteis
                vim.keymap.set("n", "k", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>f", function ()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end,
            settgins = {
                ["rust-analyzer"] = {
                    cargo = { aliFeatures = true },
                    checkOnSave = { command = "clippy" }
                },
            },
        },
    })
end

return M
