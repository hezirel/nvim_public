return {
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = function()
            return {
                highlight = false,
                separator = "  ",
                depth_limit = 4,
                depth_limit_indicator = "…",
                safe_output = true,
                icons = {
                    Namespace     = " ",
                    Package       = " ",
                    Class         = " ",
                    Method        = " ",
                    Property      = " ",
                    Field         = " ",
                    Constructor   = " ",
                    Enum          = " ",
                    Interface     = " ",
                    Function      = "",
                    Variable      = "",
                    Constant      = " ",
                    String        = " ",
                    Number        = " ",
                    Boolean       = " ",
                    Array         = " ",
                    Object        = " ",
                    Key           = " ",
                    Null          = "ﳠ ",
                    EnumMember    = " ",
                    Struct        = " ",
                    Event         = " ",
                    Operator      = " ",
                },
            }
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local navic = require("nvim-navic")
            local signs = { error = ' ', warn = ' ', info = ' ', hint = '⚡'}
            return {
                options = {
                    globalstatus = true,
                    icons_enabled = true,
                    theme = "auto",
                },
                tabline = {
                    lualine_y = {
                        {
                            'tabs',
                            tab_max_length = 40,
                            max_length = vim.o.columns / 1.5,
                            mode = 2,
                            use_mode_colors = true,
                            tabs_color = {
                                -- Same values as the general color option can be used here.
                                active = 'lualine_a_visual',     -- Color for active tab.
                                inactive = 'lualine_a_inactive', -- Color for inactive tab.
                            },
                            fmt = function(name, context)
                                -- Show + if buffer is modified in tab
                                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                                local bufnr = buflist[winnr]
                                local mod = vim.fn.getbufvar(bufnr, '&mod')

                                return name .. (mod == 1 and ' Δ' or '')
                            end
                        }
                    }
                },
                winbar = {
                    lualine_a = {
                        {
                            'filename',
                            path = 1,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '🔒',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            }
                        },
                    },
                    lualine_c = {
                        {
                            'filetype',
                            icon_only = true,
                        },
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_z = {
                        {
                            'filename',
                            path = 1,
                            symbols = {
                                modified = '✍️',      -- Text to show when the file is modified.
                                readonly = '🔒',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            }
                        },
                    },
                },
                extensions = {
                    'aerial',
                    'nvim-tree',
                    'toggleterm',
                    'trouble',
                    'quickfix',
                    'lazy',
                    'fzf',
                    'fugitive'
                },
                sections = {
                    lualine_a = {
                        'mode'
                    },
                    lualine_b = {
                        {
                            'diagnostics',
                            icons_enabled = true,
                            symbols = signs,
                        },
                        {
                            function()
                                return
                                    vim.fn["db_ui#statusline"]({
                                        show = {
                                            'db_name', 'schema', 'table'
                                        },
                                        separator = ' > ',
                                        prefix = ' '
                                    })
                            end
                        }
                    },
                    lualine_c = {
                        'diff',
                        { navic.get_location, cond = navic.is_available },
                    },
                    lualine_x = {
                        {
                            require("noice").api.status.search.get,
                            cond = require("noice").api.status.search.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            'filetype',
                            icon_only = true,
                        },
                    },
                    lualine_y = {
                        {'branch'},
                        {
                            'progress',
                        },
                    },
                    lualine_z = {
                        'location',
                    }
                },
            }
        end
        },
        {
            "nvim-tree/nvim-web-devicons",
            lazy = true
        },
        {"ryanoasis/vim-devicons"},
        {"norcalli/nvim-colorizer.lua"},
        {"Yggdroot/indentLine", cond = false},
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = function()
                local highlight = {
                    "indent_level_1",
                    "indent_level_2",
                    "indent_level_3",
                    "indent_level_4",
                    "indent_level_5",
                    "indent_level_6",
                }
                local hooks = require("ibl.hooks")

                hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                    vim.api.nvim_set_hl(0, "indent_level_1", { fg = "#E06C75" })
                    vim.api.nvim_set_hl(0, "indent_level_2", { fg = "#E5C07B" })
                    vim.api.nvim_set_hl(0, "indent_level_3", { fg = "#98C379" })
                    vim.api.nvim_set_hl(0, "indent_level_4", { fg = "#56B6C2" })
                    vim.api.nvim_set_hl(0, "indent_level_5", { fg = "#61AFEF" })
                    vim.api.nvim_set_hl(0, "indent_level_6", { fg = "#C678DD" })
                    -- Set current position with bold effect
                end)
                vim.g.rainbow_delimiters = { highlight = highlight }
                hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
                return {
                    indent = {
                        char = {
                            "┃", "|", "╏", "╎", "┇", "┆", "┋", "┊",
                        },
                        tab_char = "",
                        highlight = highlight
                    },
                    scope = {
                        highlight = highlight,
                        char = {
                            "░"
                        },
                        show_exact_scope = true,
                    }
                }
        end
        },
        {
            "gen740/SmoothCursor.nvim",
            opts = {
                fancy = {
                    enable = true
                },
                speed = 25,
                intervals = 40,
                disable_float_win = true,
                treshold = 2,
            }
    },
    {
        "anuvyklack/fold-preview.nvim",
        opts = {
            border = "double"
        }
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                width = .95, -- width of the Zen window
                height = 1, -- height of the Zen window
                options = {
                    signcolumn = "yes", -- disable signcolumn
                    number = false, -- disable number column
                    relativenumber = false, -- disable relative numbers
                    foldcolumn = "0", -- disable fold column
                    list = false, -- disable whitespace characters
                },
                plugins = {
                    twilight = false, -- enable twilight plugin
                },
            },
        }
    },
    {
        "folke/todo-comments.nvim",
        opts = {
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "warning", -- can be a hex color, or a named color (see below)
                    alt = { "BUG", "FUCK", "_‡"}, -- a set of other keywords that all map to this FIX keywords
                },
                    TODO = { icon = "□", color = "#E06C75 ", alt = { "TODO", "_#", "O#"} },
                    DO = { icon = " ", color = "#E5C07B " , alt = { "DO_NEXT", "X_#", "X#"} },
                    DONE = { icon = "✓", color = "hint", alt = { "_/#", "/#", "I#" } },
                    RESEARCH = { icon = "λ", color = "#C678DD ", alt = { "RESEARCH", "_¿"} },
                    NOTE = { icon = " ", color = "#61AFEF ", alt = { "NOTE", "_€", "€"} },
                    MISC = { icon = "⚡", color = "#98C379", alt = { "_£"} },
                },
                gui_style = {
                    fg = "BOLD", -- The gui style to use for the fg highlight group.
                    bg = "NONE", -- The gui style to use for the bg highlight group.
                },
                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                -- highlighting of the line containing the todo comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    multiline = true,
                    multiline_pattern = "((.*))",
                    before = "", -- "fg" or "bg" or empty
                    keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after = "fg", -- "fg" or "bg" or empty
                    -- pattern = [[\t*<(KEYWORDS)\w*.?\w*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                    comments_only = false, -- uses treesitter to match keywords in comments only
                    max_line_len = 90, -- ignore lines longer than this
                    exclude = {}, -- list of file types to exclude highlighting
                },
                -- list of named colors where we try to extract the guifg from the
                -- list of highlight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#E06C75 " },
                    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    --pattern = [[\s*<(KEYWORDS):]], -- pattern or table of patterns, used for highlightng (vim regex)
                    -- pattern = [[.*<(KEYWORDS)\w*.?\w*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            }
    },
    {
        "folke/twilight.nvim",
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinNew" },
        opts = {
            --highlight for Window separator
            highlight = {
                bg = "#16161E",
                fg = "#41fdfe",
            },
            --timer refresh rate
            interval = 30,
            smooth = true,
            --This plugin will not be activated for filetype in the following table.
            no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "CommandLine"},
            --Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
            symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
            close_event = function()
                --Executed after closing the window separator
            end,
            create_event = function()
                --Executed after creating the window separator
            end,
        }
    },
    {
        '2kabhishek/termim.nvim',
        cmd = { 'Fterm', 'FTerm', 'Sterm', 'STerm', 'Vterm', 'VTerm' },
    },
    { "stevearc/dressing.nvim" },
    {
        "asiryk/auto-hlsearch.nvim",
        opts = {
            remap_keys = { "/", "?", "*", "#", "n", "N" },
            create_commands = true,
        }
    },
    {
        "chrisgrieser/nvim-early-retirement",
        config = true,
        event = "VeryLazy",
        opts = {
            notificationOnAutoClose = true,
        }
    },
    {
        "blueyed/vim-diminactive"
    },
    {
        "tpope/vim-markdown"
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = function()
            -- Add augroup command to auto set filetype as markdown in markdown file
            vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
            return {
                markdown = {
                    headline_highlights = { "Headline" },
                    bullets = { "◉", "○", "✸", "✿" },
                    codeblock_highlight = "",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = false,
                    fat_headline_upper_string = "▁",
                    fat_headline_lower_string = "▔",
                },
            }
        end
    },
    {
        "smjonas/live-command.nvim",
        config = function()
            require("live-command").setup {
                commands = {
                    Norm = { cmd = "norm" },
                },
            }
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            mode = "fuzzy",
            labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            label = {
                rainbow = {
                    enable = true
                }
            },
            modes = {
                char = {
                    keys = {}
                }
            }
        },
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
}
