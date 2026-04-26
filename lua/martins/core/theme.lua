local M = {}

M.selected = "tokyonight"

M.themes = {
    {
        name = "tokyonight",
        label = "Tokyo Night",
        setup = function()
            local transparent = false

            local bg = "#011628"
            local bg_dark = "#011423"
            local bg_highlight = "#143652"
            local bg_search = "#0A64AC"
            local bg_visual = "#275378"
            local fg = "#CBE0F0"
            local fg_dark = "#B4D0E9"
            local fg_gutter = "#627E97"
            local border = "#547998"

            require("tokyonight").setup({
                style = "night",
                transparent = transparent,
                styles = {
                    sidebars = transparent and "transparent" or "dark",
                    floats = transparent and "transparent" or "dark",
                },
                on_colors = function(colors)
                    colors.bg = bg
                    colors.bg_dark = transparent and colors.none or bg_dark
                    colors.bg_float = transparent and colors.none or bg_dark
                    colors.bg_highlight = bg_highlight
                    colors.bg_popup = bg_dark
                    colors.bg_search = bg_search
                    colors.bg_sidebar = transparent and colors.none or bg_dark
                    colors.bg_statusline = transparent and colors.none or bg_dark
                    colors.bg_visual = bg_visual
                    colors.border = border
                    colors.fg = fg
                    colors.fg_dark = fg_dark
                    colors.fg_float = fg
                    colors.fg_gutter = fg_gutter
                    colors.fg_sidebar = fg_dark
                end,
            })
        end,
    },
    {
        name = "catppuccin",
        label = "Catppuccin Mocha",
        colorscheme = "catppuccin-mocha",
        setup = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    which_key = true,
                },
            })
        end,
    },
    {
        name = "rose-pine",
        label = "Rose Pine Moon",
        colorscheme = "rose-pine-moon",
        setup = function()
            require("rose-pine").setup({
                variant = "moon",
                dark_variant = "moon",
            })
        end,
    },
    {
        name = "kanagawa",
        label = "Kanagawa Wave",
        colorscheme = "kanagawa-wave",
    },
    {
        name = "gruvbox",
        label = "Gruvbox Material",
        colorscheme = "gruvbox-material",
    },
    {
        name = "dracula",
        label = "Dracula",
    },
    {
        name = "onedark",
        label = "OneDark",
        setup = function()
            require("onedark").setup({
                style = "deep",
            })
            require("onedark").load()
        end,
    },
    {
        name = "nightfox",
        label = "Nightfox",
    },
    {
        name = "nord",
        label = "Nord",
    },
    {
        name = "everforest",
        label = "Everforest",
    },
}

local function find_theme(name)
    for _, theme in ipairs(M.themes) do
        if theme.name == name or theme.colorscheme == name or theme.label == name then
            return theme
        end
    end
end

function M.apply(name)
    local theme = find_theme(name or M.selected) or M.themes[1]
    local colorscheme = theme.colorscheme or theme.name

    if theme.setup then
        theme.setup()
    end

    local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
        vim.notify("Nao foi possivel carregar o tema: " .. colorscheme .. "\n" .. err, vim.log.levels.ERROR)
        return
    end

    M.selected = theme.name
end

function M.select()
    local labels = vim.tbl_map(function(theme)
        return theme.label
    end, M.themes)

    vim.ui.select(labels, { prompt = "Escolha um tema:" }, function(choice)
        if not choice then
            return
        end

        local theme = find_theme(choice)
        if theme then
            M.apply(theme.name)
        end
    end)
end

function M.current()
    local theme = find_theme(M.selected)
    local label = theme and theme.label or M.selected

    vim.notify("Tema atual: " .. label)
end

function M.setup_commands()
    vim.api.nvim_create_user_command("ThemeSelect", M.select, { desc = "Selecionar tema" })
    vim.api.nvim_create_user_command("ThemeCurrent", M.current, { desc = "Mostrar tema atual" })
end

return M
