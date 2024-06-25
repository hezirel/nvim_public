return {
    { "nvim-lua/plenary.nvim" },
    { "christoomey/vim-tmux-navigator" },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = function()
            require("luarocks-nvim").setup({})
        end,
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "luarocks.nvim" },
        config = function()
            require("rest-nvim").setup({
                result = {
                    split = {
                        horizontal = true,
                        stay_in_current_window_after_split = false,
                    }
                }
            })
        end,
    },
    {
        'tsandall/vim-rego',
    },
    {
        "vim-autoformat/vim-autoformat"
    }
}
