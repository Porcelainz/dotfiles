-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- lua/config/options.lua

vim.opt.shiftwidth = 4 -- 自動縮排時使用的空格數
vim.opt.tabstop = 4 -- Tab 鍵顯示的寬度 (改成 4 眼睛會舒服很多)
vim.opt.softtabstop = 4 -- 編輯模式下按退格鍵時刪除的空格數
vim.opt.expandtab = false -- 🌟 Go 專案必須為 false，強制使用 Tab
vim.opt.listchars:append({ tab = "  " }) -- 把 tab 顯示設定為空白，或者直接用你要的符號
-- 當失去焦點或離開 Buffer 時自動存檔 + 強制格式化
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            -- 1. 手動觸發 LazyVim 的格式化 (這樣會連帶跑 LSP 格式化)
            require("lazyvim.util").format.format({ force = true })

            -- 2. 存檔
            vim.api.nvim_command("silent! update")
        end
    end,
})
vim.filetype.add({
    extension = {
        tmpl = "gohtmltmpl",
    },
})
-- 強制將 gohtmltmpl 檔案關聯到 gotmpl 語法解析器
vim.treesitter.language.register("gotmpl", "gohtmltmpl")

