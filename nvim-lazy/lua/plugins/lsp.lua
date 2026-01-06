return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    settings = {
                        gopls = {
                            ["ui.completion.usePlaceholders"] = true,
                            ["formatting.gofumpt"] = true,
                        },
                        html = {
                            filetypes = {
                                "html",
                                "javascript",
                                "javascriptreact",
                                "javascript.jsx",
                                "typescript",
                                "typescriptreact",
                                "typescript.tsx",
                                "gohtmltmpl",
                            },
                        },
                    },
                },
            },
            -- 🔥 修正後的寫法：使用 LazyVim 的 callback 機制
            setup = {
                gopls = function()
                    -- 監聽 LSP 附加到 Buffer 的事件
                    vim.api.nvim_create_autocmd("LspAttach", {
                        callback = function(args)
                            local client = vim.lsp.get_client_by_id(args.data.client_id)
                            if client and client.name == "gopls" then
                                -- 設定存檔時自動執行 Organize Imports
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = args.buf,
                                    callback = function()
                                        vim.lsp.buf.code_action({
                                            context = { only = { "source.organizeImports" } },
                                            apply = true,
                                        })
                                    end,
                                })
                            end
                        end,
                    })
                end,
            },
        },
    },
}

