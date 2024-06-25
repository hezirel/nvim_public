return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {

            {
                "rcarriga/nvim-dap-ui",
                keys = {
                    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
                },
                opts = {},
                config = function(_, opts)
                    local dap = require("dap")
                    local dapui = require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open({})
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close({})
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close({})
                    end
                end,
            },
            'nvim-neotest/nvim-nio',
            {
                "theHamsta/nvim-dap-virtual-text",
                init = function ()
                    require("nvim-dap-virtual-text").setup({
                        enabled = true,                        -- enable this plugin (the default)
                        enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                        highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                        highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                        show_stop_reason = true,               -- show stop reason when stopped for exceptions
                        commented = true,                     -- prefix virtual text with comment string
                        only_first_definition = false,          -- only show virtual text at first definition (if there are multiple)
                        all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
                        clear_on_continue = false,
                        virt_text_pos = 'eol',
                    })
                end
            },

            -- which key integration
            {
                "folke/which-key.nvim",
                optional = true,
                opts = {
                    defaults = {
                        ["<leader>d"] = { name = "+debug" },
                        ["<leader>da"] = { name = "+adapters" },
                    },
                },
            },

            -- mason.nvim integration
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = "mason.nvim",
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    -- Makes a best effort to setup the various debuggers with
                    -- reasonable debug configurations
                    automatic_installation = true,

                    -- You can provide additional configuration to the handlers,
                    -- see mason-nvim-dap README for more information
                    handlers = {},

                    -- You'll need to check that you have the required things installed
                    -- online, please don't ask me how to install them :)
                    ensure_installed = {
                        -- Update this to ensure that you have the debuggers for the langs you want
                    },
                },
            },
        },

        -- stylua: ignore
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },

    },
    {
        "mfussenegger/nvim-dap-python",
        init = function ()
            if vim.env.VIRTUAL_ENV then
                local python_path = vim.env.VIRTUAL_ENV .. "/bin/python3"
                require('dap-python').setup(python_path)
            else
                require('dap-python').setup('/opt/homebrew/bin/python3')
            end
        end
    },
    {
        "LiadOz/nvim-dap-repl-highlights",
        init = function ()
            require('nvim-dap-repl-highlights').setup()
            require('nvim-dap-repl-highlights').setup_highlights('python')
        end
    },
    { 'mhartington/formatter.nvim' },
    {
        'praem90/nvim-phpcsf',
        init = function()
            -- TO SET IN PLUGIN CODE share/state/lazy
            local root = vim.loop.cwd()
            local phpcs_path = root .. "/PHP_CodeSniffer/bin/phpcs"
            local phpcbf_path = root .. "/PHP_CodeSniffer/bin/phpcbf"

            vim.g.nvim_phpcs_config_phpcs_path = phpcs_path
            vim.g.nvim_phpcs_config_phpcbf_path = phpcbf_path
            vim.g.nvim_phpcs_config_phpcs_standard = 'PSR12'
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        init = function ()
            require("mason-nvim-dap").setup({
                handlers = {
                    function(config)
                        -- all sources with no handler get passed here

                        -- Keep original functionality
                        require('mason-nvim-dap').default_setup(config)
                    end,
                },
            })
        end
    },
}
