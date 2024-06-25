return {
    {
        "DreamMaoMao/yazi.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },

        keys = {
            { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local lib = require("nvim-tree.lib")
            local view = require("nvim-tree.view")

            local function collapse_all()
                require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
            end

            local function edit_or_open()
                -- open as vsplit on current node
                local action = "edit"
                local node = lib.get_node_at_cursor()

                -- Just copy what's done normally with vsplit
                if node.link_to and not node.nodes then
                    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
                    view.close() -- Close the tree if file was opened
                elseif node.nodes ~= nil then
                    lib.expand_or_collapse(node)
                else
                    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
                    view.close() -- Close the tree if file was opened
                end
            end

            function My_on_attach(bufnr)
                local api = require("nvim-tree.api")
                api.events.subscribe(api.events.Event.FileCreated, function(file)
                    vim.cmd("edit " .. file.fname)
                    vim.cmd("call SetSkeleton(expand('%:e'))")
                end)
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
                vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
                vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
                vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
                vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
                vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
                vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
                vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
                vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
                vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
                vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create"))
                vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
                vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
                vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
                vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
                vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
                vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
                vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
                vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
                vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
                vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
                vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
                vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
                vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
                vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
                vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
                vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
                vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
                vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
                vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
                vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
                vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
                vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
                vim.keymap.set("n", "q", api.tree.close, opts("Close"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
                vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
                vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
                vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
                vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
                vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
                vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
                vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
                vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
                vim.keymap.set("n", "l", edit_or_open, opts("Open"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create"))
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse"))
            end
            require("nvim-tree").setup({
                view = {
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    -- mappings = {
                        --     custom_only = false,
                        -- },
                        width = function()
                            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                        end,
                    },
                    renderer = {
                        indent_markers = {
                            enable = true,
                        },
                        icons = {
                            git_placement = "after",
                        },
                    },
                    actions = {
                        open_file = {
                            quit_on_open = false,
                        },
                    },
                    on_attach = My_on_attach,
                })
            end,
        },
        {
            "stevearc/oil.nvim",
            opts = {},
            -- Optional dependencies
            dependencies = { "nvim-tree/nvim-web-devicons" },
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
            },
        },
    }
