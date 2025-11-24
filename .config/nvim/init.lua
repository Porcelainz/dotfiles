-- Porcelain's Final VS Code Neovim Config (v1.1)
-- 1. 基礎設定
vim.g.mapleader = " " 
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 200 

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 2. 通用優化 (Terminal & VSCode)

-- 🧠 智慧型 Q (全域生效)
-- 沒錄製時按 q 無反應；錄製中按 q 停止錄製
keymap('n', 'q', function()
    if vim.fn.reg_recording() ~= '' then
        return 'q'
    end
    return ''
end, { expr = true, noremap = true })

keymap("v", "<", "<gv", opts)   -- 縮排保持選取
keymap("v", ">", ">gv", opts)
keymap("x", "p", '"_dP', opts)  -- 貼上不覆蓋剪貼簿

-- H/L 快速移動到行首行尾
keymap({'n', 'v'}, 'H', '^', opts)
keymap({'n', 'v'}, 'L', '$', opts)

-- 搜尋自動置中 (依個人喜好保留)
keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)

-- 3. 純 Terminal 防呆
if not vim.g.vscode then
    keymap('i', 'qq', '<Esc>', opts)
    keymap('i', 'jk', '<Esc>', opts)
end

-- 4. VS Code 深度整合
if vim.g.vscode then
    local vscode = require('vscode')

    -- --- 核心操作 ---
    -- Normal Mode: 清除搜尋高亮 + Esc
    keymap('n', 'qq', ':nohl<CR><Esc>', opts)
    -- Visual Mode: 單純退出選取 (Esc)
    keymap('x', 'qq', '<Esc>', opts)
    
    -- Yazi Toggle
    keymap('n', 'tt', function() vscode.call('yazi-vscode.toggle') end, opts) 

    -- --- 導航 (Navigation) ---
    keymap('n', '<leader>h', function() vscode.call('workbench.action.navigateBack') end, opts)
    -- 🔜 <Space> + l : 下一頁 (Navigate Forward)
    keymap('n', '<leader>l', function() vscode.call('workbench.action.navigateForward') end, opts)
    -- --- 開發工具 (Coding) ---
    keymap('n', 'K', function() vscode.call('editor.action.showHover') end, opts)
    
    -- 🚀 跳轉三劍客 (Go/C# 必備)
    keymap('n', 'gd', function() vscode.call('editor.action.revealDefinition') end, opts) -- 定義
    keymap('n', 'gi', function() vscode.call('editor.action.goToImplementation') end, opts) -- 實作 (Interface -> Struct)
    keymap('n', 'gr', function() vscode.call('editor.action.goToReferences') end, opts) -- 引用 (誰用了我)
    
    -- 錯誤跳轉
    keymap('n', 'gl', function() vscode.call('editor.action.marker.nextInFiles') end, opts)
    keymap('n', 'gL', function() vscode.call('editor.action.marker.prevInFiles') end, opts)

    keymap('n', '<leader>rn', function() vscode.call('editor.action.rename') end, opts)
    keymap({'n', 'v'}, '<leader>/', function() vscode.call('editor.action.commentLine') end, opts)
    keymap('n', '<leader>w', function() vscode.call('workbench.action.files.save') end, opts)
    keymap('n', '<leader>f', function() vscode.call('workbench.action.findInFiles') end, opts)
    keymap('n', '<leader><leader>', function() vscode.call('workbench.action.quickOpen') end, opts)
    
    -- 左手神器
    keymap({'n', 'v'}, '<leader>a', function() vscode.call('editor.action.quickFix') end, opts) -- Quick Fix
    keymap({'n', 'v'}, '<leader>q', function() vscode.call('workbench.action.closeActiveEditor') end, opts) -- Close Tab

    -- --- 編輯操作 ---
    keymap({'n', 'v'}, '<C-w>', function() vscode.call('workbench.action.closeActiveEditor') end, opts) -- 備用關閉
    keymap({'n', 'v', 'i'}, '<C-a>', function() vscode.call('editor.action.selectAll') end, opts)
    keymap({'n', 'v', 'i'}, '<C-x>', function() vscode.call('editor.action.clipboardCutAction') end, opts)
end
