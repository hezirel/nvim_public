return {
    {
        "HiPhish/rainbow-delimiters.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            local rainbow_delimiters = require("rainbow-delimiters")

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                -- _€:Le color pattern de guitar hero a la base :)
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }

            configs.setup({
                autotag = {
                    enable = true,
                    filetypes = { "html", "xml", "json", "tsx", "jsx", "php" },
                },
                ensure_installed = "all",
                auto_install = true,
                highlight = {
                    enable = true,
                },
            })
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.d2 = {
                install_info = {
                    url = "https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2",
                    revision = "main",
                    files = { "src/parser.c", "src/scanner.cc" },
                },
                filetype = "d2",
            }

            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }
        end,
    },
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            separator = "=",
        },
    },
}
