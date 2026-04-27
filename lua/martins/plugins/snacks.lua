vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#7aa2f7", bold = true })

local colors = { "#7aa2f7", "#9ece6a", "#e0af68", "#bb9af7" }
local config_dir = vim.fn.stdpath("config")
local image_path = vim.fs.joinpath(config_dir, "img", "logo.png")
local bundled_converter = vim.fs.joinpath(config_dir, "img", "ascii-image-converter.exe")

local function ps_quote(value)
  return "'" .. tostring(value):gsub("'", "''") .. "'"
end

-- Lógica para Mensagem do Dia (Saudação)
local function get_greeting()
  local hour = tonumber(os.date("%H"))
  if hour < 12 then
    return "🌅 Bom dia, Silvanei"
  elseif hour < 18 then
    return "🌞 Boa tarde, Silvanei"
  else
    return "🌙 Boa noite, Silvanei"
  end
end

local greeting_text = get_greeting()

local config_dir = vim.fn.stdpath("config")
local image_path = vim.fs.joinpath(config_dir, "img", "logo.png")
local bundled_converter = vim.fs.joinpath(config_dir, "img", "ascii-image-converter.exe")

local dashboard_keys = {
  { icon = " ", key = "f", desc = "Localizar Arquivo", action = ":lua Snacks.dashboard.pick('files')" },
  { icon = " ", key = "n", desc = "Novo Arquivo", action = ":ene | startinsert" },
  { icon = " ", key = "g", desc = "Localizar Texto (Grep)", action = ":lua Snacks.dashboard.pick('live_grep')" },
  { icon = " ", key = "r", desc = "Arquivos Recentes", action = ":lua Snacks.dashboard.pick('oldfiles')" },
  {
    icon = " ",
    key = "c",
    desc = "Configuração do Neovim",
    action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
  },
  { icon = " ", key = "s", desc = "Restaurar Sessão", section = "session" },
  { icon = "󰒲 ", key = "L", desc = "Lazy (Plugins)", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
  { icon = "TS ", key = "t", desc = "Atualizar Treesitter", action = ":TSUpdate" },
  { icon = " ", key = "q", desc = "Sair", action = ":qa" },
}

local function has_ascii_converter()
  return vim.fn.executable(bundled_converter) == 1 or vim.fn.executable("ascii-image-converter.exe") == 1
end

local function dashboard_terminal_cmd()
  if vim.fn.has("win32") == 1 then
    local converter = nil

    if vim.fn.executable(bundled_converter) == 1 then
      converter = bundled_converter
    elseif vim.fn.executable("ascii-image-converter.exe") == 1 then
      converter = "ascii-image-converter.exe"
    end

    if not converter then
      local message = ("ascii-image-converter.exe nao encontrado. Coloque o binario em %s ou adicione-o ao PATH."):format(
        bundled_converter
      )

      return {
        "powershell.exe",
        "-NoLogo",
        "-NoProfile",
        "-Command",
        ("Write-Host %s"):format("'" .. message:gsub("'", "''") .. "'"),
      }
    end

    local function ps_quote(value)
      return "'" .. tostring(value):gsub("'", "''") .. "'"
    end

    local command = ("& %s %s -c -b --dither"):format(ps_quote(converter), ps_quote(image_path))

    return {
      "powershell.exe",
      "-NoLogo",
      "-NoProfile",
      "-ExecutionPolicy",
      "Bypass",
      "-Command",
      command,
    }
  end

  return { bundled_converter, image_path, "-c", "-b", "--dither" }
end

for i, color in ipairs(colors) do
  vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = color })
end

