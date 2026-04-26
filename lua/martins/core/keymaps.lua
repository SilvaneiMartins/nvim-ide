-- [[Mapas de teclas básicos]]
-- Consulte `:help vim.keymap.set()`
-- Defina <espaço> como a chave líder
-- Consulte `:help mapleader`
-- NOTA: Deve ser feito antes do carregamento dos plugins (caso contrário, um líder incorreto será usado)
vim.g.mapleader = " "      
vim.g.maplocalleader = ' ' 

local keymap = vim.keymap -- atalho para criar keymaps


-- Modo Insert
keymap.set("i", "jk", "<ESC>", { desc = "Sair do modo insert com jk" })

-- Saia do modo terminal no terminal integrado com um atalho um pouco mais fácil de descobrir.
-- Caso contrário, normalmente você precisa pressionar <C-\><C-n>, o que
-- não é algo que alguém adivinharia sem um pouco mais de experiência.

-- NOTA: Isso não funcionará em todos os emuladores de terminal/tmux/etc. Tente seu próprio mapeamento
-- ou simplesmente use <C-\><C-n> para sair do modo terminal.
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    
-- Limpar destaques na pesquisa ao pressionar <Esc> no modo normal
-- Consulte `:help hlsearch`
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Mapas de teclas de diagnóstico
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnóstico aberto [Lista de soluções rápidas]' })

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

-- Atalhos de teclado para facilitar a navegação em janelas divididas. 
-- Use CTRL<hjkl> para alternar entre janelas 
-- 
-- Consulte `:help wincmd` para obter uma lista de todos os comandos de janela
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Mova o foco para a janela da esquerda.' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Mova o foco para a janela da direita.' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Mova o foco para a janela inferior.' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Mova o foco para a janela superior.' })

-- Desativar as teclas de seta em todos os modos
-- modos locais = { 'n', 'i', 'v', 'c', 't', 'o', 's', 'x' } -- Todos os modos possíveis
-- local modes = { 'n', 'i', 'v', 'o', 't', 's', 'x' } -- Todos os modos possíveis
-- local arrows = { '<Up>', '<Down>', '<Left>', '<Right>' }

-- for _, mode in ipairs(modes) do
--   for _, key in ipairs(arrows) do
--     vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
--   end
-- end

-- local enabledModes = { 'i', 'c', 'o', 't', 's', 'x' }
-- Mapear Alt + hjkl no modo Insert
-- for _, mode in ipairs(enabledModes) do
--   vim.keymap.set(mode, '<A-h>', '<Left>', { noremap = true, silent = true })
--   vim.keymap.set(mode, '<A-j>', '<Down>', { noremap = true, silent = true })
--   vim.keymap.set(mode, '<A-k>', '<Up>', { noremap = true, silent = true })
--   vim.keymap.set(mode, '<A-l>', '<Right>', { noremap = true, silent = true })
-- end