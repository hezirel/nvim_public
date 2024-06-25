return {
    {
        "MaximilianLloyd/tw-values.nvim",
        keys = {
            { "<C-m>w", "<cmd>TWValues<cr>", desc = "Tailwind CSS Viewer" },
        },
        opts = {
            border = "rounded", -- Valid window border style,
            show_unknown_classes = true, -- Shows the unknown classes popup
            focus_preview = true, -- Sets the preview as the current window
            copy_register = "", -- The register to copy values to,
            keymaps = {
                copy = "<C-y>"  -- Normal mode keymap to copy the CSS values between {}
            }
        }
    },
}
