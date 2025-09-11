return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    local fn = vim.fn

    -- Função para montar os caminhos de forma multiplataforma
    local home = fn.expand("~")
    local suppressed_dirs = {
      home,                     -- diretório home
      fn.stdpath("config"),     -- pasta de config do Neovim (~/.config/nvim ou C:\Users\<user>\AppData\Local\nvim)
      fn.expand("~/Downloads"), -- pasta Downloads
      fn.expand("~/Documents"), -- pasta Documentos
      fn.expand("~/Desktop"),   -- Desktop
    }

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = suppressed_dirs,
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
  end,
}
