return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        build = ":Copilot auth",
        opts = {
            panel = {
                enabled = false,
                auto_refresh = true,
            },
            suggestion = {
                enabled = false,
                auto_trigger = false,
                keymap = {
                    next = '<M-k>',
                    accept_word = '<M-l>',
                    accept_line = '<M-j>',
                },
            },
            filetypes = {
                markdown = true,
                yaml = true,
                gitcommit = true,
                gitrebase = true,
            },
            copilot_node_command = "node"
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        event = { "InsertEnter", "LspAttach" },
    }
}
