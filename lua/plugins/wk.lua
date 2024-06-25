return {
    "folke/which-key.nvim",
    dependencies = {
        "anuvyklack/keymap-amend.nvim",
    },
    init = function()
        local wk = require("which-key")

        local tabrename = function()
            vim.ui.input({ prompt = "Rename tab to ?" }, function(msg)
                if not msg then
                    return
                end
                vim.api.nvim_exec(string.format("LualineRenameTab %s", msg), false)
            end)
        end

        local devdocs = function()
            vim.ui.input({ prompt = "Docs to open ?" }, function(msg)
                if not msg then
                    return
                end
                vim.api.nvim_exec(string.format("DevdocsOpen %s", msg), false)
            end)
        end

        local pickers = require("telescope.pickers")

        local function insert_markdown_fence(language, original_pos)
            -- Immediate capture of the buffer to recall its essence
            local buffer = vim.api.nvim_get_current_buf()

            -- Crafting the markdown magic with the user's chosen language
            local markdown_fence = { "```" .. language, "", "```" }

            -- Insert the markdown fence into the buffer, right at the cursor's original coordinate, saved against the fabric of time
            vim.api.nvim_buf_set_lines(buffer, original_pos[1], original_pos[1], false, markdown_fence)

            -- Calculating the new position within the markdown sanctuary and transitioning into insert mode
            local insertion_point = original_pos[1] + 2
            vim.api.nvim_win_set_cursor(0, { insertion_point, 0 })
            vim.api.nvim_input("A")
        end

        local function language_picker()
            -- Immediate capture of the cursor's position to anchor it against time's flow before `pickers.new` resets it
            local cursor_position = vim.api.nvim_win_get_cursor(0)

            pickers
                .new({}, {
                    prompt_title = "Language for markdown fence: ",
                    finder = require("telescope.finders").new_table({
                        results = {
                            "bash",
                            "c",
                            "cpp",
                            "css",
                            "dart",
                            "dockerfile",
                            "elixir",
                            "go",
                            "html",
                            "java",
                            "javascript",
                            "json",
                            "lua",
                            "markdown",
                            "php",
                            "python",
                            "ruby",
                            "rust",
                            "sql",
                            "shell",
                            "typescript",
                            "vim",
                            "yaml",
                        },
                    }),
                    sorter = require("telescope.config").values.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr)
                        require("telescope.actions.set").select:replace(function(_, type)
                            local entry = require("telescope.actions.state").get_selected_entry()
                            require("telescope.actions").close(prompt_bufnr)
                            -- Reusing the cursor position captured before `pickers.new` was invoked
                            insert_markdown_fence(entry.value, cursor_position)
                        end)
                        return true
                    end,
                })
                :find()
        end

        wk.register({
            c = { "<cmd>Telescope commands<cr>", "Commands FZF" },
            C = { "<cmd>lua require('notify').dismiss()<CR>", "Clear Notifs" },
            l = { "<cmd>LazyGit<cr>", "LazyGit" },
            t = { "<cmd>DimInactiveToggle<cr>", "Toggle Shade" },
            m = { "<cmd>MindOpenProject<CR>", "Open Mind Tree" },
            ["<leader>"] = { "<cmd>Telescope<CR>", "Telescope" },
        }, { prefix = "<leader>" })

        wk.register({
            name = "+Telescope",
            a = { "<cmd>Telescope treesitter find_command=rg,--ignore,--hidden,--files theme=ivy<CR>", "treesitter" },
            es = { "<cmd>Telescope symbols find_command=rg, theme=dropdown<CR>", "Symbols" },
            eg = { "<cmd>Telescope gitmoji find_command=rg, theme=cursor<CR>", "GitMojis" },
            eh = { "<cmd>Telescope emoji find_command=rg, theme=cursor<CR>", "Emojis" },
            ev = { "<cmd>Telescope env find_command=rg, theme=dropdown<CR>", "Env" },
            s = {
                "<cmd>Telescope lsp_document_symbols find_command=rg,--ignore,--hidden,--files theme=ivy<CR>",
                "lsp_document_symbols",
            },
            y = { "<cmd>Telescope neoclip theme=ivy<CR>", "Neoclip" },
            cs = { "<cmd>Telescope tailiscope theme=ivy<CR>", "tailwind css" },
            cc = { "<cmd>Telescope conventional_commits theme=dropdown<CR>", "conventional commit" },
            w = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols find_command=rg,--ignore,--hidden,--files theme=ivy<CR>",
                "lsp_dynamic_workspace_symbols",
            },
            j = { "<cmd>Telescope jumplist theme=ivy<CR>", "Jumplist" },
            h = { "<cmd>Telescope help_tags find_command=rg theme=ivy prompt_prefix=⚕️<CR>", "help_tags" },
            b = {
                "<cmd>Telescope buffers find_command=rg,--ignore,--hidden,--files theme=ivy prompt_prefix=📜<CR>",
                "buffers",
            },
            F = {
                "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args() theme=ivy<CR>",
                "find_files with args",
            },
            t = { "<cmd>Telescope telescope-tabs list_tabs find_command=rg theme=ivy prompt_prefix=⚕️<CR>", "Tabs" },
            f = {
                "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files previewer=true theme=ivy<CR>",
                "find_files",
            },
            p = { "<cmd>Telescope live_grep_args find_command=rg,--ignore,--hidden,--files theme=ivy<CR>", "live_grep" },
            r = { "<cmd>Telescope registers find_command=rg,--ignore,--hidden,--files theme=dropdown<CR>", "registers" },
            gf = { "<cmd>Telescope git_files find_command=rg,--ignore,--hidden,--files theme=ivy<CR>", "git_files" },
            gi = { "<cmd>Gitignore<CR>", ".gitignore" },
            n = {
                "<cmd>Telescope live_grep search_dirs=$TASKN/ theme=ivy prompt_prefix=📔 find_command=rg,--ignore,--hidden,--files<CR>",
                "live_grep notes",
            },
            o = { "<cmd>DevdocsOpenCurrent<CR>", "Dev Docs Current Filetype" },
            O = { devdocs, "Dev Docs Select" },
            z = {
                "<cmd>Telescope current_buffer_fuzzy_find find_command=rg, theme=ivy<CR>",
                "current_buffer_fuzzy_find",
            },
            d = { "<cmd>Telescope diagnostics find_command=rg theme=ivy prompt_prefix=⚕️<CR>", "diagnostics" },
            D = {
                "<cmd>Telescope aerial find_command=rg,--ignore,--hidden,--files theme=ivy sorting_strategy=descending prompt_prefix=📚<CR>",
                "aerial",
            },
            m = { "<cmd>Telescope marks find_command=rg,--ignore,--hidden,--files<CR>", "marks" },
            c = { "<cmd>Telescope docker<CR>", "marks" },
            q = { "<cmd>lua require('telescope').extensions.macroscope.default()<CR>", "macroscope" },
            l = { "<cmd>Telescope noice find_command=rg,--ignore,--hidden,--files theme=ivy<CR>", "noice" },
            [";"] = { "<cmd>lua require('telescope.builtin').resume()<CR>", "resume" },
        }, { prefix = "<C-p>", noremap = true, silent = true })

        wk.register({
            name = "+Lsp",
            K = { "<cmd>Lspsaga hover_doc ++keep<CR>", "Hover doc" },
            a = { "<cmd>lua require('actions-preview').code_actions()<CR>", "Code Action" },
            f = { "<cmd>Lspsaga finder<CR>", "Lsp Finder" },
            o = { "<cmd>Lspsaga outline<CR>", "Outline" },
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            d = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
            D = { "<cmd>Lspsaga goto_definition<CR>", "GoTo Definition" },
            t = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definition" },
            T = { "<cmd>Lspsaga goto_type_definition<CR>", "GoTo Type Definition" },
        }, { prefix = "<C-m>", noremap = true, silent = true })

        wk.register({
            name = "+Trouble",
            p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev trouble" },
            n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next trouble" },
            d = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor Diagnostic" },
            D = { "<cmd>Telescope docker<CR>", "Docker Telescope" },
            E = {
                '<cmd>lua require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>',
                "Prev Error",
            },
            e = {
                '<cmd>lua require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>',
                "Next Error",
            },
            c = { "<cmd>TSContextToggle<CR>", "Toggle Context Display" },
            r = { "<cmd>Telescope tasks theme=ivy<CR>", "Tasks Runner" },
            l = { "<cmd>exe ':TodoTrouble cwd=' .. fnameescape(expand('%:p'))<CR>", "Todo Trouble" },
        }, { prefix = "<C-t>", noremap = true, silent = true })

        wk.register({
            name = "+NeoTest",
            ["<C-r>"] = { "<cmd>lua require('neotest').run.run()<CR>", "Test Run" },
            ["<C-a>"] = { "<cmd>lua require('neotest').run.attach()<CR>", "run" },
            ["<C-s>"] = { "<cmd>lua require('neotest').summary.open()<CR>", "Test Summary" },
            ["w"] = { "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>", "Run Test Watch Mode" },
            ["h"] = { "<Plug>RestNvim", "Run Rest Nvim Query" },
        }, { prefix = "<C-t>", noremap = true, silent = true })

        wk.register({
            name = "+Todo Trouble",
            ["<C-d>"] = { ":s/[_XO]#/I#/g<CR>", "Achieve mission" },
            ["<C-s>"] = { ":s/[_XO]/\\=submatch(0) == 'O' ? 'X' : 'O'/<CR>", "Initiate mission" },
        }, { prefix = "<C-t>", noremap = true, silent = true, mode = "v" })

        wk.register({
            name = "+Golang",
            ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Golang Show Impl" },
            ["h"] = { "<cmd>GoToggleInlay<CR><BAR><cmd>GoToggleInlay<CR>", "Toggle Inline Inlay Hints" },
            ["e"] = { "<cmd>GoIfErr<CR>", "Err Check" },
            ["c"] = { "<cmd>GoCmt<CR>", "Comment method" },
            ["f"] = { "<cmd>GoFillStruct<CR>", "Fill Tags" },
            ["d"] = { "<cmd>GoDoc<CR>", "Show Doc" },
            ["m"] = { "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>", "Golang Implement interface" },
        }, { prefix = "<C-g>", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "+Snippet",
            ["y"] = { "<Plug>(vsnip-select-text)<CR>", "Vsnip Yank Select" },
            ["d"] = { "<Plug>(vsnip-cut-text)<CR>", "Vsnip Cut Select" },
        }, { prefix = "g", noremap = true, silent = true, mode = "v" })

        wk.register({
            name = "Buffers",
            ["d"] = { "<cmd>bd<CR>", "Close Current Buffer" },
            ["o"] = { "<cmd>%bd|e#<CR>", "Close all except current" },
            r = { tabrename, "Rename Tab" },
        }, { prefix = "<C-w>", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "DAP",
        }, { prefix = "<leader>d", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "Md",
            f = { language_picker, "Insert Markdown Fence" },
        }, { prefix = "<C-w>", noremap = true, silent = true, mode = "i" })

        wk.register({
            name = "+Gen.nvim",
        }, { prefix = "<leader>G", noremap = true, silent = true, mode = { "n", "v" } })

        wk.register({
            name = "+Misc",
            ["<C-f>"] = { "<cmd>ZenMode<CR>", "Zen Mode" },
            ["<C-d>"] = { "<cmd>TwilightDisable<CR>", "Disable Twilight" },
            ["<C-r>"] = { "<cmd>Telescope themes<CR>", "Switch Colorscheme" },
            ["<C-t>"] = { "<cmd>FTerm<CR>", "Floating Terminal" },
            ["<C-m>"] = { "<cmd>setl ft=markdown<CR>", "Enable Md Syntax Highlights" },
        }, { prefix = "<C-f>", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "+DBUI",
            t = { "<cmd>DBUIToggle<CR>", "Toggle DBUI" },
            jt = { "<cmd>call db_ui#dbout#jump_to_foreign_table()<CR>", "Jump to FK" },
        }, { prefix = "<leader>s", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "+Gitlab",
            v = { "<cmd>lua require('gitlab').review()<CR>", "Gitlab Review" },
            s = { "<cmd>lua require('gitlab').summary()<CR>", "Gitlab Summary" },
            A = { "<cmd>lua require('gitlab').approve()<CR>", "Gitlab Approve" },
            R = { "<cmd>lua require('gitlab').revoke()<CR>", "Gitlab Revoke" },
            c = { "<cmd>lua require('gitlab').create_comment()<CR>", "Create Comment", mode = "n" },
            U = { "<cmd>lua require('gitlab').create_multiline_comment()<CR>", "Create Multiline Comment", mode = "v" },
            C = {
                "<cmd>lua require('gitlab').create_comment_suggestion()<CR>",
                "Create Comment Suggestion",
                mode = "v",
            },
            O = { "<cmd>lua require('gitlab').create_mr()<CR>", "Create Merge Request" },
            m = {
                "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>",
                "Move To Discussion Tree From Diagnostic",
            },
            n = { "<cmd>lua require('gitlab').create_note()<CR>", "Create Note" },
            d = { "<cmd>lua require('gitlab').toggle_discussions()<CR>", "Toggle Discussions" },
            ["aa"] = { "<cmd>lua require('gitlab').add_assignee()<CR>", "Add Assignee" },
            ["ad"] = { "<cmd>lua require('gitlab').delete_assignee()<CR>", "Delete Assignee" },
            ["lla"] = { "<cmd>lua require('gitlab').add_label()<CR>", "Add Label" },
            ["lld"] = { "<cmd>lua require('gitlab').delete_label()<CR>", "Delete Label" },
            ["ra"] = { "<cmd>lua require('gitlab').add_reviewer()<CR>", "Add Reviewer" },
            ["rd"] = { "<cmd>lua require('gitlab').delete_reviewer()<CR>", "Delete Reviewer" },
            p = { "<cmd>lua require('gitlab').pipeline()<CR>", "Gitlab Pipeline" },
            o = { "<cmd>lua require('gitlab').open_in_browser()<CR>", "Open In Browser" },
            M = { "<cmd>lua require('gitlab').merge()<CR>", "Merge" },
        }, { prefix = "<leader>Y", noremap = true, silent = true, mode = "n" })

        wk.register({
            name = "+ChatGPT",
            c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
            e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
            g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
            t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
            k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
            d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
            a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
            o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
            s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
            f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
            x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
            r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
            n = { "<cmd>AIChat<CR>", "Next AI Chat", mode = { "n", "v" } },
            N = { "<cmd>AINewChat tab<CR>", "New Nox Chat", mode = { "n", "v" } },
            l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
        }, { prefix = "<leader>g", noremap = true, silent = true, mode = "n" })
    end,
    opts = {
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { ugc = "Comments" },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "double",
            position = "bottom",
            margin = { 1, 0, 3, 0 },
            padding = { 2, 2, 2, 2 },
        },
        layout = {
            height = { min = 4, max = 25 },                                     -- min and max height of the columns
            width = { min = 20, max = 50 },                                     -- min and max width of the columns
            spacing = 3,                                                        -- spacing between columns
            align = "center",                                                   -- align columns left, center or right
        },
        ignore_missing = false,                                                 -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                       -- show help message on the command line when the popup is visible
        triggers = "auto",                                                      -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by deafult for Telescope
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    },
}
