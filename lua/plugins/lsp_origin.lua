local keymap = vim.keymap.set
local lsp_flags = {
    debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local event = "BufWritePre" -- or "BufWritePost"
local navic = require("nvim-navic")
local noice = require("noice")

local function taskwarrior_active_task()
    local task_id = vim.fn.system("task _get $(task _ids +ACTIVE).id")
    local task_description = vim.fn.system("task _get $(task _ids +ACTIVE).description")
    local res = string.gsub((task_id .. "/" .. task_description), "\n", "") or nil
    return task_id ~= "" and res or nil
end
