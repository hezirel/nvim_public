return {
    {
        "tpope/vim-dadbod",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        config = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_execute_on_save = 0
            vim.g.db_ui_force_echo_notifications = 1
            vim.g.db_ui_table_helpers = {
               sqlserver = {
                    List = 'SELECT TOP 500 * FROM "{table}"',
                    count = 'SELECT COUNT(*) FROM "{table}"'
                }
            }
        end,
        dependencies = {
            {
                "kristijanhusak/vim-dadbod-completion"
            }
        }
    }
}
