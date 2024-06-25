return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            'windwp/nvim-autopairs',
            "nat-418/cmp-color-names.nvim",
            "hrsh7th/cmp-buffer",
            'andersevenrud/cmp-tmux',
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "rcarriga/cmp-dap",
            "mtoohey31/cmp-fish",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-git",
            "dmitmel/cmp-cmdline-history",
            "David-Kunz/cmp-npm",
            "davidsierradz/cmp-conventionalcommits",
            "chrisgrieser/cmp-nerdfont",
            "bydlw98/cmp-env",
            "ray-x/cmp-treesitter",
            "lukas-reineke/cmp-rg",
            "f3fora/cmp-spell",
            "dcampos/cmp-emmet-vim",
            "zbirenbaum/copilot-cmp",
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
            "kristijanhusak/vim-dadbod-completion",
        },
        init = function()
            function Has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            function Feedkey(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            -- Set up lspconfig.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            local cmp = require("cmp")
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'conventionalcommits', keyword_length = 0 },
                    { name = 'git' },
                })
            })

            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = 'treesitter'},
                    { name = 'buffer'},
                    { name = 'nvim_lsp'},
                    { name = 'tmux'}
                }
            })

            -- require("copilot_cmp").setup({});
            require("cmp_git").setup({});
            require('cmp-npm').setup({});
            require('cmp-color-names').setup();
            local cmp_buffer = require('cmp_buffer')

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'cmdline' }, -- You can specify the `cmp_git` source if you were installed it.
                    -- { name = 'copilot', group_index = 1 },
                    { name = 'path' },
                    { name = 'env', option = { eval_on_confirm = true }, group_index = 2 },
                    { name = 'buffer', keyword_length = 3, group_index = 2 },
                    { name = 'cmdline_history', group_index = 3},
                })
            })

            cmp.setup.cmdline('?', {
                view = {
                    entries = {
                        name = 'custom', maxwidth = 50, maxheight = 10, separator = '||'
                    },
                },
                mapping = cmp.mapping.preset.cmdline(),
                sorting = {
                    comparators = {
                        function(...) return cmp_buffer:compare_locality(...) end,
                    }
                },
                sources = cmp.config.sources({
                    { name = 'buffer', keyword_length = 1, option = { keyword_pattern = [[\k\+]]}},
                    { name = 'rg', keyword_length = 3},
                    { name = 'path' },
                    { name = 'treesitter' },
                })
            })

            cmp.setup.cmdline('/', {
                view = {
                    entries = {
                        name = 'custom', maxwidth = 50, maxheight = 10, separator = '||'
                    },
                },
                mapping = cmp.mapping.preset.cmdline(),
                sorting = {
                    comparators = {
                        function(...) return cmp_buffer:compare_locality(...) end,
                    }
                },
                sources = cmp.config.sources({
                    { name = 'buffer', keyword_length = 1},
                    { name = 'rg', keyword_length = 3},
                    { name = 'path' },
                    { name = 'treesitter' },
                })
            })
        end,
    opts = function()
        -- For cmp floating window
        local border = {
            { "╔", "FloatBorder" },
            { "═", "FloatBorder" },
            { "╗", "FloatBorder" },
            { "║", "FloatBorder" },
            { "╝", "FloatBorder" },
            { "═", "FloatBorder" },
            { "╚", "FloatBorder" },
            { "║", "FloatBorder" },
        }
        local cmp = require("cmp")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        return {
            preselect = cmp.PreselectMode.None,
            sorting = {
                priority_weight = 5,
                comparators = {
                    cmp.config.compare.score,
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.exact,
                    cmp.config.compare.kind,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.offset,
                    -- Below is the default comparitor list and order for nvim-cmp
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.locality,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                }
            },
                snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:Pmenu,CursorLine:PmenuSel",
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = {
                        Text = "",
                        Method = "",
                        Function = "",
                        Constructor = "",
                        Field = "",
                        Variable = "",
                        Class = "",
                        Interface = "",
                        Module = "",
                        Property = "",
                        Unit = "",
                        Value = "",
                        Enum = "",
                        Keyword = "",
                        Snippet = "",
                        Color = "",
                        File = "",
                        Reference = "",
                        Folder = "",
                        EnumMember = "",
                        Constant = "",
                        Struct = "",
                        Event = "",
                        Operator = "",
                        Copilot  = "",
                        TypeParameter = ""
                    }
                })(entry, vim_item)
                return kind
            end,
        },
        mapping = {
                ['<A-k>'] = cmp.mapping.scroll_docs(-4),
                ['<A-j>'] = cmp.mapping.scroll_docs(4),
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<A-CR>'] = cmp.mapping.complete(),
                ['<C-c>'] = cmp.mapping.abort(),
                ['<C-x>'] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if vim.fn["vsnip#available"](1) == 1 then
                        Feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s", "c", "n"}),
                ["<S-Tab>"] = cmp.mapping(function()
                    if vim.fn["vsnip#jumpable"](-1) == 1 then
                        Feedkey("<Plug>(vsnip-jump-prev)", "")
                    elseif has_words_before() then
                        cmp.complete()
                    end
                end, { "i", "s", "c", "n"}),
            },
            enabled = function()
                local
                buftype = vim.api.nvim_buf_get_option(0, "buftype")
                if buftype == "prompt" then return false end
                return vim.g.cmp_toggle
            end,
            sources = cmp.config.sources({
                { name = 'copilot', group_index = 1, max_item_count = 9 },
                { name = 'nvim_lsp', group_index = 1, max_item_count = 9 },
                { name = 'nvim_lsp_signature_help', group_index = 1, max_item_count = 9 },
                { name = 'treesitter', group_index = 1, max_item_count = 9 },
                { name = 'nvim_lua', group_index = 1, max_item_count = 9 },
                { name = 'tmux', group_index = 1, max_item_count = 3 },
                { name = 'fish' },
                { name = 'vim-dadbod-completion', group_index = 1 },
                { name = 'buffer', keyword_length = 3, group_index = 2, option = { keyword_pattern = [[\k\+]]}, max_item_count = 4 },
                --{ name = 'conventionalcommits', group_index = 1, keyword_length = 0},
                -- { name = 'emmet_vim', group_index = 1, keyword_length = 1 },
                { name = 'path', option = { trailing_slash = true }, group_index = 3 },
                { name = 'emmet', group_index = 2, keyword_length = 1 },
                { name = 'vsnip', group_index = 3, keyword_length = 2, max_item_count = 3 },
                { name = 'calc', group_index = 2 },
                { name = 'nvim_lua', group_index = 2 },
                { name = 'buffer', keyword_length = 3, group_index = 2 },
                { name = 'env', option = { eval_on_confirm = true }, group_index = 3 },
                --{ name = 'lab.quick_data', keyword_length = 3},
                { name = 'rg', keyword_length = 3, group_index = 3, option = { context_after = 5, context_before = 3, additional_arguments = { '--hidden', '--files', "--max-depth 2"} }, max_item_count = 3 },
                { name = 'npm', keyword_length = 4, group_index = 4, option = { only_latest_version = true }},
            }),
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
            },
        }
    end
  },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    {
        "ray-x/lsp_signature.nvim",
        cond = true,
        event = "VeryLazy",
        opts = {
            bind = false,
            noice = false,
            hint_enable = false,
            max_height = 30,
            handlers_opts = {
                border = "shadow"
            }
        },
        config = function(_, opts) require'lsp_signature'.setup(opts) end,
    },
    { "nat-418/cmp-color-names.nvim" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-calc" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/cmp-git" },
    { "dmitmel/cmp-cmdline-history" },
    { "David-Kunz/cmp-npm" },
    { "davidsierradz/cmp-conventionalcommits" },
    { "chrisgrieser/cmp-nerdfont" },
    { "bydlw98/cmp-env" },
    { "ray-x/cmp-treesitter" },
    { "lukas-reineke/cmp-rg" },
    { "f3fora/cmp-spell" },
    { "dcampos/cmp-emmet-vim" },
    {
        "zbirenbaum/copilot-cmp",
        opts = {
            event = { "InsertEnter", "LspAttach" },
            fix_pairs = true,
        },
        config = function ()
            require("copilot_cmp").setup()
        end
    },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/vim-vsnip-integ" }
}