return {
  "folke/snacks.nvim",
  event = "VimEnter",
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
  ██████  ██▓ ██▓  ██▒   █▓ ▄▄▄       ███▄    █ ▓█████  ██▓
▒██    ▒ ▓██▒▓██▒ ▓██░   █▒▒████▄     ██ ▀█   █ ▓█   ▀ ▓██▒
░ ▓██▄   ▒██▒▒██░  ▓██  █▒░▒██  ▀█▄  ▓██  ▀█ ██▒▒███   ▒██▒
  ▒   ██▒░██░▒██░   ▒██ █░░░██▄▄▄▄██ ▓██▒  ▐▌██▒▒▓█  ▄ ░██░
▒██████▒▒░██░░██████▒▒▀█░   ▓█   ▓██▒▒██░   ▓██░░▒████▒░██░
▒ ▒▓▒ ▒ ░░▓  ░ ▒░▓  ░░ ▐░   ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░░ ▒░ ░░▓  
░ ░▒  ░ ░ ▒ ░░ ░ ▒  ░░ ░░    ▒   ▒▒ ░░ ░░   ░ ▒░ ░ ░  ░ ▒ ░
░  ░  ░   ▒ ░  ░ ░     ░░    ░   ▒      ░   ░ ░    ░    ▒ ░
      ░   ░      ░  ░   ░        ░  ░         ░    ░  ░ ░  
                       ░                                   
]],
        keys = dashboard_keys
      },
      sections = {
        { section = 'header',  hl = "DashboardHeader" },
        { section = "keys", indent = 1, gap = 1, padding = 1 },
        {
            section = "recent_files",
            icon = " ",
            title = "Arquivos recentes",
            cwd = true,
            indent = 2,
            padding = 1,
        },
        -- { 
        --     section = "text", 
        --     text = greeting_text, 
        --     hl = "DashboardHeader", 
        --     align = "center", 
        --     padding = 1,
        -- },
        -- {
        --     section = "projects",
        --     icon = " ",
        --     title = "Projetos",
        --     indent = 2,
        --     padding = 1,
        -- },
        { section = "startup" },
        {
            pane = 2,
            section = "terminal",
            enabled = function()
                return vim.fn.filereadable(image_path) == 1 and has_ascii_converter()
            end,
            cmd = dashboard_terminal_cmd(),
            random = 10,
            indent = 5,
            height = 40,
            padding = 1,
        },
        { pane = 2, padding = 2 },
        -- {
        --     section = "text",
        --     text = function()
        --         local hour = tonumber(os.date("%H"))
        --         if hour < 12 then
        --         return "🌅 Bom dia, Silvanei"
        --         elseif hour < 18 then
        --         return "🌞 Boa tarde, Silvanei"
        --         else
        --         return "🌙 Boa noite, Silvanei"
        --         end
        --     end,
        --     align = "center",
        -- },
      },
    },
    -- explorer = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    -- input = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    -- git = { enabled = true },
    quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    scratch = { enabled = true },
    -- statuscolumn = { enabled = true },
    terminal = { enabled = true },
    -- toggle = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
     { "<leader>lg", function() Snacks.lazygit() end, desc = "[L]azy[G]it" },
    { "<leader>tu", "<cmd>TSUpdate<cr>", desc = "[T]reesitter [U]pdate" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dispensar todas as notificações" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Alternar terminal", mode = {"n", "t"} },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Próxima referência", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Referência anterior", mode = { "n", "t" } },

    -- Picker key maps
    { "\\", function() Snacks.explorer() end, desc = "Explorador de Arquivos" },
    { "<leader>ss", function() Snacks.picker.smart() end, desc = "Arquivos de Busca Inteligente" },
    { "<leader><space>", function() Snacks.picker.buffers() end, desc = "[ ] Encontrar buffers existentes" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[P]esquisar por [G]rep" },
    { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[P]esquisar arquivos no [N]eovim" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "[P]esquisar [A]rquivos" },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "[P]esquisar [P]ickers" },
    { "<leader>s.", function() Snacks.picker.recent() end, desc = "[P]esquisar arquivos recentes ('.' para repetição)" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[P]esquisar [K]eymaps" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[P]esquisa [G]lobal", mode = { "n", "x" } },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "[P]esquisar [R]etomar" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[P]esquisar [A]juda" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[P]esquisar [D]iagnóstico" },
    { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[P]esquisar [/] em Arquivos Abertos" },
  },
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Abrir LazyGit" },
    { "<leader>tu", "<cmd>TSUpdate<cr>", desc = "Atualizar Treesitter" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dispensar todas as notificações" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Alternar terminal", mode = {"n", "t"} },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Próxima referência", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Referência anterior", mode = { "n", "t" } },

    -- Picker key maps
    { "\\", function() Snacks.explorer() end, desc = "Explorador de Arquivos" },
    { "<leader>ss", function() Snacks.picker.smart() end, desc = "Busca inteligente de arquivos" },
    { "<leader><space>", function() Snacks.picker.buffers() end, desc = "Encontrar buffers abertos" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Pesquisar com grep" },
    { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Pesquisar arquivos da configuração" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Pesquisar arquivos" },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pesquisar pickers" },
    { "<leader>s.", function() Snacks.picker.recent() end, desc = "Pesquisar arquivos recentes" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Pesquisar atalhos" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Pesquisar palavra sob o cursor", mode = { "n", "x" } },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Retomar última pesquisa" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Pesquisar ajuda" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Pesquisar diagnósticos" },
    { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "Pesquisar nos buffers abertos" },
    {
      "<leader>/",
      function()
        Snacks.picker.lines({
          -- Use o layout Selecionar
          layout = {
            preset = "select", -- ⟵ preset defined in docs :contentReference[oaicite:0]{index=0} 
          },
        })
      end,
      desc = "[/] Busca aproximada no buffer atual",
    },
  }
}
