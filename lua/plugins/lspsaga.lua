return {
    "nvimdev/lspsaga.nvim",
    opts = function()
        return {
            ui = {
                title = true,
                border = "double",
                winblend = 3,
                actionfix = " ",
                code_action = "",
                hover = " ",
                expand = "",
                collapse = "",
                kind = {
                    ["Text"] = { "", "String" },
                    ["Method"] = { "", "Function" },
                    ["Function"] = { "", "Function" },
                    ["Constructor"] = { "", "@constructor" },
                    ["Field"] = { "", "@field" },
                    ["Variable"] = { "", "@variable" },
                    ["Class"] = { "ﴯ", "Include" },
                    ["Interface"] = { "", "Type" },
                    ["Module"] = { "", "Exception" },
                    ["Property"] = { "ﰠ", "@property" },
                    ["Unit"] = { "", "Number" },
                    ["Value"] = { "", "@variable" },
                    ["Enum"] = { "", "@number" },
                    ["Key"] = { "", "" },
                    ["Snippet"] = { "", "@variable" },
                    ["File"] = { "", "Tag" },
                    ["Folder"] = { "", "Title" },
                    ["EnumMember"] = { "", "Number" },
                    ["Constant"] = { "", "Constant" },
                    ["Struct"] = { "", "Type" },
                    ["Event"] = { "", "Constant" },
                    ["Operator"] = { "", "Operator" },
                    ["TypeParameter"] = { "", "Type" },
                }
            },
            symbol_in_winbar = {
                enable = false
            },
            code_action = {
                show_server_name = true,
                num_shortcut = true,
            },
            finder = {
                max_height = 1,
                keys = {
                    shuttle = '	',
                    split = 'x',
                    vsplit = 'v'
                },
                methods = {
                    "tyd" == "textDocument/typeDefinition",
                    "imp" == "textDocument/implementation",
                },
                default = 'tyd+def+ref+imp'
            }
        }
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    }
}
