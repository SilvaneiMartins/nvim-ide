return {
    "yetone/avante.nvim",
    -- Se você quiser compilar a partir do código-fonte, execute `make BUILD_FROM_SOURCE=true`
    -- ⚠️ É necessário adicionar esta configuração! ! !
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Nunca defina este valor como "*"! Nunca!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- adicione quaisquer opções aqui
        -- por exemplo
        provider = "deepseek",
        providers = {
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-sonnet-4-20250514",
                timeout = 30000, -- Tempo limite em milissegundos
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 20480,
                },
            },
            deepseek = {
                __inherited_from = "openai",
                endpoint = "https://api.deepseek.com",
                model = "deepseek-reasoner",
                -- model = "deepseek-chat",
                api_key_name = "DEEPSEEK_API_KEY",
                -- timeout = 30000, -- Tempo limite em milissegundos
                -- extra_request_body = {
                --     temperature = 0.75,
                --     max_tokens = 32768,
                -- },
            },
            moonshot = {
                endpoint = "https://api.moonshot.ai/v1",
                model = "kimi-k2-0711-preview",
                timeout = 30000, -- Tempo limite em milissegundos
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 32768,
                },
            },
            openrouter = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                model = "qwen/qwen3-coder:free",
                -- model = "deepseek/deepseek-chat-v3-0324:free",
                -- model = "deepseek/deepseek-r1-0528:free",
                api_key_name = "OPEN_ROUTER_API_KEY",
                timeout = 30000, -- Tempo limite em milissegundos
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 32768,
                },
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- suporte para colagem de imagens
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- configurações recomendadas
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- necessário para usuários do Windows
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Certifique-se de configurar isso corretamente se você tiver lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}