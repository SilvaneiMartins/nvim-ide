-- 🎨 Custom highlights (diagnostics, cores, etc.)

local M = {}

function M.setup()
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#FF5555" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#F1FA8C" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#8BE9FD" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#50FA7B" })
end

return M
