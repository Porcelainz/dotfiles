-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- lua/config/autocmds.lua

-- 5. 智慧行號切換
local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = number_toggle_group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.number = true
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
    group = number_toggle_group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
        vim.opt.number = true
    end,
})
-- lua/config/autocmds.lua

-- (保留你原本的設定...)

-- 🔥 新增這段：開啟新檔案時，自動關閉上一個 [No Name] 空白頁
