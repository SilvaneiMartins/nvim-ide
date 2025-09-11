-- Netrw: estilo de listagem (3 = tree view)
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Linhas relativas + número absoluto
opt.relativenumber = true
opt.number = true

-- Tabs & indentação
opt.tabstop = 2       -- largura de um TAB = 2 espaços
opt.shiftwidth = 2    -- largura da indentação = 2 espaços
opt.expandtab = true  -- converte TAB em espaços
opt.autoindent = true -- copia a indentação da linha anterior

-- Quebra de linha
opt.wrap = false -- não quebrar linhas automaticamente

-- Pesquisa
opt.ignorecase = true -- ignora maiúsculas/minúsculas na busca
opt.smartcase = true  -- se a busca tiver maiúsculas, ativa case sensitive

-- Linha do cursor
opt.cursorline = true

-- Cores e aparência
opt.termguicolors = true -- ativa suporte a true colors
opt.background = "dark"  -- força temas a usarem o modo escuro
opt.signcolumn = "yes"   -- mantém a coluna de sinais visível

-- Backspace
opt.backspace = "indent,eol,start" -- permite apagar indentação, fim de linha e início de inserção

-- Clipboard
opt.clipboard:append("unnamedplus") -- usa clipboard do sistema como padrão

-- Divisão de janelas
opt.splitright = true -- novas splits verticais abrem à direita
opt.splitbelow = true -- novas splits horizontais abrem abaixo

-- Swapfile
opt.swapfile = false -- desativa arquivos swap