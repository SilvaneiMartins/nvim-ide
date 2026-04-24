return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        local notify = require("notify")
        
        notify.setup({
            background_colour = "#000000",
            render = "wrapped-compact",
            max_width = 50,
            stages = "fade",
            timeout = 3000,
            fps = 30,
        })
        
        vim.notify = notify
    end,
}
