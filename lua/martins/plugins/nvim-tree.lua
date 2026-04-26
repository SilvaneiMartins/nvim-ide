return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      sort_by = "case_sensitive",
      view = {
        side = "left",
        width = 40, -- 👈 esse valor define a largura do painel
        adaptive_size = true, -- ajusta dinamicamente conforme o conteúdo
        relativenumber = true,
      },
      -- Alterar ícones de seta da pasta
      renderer = {
        group_empty = false,
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
          glyphs = {
            folder = {
              arrow_closed = "", -- seta quando a pasta está fechada
              arrow_open = "", -- seta quando a pasta está aberta
            },
          },
        },
      },
      -- desativar o seletor de janelas para
      -- explorador para trabalhar bem com
      -- divisão de janelas
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
    })

    -- Configurar mapeamento de teclas
    local keymap = vim.keymap -- para maior concisão

    -- alternar explorador de arquivos
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) 
    -- Alternar o explorador de arquivos no arquivo atual
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) 
    -- recolher explorador de arquivos
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) 
    -- atualizar explorador de arquivos
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) 
  end,
}
