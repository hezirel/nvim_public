return {
    "folke/tokyonight.nvim",
    { "rose-pine/neovim",          name = "rose-pine" },
    "fenetikm/falcon",
    "luisiacc/gruvbox-baby",
    "tiagovla/tokyodark.nvim",
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
    },
    { "fcancelinha/northern.nvim", branch = "master", priority = 1000 },
    {
        "pauchiner/pastelnight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ray-x/starry.nvim",
        config = function()
            require("starry").setup({
                border = true, -- Split window borders
                italics = {
                    comments = false, -- Italic comments
                    strings = false, -- Italic strings
                    keywords = false, -- Italic keywords
                    functions = false, -- Italic functions
                    variables = false, -- Italic variables
                },

                contrast = { -- Select which windows get the contrast background
                    enable = true, -- Enable contrast
                    terminal = true, -- Darker terminal
                    filetypes = {}, -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
                },

                text_contrast = {
                    lighter = false, -- Higher contrast text for lighter style
                    darker = false, -- Higher contrast text for darker style
                },

                disable = {
                    background = true, -- true: transparent background
                    term_colors = false, -- Disable setting the terminal colors
                    eob_lines = false, -- Make end-of-buffer lines invisible
                },

                style = {
                    name = "moonlight", -- Theme style name (moonlight, earliestsummer, etc.)
                    -- " other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
                    disable = {}, -- a list of styles to disable, e.g. {'bold', 'underline'}
                    fix = true,
                    darker_contrast = true, -- More contrast for darker style
                    daylight_swith = false, -- Enable day and night style switching
                    deep_black = true, -- Enable a deeper black background
                },

                custom_colors = {
                    variable = "#f797d7",
                },
                custom_highlights = {
                    LineNr = { fg = "#777777" },
                    Idnetifier = { fg = "#ff4797" },
                },
            })
        end,
    },
    "ray-x/aurora",
    "catppuccin/nvim",
    "olimorris/onedarkpro.nvim",
    "cpea2506/one_monokai.nvim",
    "yonlu/omni.vim",
    { "Mofiqul/dracula.nvim" },
    "jacoborus/tender.vim",
    "patstockwell/vim-monokai-tasty",
    "EdenEast/nightfox.nvim",
    "bluz71/vim-nightfly-guicolors",
    "bluz71/vim-moonfly-colors",
    "rebelot/kanagawa.nvim",
    "NLKNguyen/papercolor-theme",
    "cryptomilk/nightcity.nvim",
    "shaunsingh/moonlight.nvim",
    "shaunsingh/nord.nvim",
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nordic").load()
        end,
    },
    {
        "svermeulen/text-to-colorscheme.nvim",
        config = function()
            vim.o.background = "dark"

            require("text-to-colorscheme").setup({
                ai = {
                    -- O#:Another case of missing api key
                    openai_api_key = "",
                },
            })
        end,
        keys = {
            {
                "<C-f><C-i>",
                function()
                    vim.ui.input({ prompt = "Text to inspire from ?" }, function(msg)
                        vim.api.nvim_exec(string.format("T2CGenerate %s", msg), false)
                    end)
                end,
                desc = "Text To Colorscheme",
            },
        },
    },
    {
        "zootedb0t/citruszest.nvim",
        lazy = false,
        priority = 1000,
    },
    { "pineapplegiant/spaceduck", branch = "dev" },
    {
        "navarasu/onedark.nvim",
        opts = { style = "deep" },
        init = function()
            require("onedark").load()
        end,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                -- Recommended - see "Configuring" below for more config options
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
                borderless_telescope = true,
            })
            vim.cmd("colorscheme cyberdream") -- set the colorscheme
        end,
    },
    {
        "crispybaccoon/evergarden",
        opts = {
            transparent_background = true,
            contrast_dark = "medium", -- 'hard'|'medium'|'soft'
            overrides = {},  -- add custom overrides
        },
    },
    "rafamadriz/neon",
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup({
                -- optional configuration here
            })
            require("bamboo").load()
        end,
    },
    "sainnhe/sonokai",
    "marko-cerovac/material.nvim",
    { "projekt0n/github-nvim-theme" },
    "sainnhe/gruvbox-material",
}
