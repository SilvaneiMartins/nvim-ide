vim.g.mapleader = " "     -- define a tecla <leader> como espaço

local keymap = vim.keymap -- atalho para criar keymaps

-- Modo Insert
keymap.set("i", "jk", "<ESC>", { desc = "Sair do modo insert com jk" })

-- Pesquisa
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Limpar destaques da busca" })

-- Incrementar/decrementar números
keymap.set("n", "<leader>+", "<C-a>", { desc = "Incrementar número" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrementar número" })

-- Gerenciamento de janelas
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Ajustar splits para tamanho igual" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Fechar split atual" })

-- Gerenciamento de abas
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Abrir nova aba" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Fechar aba atual" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Ir para próxima aba" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Ir para aba anterior" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Abrir buffer atual em nova aba" })