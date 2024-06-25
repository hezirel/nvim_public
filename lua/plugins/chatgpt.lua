return {
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        cond = true,
        config = function()
            require("chatgpt").setup({
                -- O#:Add you openai api key here
                api_key_cmd = "gpg --batch -q --decrypt /Users/<user>/.password-store/chatgpt/apikey.gpg",
                chat = {
                    keymaps = {
                        new_session = "<C-n>",
                        toggle_message_role = "C-d",
                    },
                },
                edit_with_instructions = {
                    diff = true,
                    keymaps = {
                        accept = "<C-e>",
                    },
                },
                openai_params = {
                    model = "gpt-4o",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    temperature = 0.5,
                    top_p = 1,
                    n = 1,
                },
                use_openai_functions_for_edits = true,
                openai_edit_params = {
                    model = "gpt-4o",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 4096,
                    temperature = 0.5,
                    top_p = 1,
                    n = 1,
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "madox2/vim-ai",
        init = function()
            vim.g.vim_ai_chat = {
                options = {
                    model = "gpt-4-turbo",
                    --endpoint_url = "http://45.147.210.149:11434/api/chat",
                    temperature = 0.5,
                },
                ui = {
                    code_syntax_enabled = 1,
                    populate_options = 0,
                    open_chat_command = "tab",
                },
            }
        end,
    },
    {
        "David-Kunz/gen.nvim",
        opts = {
            model = "nous-hermes2-mixtral:8x7b-dpo-q3_K_S", -- The default model to use.
            host = "ollama.dev.petit.ninja",       -- The host running the Ollama service.
            port = "11434",                        -- The port on which the Ollama service is listening.
            display_mode = "split",                -- The display mode. Can be "float" or "split".
            show_prompt = true,                    -- Shows the Prompt submitted to Ollama.
            show_model = true,                     -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = true,                  -- Never closes the window automatically.
            -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            -- This can also be a command string.
            -- The executed command must return a JSON object with { response, context }
            -- (context property is optional).
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            debug = false, -- Prints errors and the command which is run.
        },
        keys = {
            { "<leader>Gg", mode = { "v", "n" }, ":Gen<CR>",      desc = "Gen Menu" },
            { "<leader>Gn", mode = { "n" },      ":Gen Chat<CR>", desc = "Gen Chat Continue" },
        },
    },
}
