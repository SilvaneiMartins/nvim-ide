# Neovim IDE – Configuração com Lazy.nvim

Este repositório contém uma configuração modular do **Neovim** usando o gerenciador de plugins **[lazy.nvim](https://github.com/folke/lazy.nvim)**. O objetivo é transformar o Neovim em um ambiente de desenvolvimento completo (IDE-like), organizado e fácil de manter.

---

## 📂 Estrutura do projeto

```
~/.config/nvim/   # (Linux/macOS)
%LOCALAPPDATA%/nvim/   # (Windows)

├── init.lua                 # Ponto de entrada da configuração
└── lua
    └── martins
        ├── core
        │   ├── init.lua     # Carrega opções básicas e keymaps
        │   ├── options.lua  # Configurações de editor (indentação, cores, etc.)
        │   └── keymaps.lua  # Mapeamentos de teclas globais
        └── plugins
            ├── lazy.lua     # Configuração do lazy.nvim e imports
            ├── lspconfig.lua# Configuração dos servidores LSP + keymaps
            ├── cmp.lua      # Configuração do nvim-cmp + snippets + lspkind
            ├── telescope.lua# Configuração do Telescope + extensões
            └── ...          # Outros plugins
```

---

## ⚙️ Principais Arquivos

### `init.lua`

Arquivo de entrada simples que apenas importa os módulos principais:

```lua
require("martins.core")
require("martins.lazy")
```

### `core/options.lua`

Define as opções globais do Neovim:

-   Numeração relativa e absoluta (`relativenumber`, `number`)
-   Indentação com 2 espaços (`tabstop`, `shiftwidth`, `expandtab`)
-   Desabilita quebra de linha automática (`wrap = false`)
-   Ajustes de busca (`ignorecase`, `smartcase`)
-   Linha do cursor habilitada (`cursorline = true`)
-   Ativa true colors (`termguicolors = true`)
-   Sempre mostra coluna de sinais (`signcolumn = "yes"`)
-   Copiar/colar integrado com o sistema (`clipboard:append("unnamedplus")`)
-   Splits abrindo à direita/abaixo
-   `swapfile` desabilitado

### `core/keymaps.lua`

Define atalhos úteis:

-   `jk` → sai do modo insert
-   `<leader>nh` → limpa highlights da busca
-   `<leader>+` / `<leader>-` → incrementa/decrementa número
-   `<leader>sv` / `<leader>sh` / `<leader>se` / `<leader>sx` → gerencia splits
-   `<leader>to` / `<leader>tx` / `<leader>tn` / `<leader>tp` / `<leader>tf` → gerencia abas

### `plugins/lazy.lua`

-   Clona e carrega o **lazy.nvim** se não existir
-   Configura:

    -   `checker` (verificação de updates)
    -   `change_detection` (notificação de alterações)
    -   `install.colorscheme` para já baixar temas
    -   Desativa plugins embutidos do Vim que não são necessários (melhora a performance)

-   Importa automaticamente as configurações da pasta `lua/martins/plugins/`

### `plugins/lspconfig.lua`

-   Configuração de todos os **LSPs** via `nvim-lspconfig`
-   Integração com **nvim-cmp** através de `cmp_nvim_lsp.default_capabilities()`
-   Keymaps centralizados em `on_attach`
-   Servidores configurados:

    -   `ts_ls` (TypeScript / JavaScript)
    -   `html`
    -   `cssls`
    -   `tailwindcss`
    -   `svelte` (com autocmd para reload ao salvar `.js`/`.ts`)
    -   `graphql`
    -   `emmet_ls`
    -   `prismals` (requer `npm install -g @prisma/language-server`)
    -   `pyright`
    -   `eslint`

-   `lua_ls` configurado para reconhecer `vim` como global e com suporte ao **neodev.nvim**

### `plugins/cmp.lua`

-   Configuração completa do **nvim-cmp**
-   Integração com:

    -   `LuaSnip` (snippets)
    -   `cmp-nvim-lsp` (LSP)
    -   `cmp-buffer` (texto do buffer)
    -   `cmp-path` (paths de arquivos)
    -   `cmp-nvim-lua` (API do Neovim em Lua)
    -   `friendly-snippets` (snippets prontos)
    -   `lspkind.nvim` (ícones estilo VSCode)

-   Keymaps úteis:

    -   `<C-k>` / `<C-j>` → navegar entre sugestões
    -   `<Tab>` / `<S-Tab>` → navegar/expandir snippet
    -   `<C-Space>` → abrir menu de autocomplete
    -   `<CR>` → confirmar sugestão selecionada

-   `ghost_text` habilitado para preview inline

### `plugins/telescope.lua`

-   Configuração do **Telescope** com ícones e keymaps personalizados
-   Integração com **trouble.nvim**
-   Integração com extensão **telescope-fzf-native.nvim** (no Windows usar build com **CMake**)
-   Uso de `pcall(telescope.load_extension, "fzf")` para evitar erro se a DLL não estiver compilada

### `plugins/mason.lua`

-   Configuração do **mason.nvim**, **mason-lspconfig.nvim** e **mason-tool-installer.nvim**
-   `ensure_installed` garante que servidores LSP e ferramentas são instalados automaticamente
-   ⚠️ Importante: use `automatic_installation = true` (não mais `{ enable = true }`)
-   Inclui servidores: `ts_ls`, `lua_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `graphql`, `emmet_ls`, `prismals`, `pyright`, `eslint`
-   Inclui ferramentas: `prettier`, `stylua`, `isort`, `black`, `pylint`, `eslint_d`

> **Nota:** para usar o `prismals`, instale o servidor manualmente:
>
> ```bash
> npm install -g @prisma/language-server
> ```

---

## 🚀 Passos pós-instalação

1. Certifique-se de ter **Neovim 0.9 ou 0.10+**.
2. Instale as ferramentas de build (Windows: `winget install Microsoft.VisualStudio.2022.BuildTools` e `winget install Kitware.CMake`).
3. Compile o **telescope-fzf-native.nvim**:

    ```powershell
    cd $env:LOCALAPPDATA/nvim-data/lazy/telescope-fzf-native.nvim
    Remove-Item build -Recurse -Force
    cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
    cmake --build build --config Release
    ```

4. No Neovim, rode:

    ```vim
    :Lazy sync
    :MasonUpdate
    ```

5. Configure sua fonte no terminal para uma **Nerd Font** (ex: _FiraCode Nerd Font_) para que os ícones do `lspkind` e do `nvim-tree` apareçam.

---

Com isso sua configuração deve ficar estável tanto no **Windows** quanto em **Linux/macOS**, com suporte completo a LSP, autocompletar e busca com o Telescope. 🎉

---

👉 Quer que eu prepare também um **guia de uso rápido** (atalhos principais + como abrir Telescope, salvar sessão, naveg
