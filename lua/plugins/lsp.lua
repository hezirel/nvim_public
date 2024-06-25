return {
    {
        "aznhe21/actions-preview.nvim",
        opts = function()
            return {
                diff = {
                    algorithm = "patience",
                    ignore_whitespace = true,
                },
                telescope = require("telescope.themes").get_dropdown { winblend = 5 },
            }
        end
    },
    require("plugins.lspconfig"),
    require('plugins.lspsaga'),
    "antosha417/nvim-lsp-file-operations",
    "onsails/lspkind.nvim",
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile", "BufWritePre" },
        opts = function ()
            local null_ls = require("null-ls");
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            return {
                log_level = "off",
                sources = {
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.blade_formatter,
                    null_ls.builtins.formatting.reorder_python_imports,
                    null_ls.builtins.completion.vsnip,
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.code_actions.gomodifytags,
                    null_ls.builtins.code_actions.impl,
                    --null_ls.builtins.code_actions.gitsigns,
                    --null_ls.builtins.diagnostics.eslint.with,
                    --null_ls.builtins.formatting.shfmt,
                    -- null_ls.builtins.code_actions.refactoring,
                    --null_ls.builtins.diagnostics.pycodestyle,
                    --null_ls.builtins.formatting.rustfmt,
                    --null_ls.builtins.formatting.lua_format,
                    --null_ls.builtins.formatting.lua_fmt,
                    --null_ls.builtins.formatting.lua,
                    null_ls.builtins.diagnostics.eslint,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end
                                                    
                        })
                    end
                end,
            }
        end
    },
    "jose-elias-alvarez/typescript.nvim",
    {
        "amrbashir/nvim-docs-view",
        config = function()
            require("docs-view").setup({})
        end
    },
    {
        "dmmulroy/tsc.nvim",
        config = function()
            require("tsc").setup({})
        end
    },
    {
        "MunifTanjim/prettier.nvim",
        config = function()
            local prettier = require("prettier")
            prettier.setup({})
        end
    },
}
