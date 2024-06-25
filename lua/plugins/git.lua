return {
    { "lewis6991/gitsigns.nvim",
        config = function ()
            require("gitsigns").setup({})
        end
    },
    { "ldelossa/litee.nvim" },
    { "ldelossa/gh.nvim" },
    {
        url = "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
        lazy = false,
        cond = false,
    },
    {
        "pwntester/octo.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        cond = false,
        config = function ()
            require("octo").setup({})
        end
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "shumphrey/fugitive-gitlab.vim",
    },
    { "kdheepak/lazygit.nvim",
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
    {
        "wintermute-cell/gitignore.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        'mbbill/undotree'
    },
    {
        "harrisoncramer/gitlab.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
            "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
        },
        enabled = true,
        build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
        config = function()
            require("gitlab").setup({
                debug = { go_request = true, go_response = true },
                reviewer_settings = {
                    diffview = {
                        imply_local = false,
                    },
                },
                popup = {
                    perform_action = "<leader>Yx"
                },
            })
        end,
    }
}
