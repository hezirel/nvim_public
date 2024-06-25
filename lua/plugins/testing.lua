return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-go",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            {
                "folke/neodev.nvim",
                opts = {
                    library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
                }
            },
        },
        opts = function ()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            return {
                adapters = {
                    require("neotest-plenary"),
                    require("neotest-go"),
                    --require("neotest-vim-test")({
                        --ignore_file_types = { "python", "vim", "lua" },
                        --}),
                    },
                    output = {
                        open_on_run = true,
                    },
                    icons = {
                        child_indent = "│",
                        child_prefix = "├",
                        collapsed = "─",
                        expanded = "╮",
                        failed = "",
                        final_child_indent = " ",
                        final_child_prefix = "╰",
                        non_collapsible = "─",
                        passed = "",
                        running = "",
                        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                        skipped = "",
                        unknown = "",
                    },
                }
        end
    },
}
