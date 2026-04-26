return {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
        vim.g.gitblame_enabled = false  -- começar desabilitado
        vim.g.gitblame_message_template = "<author>, <date> • <summary>"
        
        vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { 
            noremap = true, 
            silent = true, 
            desc = "Toggle git blame" 
        })
    end,
}
