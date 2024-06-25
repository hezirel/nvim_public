return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = {} },
            { "williamboman/mason.nvim", opts = { PATH = "append" } },
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        init = function()
            local lsp_flags = {
                debounce_text_changes = 150,
            }
            --lsp_zero.extend_lspconfig()
            require("mason").setup()
            require('mason-lspconfig').setup({
                ensure_installed = {'tsserver', 'rust_analyzer'},
            })

            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            local lspconfig = require "lspconfig"
            local util = require "lspconfig/util"
            local navic = require("nvim-navic")

            require('lspconfig').quick_lint_js.setup {
                packageManager = 'yarn',
                flags = lsp_flags,
            }

            require("lspconfig").eslint.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            require("lspconfig").tsserver.setup({
                capabilities = capabilities,
                flags = lsp_flags,
                handlers = {
                    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                        virtual_text = true,
                        signs = true,
                        update_in_insert = true,
                    }),
                },
            })

            require("lspconfig").emmet_ls.setup {
                capabilities = capabilities,
                filetypes = { "html", "php", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                options = {
                    ["bem.enabled"] = true,
                    ["output.selfClosingStyle"] = "xhtml",
                    ["jsx.enabled"] = true,
                },
            }

            lspconfig.ruff_lsp.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client)
                    if client.name == 'ruff_lsp' then
                        client.server_capabilities.hoverProvider = false
                    end
                end
            }

            require('lspconfig').pyright.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                filetypes = { "python" },
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            ignore = {"*"},
                        },
                    },
                    pylsp = {
                        configurationSources = {"flake8"},
                    }
                },
            }

            require('lspconfig').dockerls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').clangd.setup {
                capabilities = {
                    offsetEncoding = "utf-8",
                },
            }
            require('lspconfig').yamlls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                settings = {
                    yaml = {
                        keyOrdering = false,
                    }
                },
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').bashls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').sqlls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').html.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').tailwindcss.setup({
                filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
                root_pattern = {'tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts'}
            })

            require('lspconfig').cssls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            -- require('lspconfig').gopls.setup {
                -- capabilities = capabilities,
                -- flags = lsp_flags,
                -- cmd = { "gopls", "serve" },
                -- filetypes = { "go", "gomod" },
                -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                -- single_file_support = true,
                -- settings = {
                --     gopls = {
                --         analyses = {
                --             unusedparams = true,
                --             shadow = true,
                --         },
                --         staticcheck = true,
                --         linksInHover = false,
                --         codelenses = {
                --             generate = true,
                --             gc_details = false,
                --             regenerate_cgo = true,
                --             tidy = true,
                --             upgrade_depdendency = true,
                --             vendor = true,
                --         },
                --         usePlaceholders = true,
                --     },
                -- },
                -- on_attach = function(client, bufnr)
                --     navic.attach(client, bufnr)
                -- end
            -- }

            require('lspconfig').jsonls.setup {
                capabilities = capabilities,
                flags = lsp_flags,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').lua_ls.setup {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }

            require('lspconfig').regols.setup {
                capabilities = capabilities,
            }

            require('lspconfig').vimls.setup {
                diagnostic = {
                    enable = true
                },
                capabilities = capabilities,
                indexes = {
                    count = 3,
                    gap = 100,
                    projectRootPatterns = { "runtime", "nvim", "autoload", "plugin" },
                    runtimepath = true
                },
                isNeovim = true,
                iskeyword = "@,48-57,_,192-255,-#",
                runtimepath = "",
                suggest = {
                    fromRuntimepath = true,
                    fromVimruntime = true
                },
                vimruntime = "",
            }

            require("lspconfig").intelephense.setup({
                init_options = {
                    globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
                },
                stubs = {
                    "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
                    "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
                    "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
                    "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
                    "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
                    "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
                    "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                    "wordpress", "phpunit",
                },
                diagnostics = {
                    enable = true,
                },
            })

            require'lspconfig'.stimulus_ls.setup{
                capabilities = capabilities,
            }

            require("typescript").setup({
                server = {
                    capabilities = capabilities,
                    flags = lsp_flags,
                    on_attach = function(client, bufnr)
                        navic.attach(client, bufnr)
                    end
                }
            })

            require("go").setup({
                lsp_on_attach =  function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
                lsp_cfg = {
                capabilities = capabilities,
                flags = lsp_flags,
                cmd = { "gopls", "serve" },
                filetypes = { "go", "gomod" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        linksInHover = false,
                        codelenses = {
                            generate = true,
                            gc_details = false,
                            regenerate_cgo = true,
                            tidy = true,
                            upgrade_depdendency = true,
                            vendor = true,
                        },
                        usePlaceholders = true,
                    },
                },
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
                },
                trouble = true,
                lsp_inlay_hints = {
                    enable = true,
                    only_current_line = true,
                }
            })

        end,
    }
}
