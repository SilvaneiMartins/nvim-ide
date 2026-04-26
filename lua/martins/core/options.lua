-- Netrw: estilo de listagem (3 = tree view)
vim.cmd("let g:netrw_liststyle = 3")

-- Defina como verdadeiro se você tiver uma fonte Nerd instalada e selecionada no terminal.
vim.g.have_nerd_font = true

local opt = vim.opt

-- Linhas relativas + número absoluto
opt.relativenumber = true
opt.number = true

-- Ative o modo mouse, pode ser útil para redimensionar divisões, por exemplo!
opt.mouse = 'a'

-- Não mostre o modo, pois ele já está na linha de status.
opt.showmode = false

-- Sincronizar a área de transferência entre o sistema operacional e o Neovim.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Tabs & indentação
opt.tabstop = 4       -- largura de um TAB = 4 espaços
opt.shiftwidth = 4    -- largura da indentação = 4 espaços
opt.softtabstop = 4 -- quantos espaços são usados ​​ao pressionar tabulação
opt.expandtab = true  -- converte TAB em espaços
opt.autoindent = true -- copia a indentação da linha anterior

-- opções de recuo
opt.smarttab = true
opt.smartindent = true

-- Quebra de linha
opt.wrap = false -- não quebrar linhas automaticamente

-- Ativar recuo de quebra
opt.breakindent = true

-- Salvar histórico de desfazer
opt.undofile = true

-- Pesquisa
opt.ignorecase = true -- ignora maiúsculas/minúsculas na busca
opt.smartcase = true  -- se a busca tiver maiúsculas, ativa case sensitive

-- Linha do cursor
opt.cursorline = true

-- Define como o nvim exibirá determinados caracteres de espaço em branco no editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Veja as substituições em tempo real, enquanto digita!
opt.inccommand = 'split'

-- Cores e aparência
opt.termguicolors = true -- ativa suporte a true colors
opt.background = "dark"  -- força temas a usarem o modo escuro
opt.signcolumn = "yes"   -- mantém a coluna de sinais visível

-- Backspace
opt.backspace = "indent,eol,start" -- permite apagar indentação, fim de linha e início de inserção

-- Clipboard
opt.clipboard:append("unnamedplus") -- usa clipboard do sistema como padrão

-- Diminuir o tempo de atualização
opt.updatetime = 250

-- Diminuir o tempo de espera da sequência mapeada
opt.timeoutlen = 300

-- Divisão de janelas
opt.splitright = true -- novas splits verticais abrem à direita
opt.splitbelow = true -- novas splits horizontais abrem abaixo

-- Swapfile
opt.swapfile = false -- desativa arquivos swap

-- Número mínimo de linhas na tela a serem mantidas acima e abaixo do cursor.
opt.scrolloff = 10

-- Se estiver executando uma operação que falharia devido a alterações não salvas no buffer (como `:q`),
-- em vez disso, exiba uma caixa de diálogo perguntando se você deseja salvar o(s) arquivo(s) atual(is)
-- Consulte `:help 'confirm'`
opt.confirm = true

-- [[ Comandos automáticos básicos ]]
--  See `:help lua-guide-autocommands`

-- Realçar texto ao copiar (raspar)
-- Experimente com `yap` no modo normal
-- Consulte `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})