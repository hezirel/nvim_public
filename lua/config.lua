local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct
HEIGHT_RATIO = 0.8     -- You can change this
WIDTH_RATIO = 0.8      -- You can change this too

require("lazy").setup({
    "folke/lazy.nvim",
    require("plugins.utils"),
    require("plugins.aerial"),
    require("plugins.ui"),
    require("plugins.wk"),
    require("plugins.treesitter"),
    require("plugins.nvimtree"),
    require("plugins.snippets"),
    require("plugins.noice"),
    require("plugins.mind"),
    require("plugins.git"),
    require("plugins.cmp"),
    require("plugins.lsp"),
    require("plugins.colors"),
    require("plugins.trouble"),
    require("plugins.telescope"),
    require("plugins.testing"),
    require("plugins.copilot"),
    require("plugins.fun"),
    require("plugins.db"),
    require("plugins.devdocs"),
    require("plugins.tailwind"),
    require("plugins.dap"),
    require("plugins.go"),
    require("plugins.python"),
    require("plugins.chatgpt"),
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.spell = false
vim.opt.spelllang = { "en_us", "fr" }

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
    },
    update_in_insert = true,
    float = {
        source = "always",
    },
})

local signs = { Error = " ", Warn = " ", Info = " ", Hint = "⚡" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
