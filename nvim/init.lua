-- ==========================================
-- 0. Lazy.nvim 自動安裝與啟動 (Bootstrap)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 1. 基礎設定 (Basic Settings)
-- ==========================================
vim.g.mapleader = " " -- Leader Key 是空白鍵
vim.opt.clipboard = "unnamedplus" -- 系統剪貼簿同步
vim.opt.ignorecase = true -- 搜尋忽略大小寫
vim.opt.smartcase = true -- 搜尋智慧大小寫
vim.opt.scrolloff = 8 -- 保持游標上下有 8 行距離

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==========================================
-- 2. 插件管理 (Plugins)
-- ==========================================
require("lazy").setup({
    -- 🔥 必裝：nvim-surround (修改括號/引號神器)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end
    },
    -- ⚡ 必裝：flash.nvim (快速跳轉)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            -- 1. 背景修復：全域關閉變暗效果
            highlight = { backdrop = false },
            -- 2. 限制 f/t 為單行模式
            modes = {
                char = {
                    enabled = true,
                    multi_line = false, -- false = f 只能找當前行 (符合 Vim 直覺)
                },
            },
        },
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    }
})

-- ==========================================
-- 3. 通用優化 (General Keymaps - VSCode & Neovim 通用)
-- ==========================================
-- ✨ Zen Mode Esc: 清除高亮 + 原生 Esc 功能
keymap('n', '<Esc>', function()
    vim.cmd('nohl')
    return "<Esc>"
end, { expr = true, silent = true })

-- 智慧 Q (防止誤觸錄製)
keymap('n', 'q', function() return vim.fn.reg_recording() ~= '' and 'q' or '' end, { expr = true })

-- Visual Mode 縮排後保持選取
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 貼上不複製被覆蓋的文字
keymap("x", "p", '"_dP', opts)

-- H/L 快速移動至行首/行尾
keymap({'n', 'v'}, 'H', '^', opts)
keymap({'n', 'v'}, 'L', '$', opts)

-- 搜尋與捲動置中 (Keep centered)
keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- 黑洞刪除 (不汙染剪貼簿)
keymap({'n', 'v'}, 'd', '"_d', opts)
keymap('n', 'dd', '"_dd', opts)
keymap('n', 'D', '"_D', opts)
keymap({'n', 'v'}, 'x', '"_x', opts)

-- ==========================================
-- 4. VS Code 深度整合
-- ==========================================
if vim.g.vscode then
    local vscode = require('vscode')

    -- --- 檔案與視窗管理 ---
    -- <Space>e: 開啟/聚焦 檔案總管
    keymap('n', '<leader>e', function() vscode.call('workbench.view.explorer') end, opts)
    -- <Space>w: 存檔
    keymap('n', '<leader>w', function() vscode.call('workbench.action.files.save') end, opts)
    -- <Space>q: 關閉分頁
    keymap('n', '<leader>q', function() vscode.call('workbench.action.closeActiveEditor') end, opts)
    -- <Space>o: 下方插入空行
    keymap('n', '<leader>o', function() vim.fn.append(vim.fn.line('.'), '') end, opts)

    -- --- 導航與搜尋 ---
    -- <Space>f: 全域搜尋
    keymap('n', '<leader>f', function() vscode.call('workbench.action.findInFiles') end, opts)
    -- <Space><Space>: 快速開檔 (Ctrl+P)
    keymap('n', '<leader><leader>', function() vscode.call('workbench.action.quickOpen') end, opts)
    
    -- 🔙 歷史導航
    keymap('n', '<leader>a', function() vscode.call('workbench.action.navigateBack') end, opts)
    keymap('n', '<leader>d', function() vscode.call('workbench.action.navigateForward') end, opts)

    -- 🧠 LSP 智慧跳轉
    keymap('n', 'gd', function() vscode.call('editor.action.revealDefinition') end, opts)
    keymap('n', 'gr', function() vscode.call('editor.action.goToReferences') end, opts)
    keymap('n', 'gi', function() vscode.call('editor.action.goToImplementation') end, opts)
    -- 🔍 搜尋與動作
    keymap('n', 'ga', function() vscode.call('editor.action.quickFix') end, opts)      -- Quick Action / Fix
    keymap('n', 'gs', function() vscode.call('workbench.action.gotoSymbol') end, opts) -- 找當前檔案 Symbol (@)
    keymap('n', 'gS', function() vscode.call('workbench.action.showAllSymbols') end, opts) -- 找全域 Symbol (#)
    keymap('n', 'gn', function() vscode.call('editor.action.rename') end, opts)        -- Rename (原本是 <leader>rn)
    keymap('n', 'gw', function() vscode.call('editor.action.showHover') end, opts)    -- Hover (What/Wiki，取代難按的 gh)
    -- 直接在小視窗看定義/文件，不用跳走
    keymap('n', 'gp', function() vscode.call('editor.action.peekDefinition') end, opts)
    -- 🐛 錯誤診斷
    keymap('n', 'gl', function() vscode.call('editor.action.marker.nextInFiles') end, opts)
    keymap('n', 'gL', function() vscode.call('editor.action.marker.prevInFiles') end, opts)
    -- 模擬 LazyVim 的 leader + s + w (搜尋游標下的字)
    keymap('n', '<leader>sw', function()
        vscode.call('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } })
    end, opts)
    -- --- 剪貼簿修復 (Visual Mode Ctrl+C/V/X 轉發) ---
    keymap({'n', 'v', 'i'}, '<C-a>', function() vscode.call('editor.action.selectAll') end, opts)
    keymap({'n', 'v', 'i'}, '<C-x>', function() vscode.call('editor.action.clipboardCutAction') end, opts)
    keymap({'n', 'v', 'i'}, '<C-c>', function() vscode.call('editor.action.clipboardCopyAction') end, opts)
    keymap({'n', 'v', 'i'}, '<C-v>', function() vscode.call('editor.action.clipboardPasteAction') end, opts)
    -- 補回 Visual Block 模式
    keymap('n', '<leader>v', '<C-v>', opts)
end

-- ==========================================
-- 5. 智慧行號切換 (Smart Relative Line Numbers)
-- ==========================================
-- 原理：vscode-neovim 會監聽 Neovim 的 'relativenumber' 設定並同步到 VS Code UI
local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- 進入 Insert Mode -> 絕對行號 (Absolute)
vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = number_toggle_group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.number = true
    end,
})

-- 離開 Insert Mode (回到 Normal/Visual) -> 相對行號 (Relative)
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
    group = number_toggle_group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
        vim.opt.number = true
    end,
})