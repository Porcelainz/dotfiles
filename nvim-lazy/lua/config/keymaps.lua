-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- lua/config/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==========================================
-- 3. 通用優化 (保留你原本的習慣)
-- ==========================================

-- Zen Mode Esc: 清除高亮
keymap("n", "<Esc>", function()
    vim.cmd("nohl")
    return "<Esc>"
end, { expr = true, silent = true })

-- 智慧 Q (防止誤觸錄製)
keymap("n", "q", function()
    return vim.fn.reg_recording() ~= "" and "q" or ""
end, { expr = true })

-- Visual Mode 縮排保持選取
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 貼上不複製被覆蓋的文字
keymap("x", "p", '"_dP', opts)

-- H/L 快速移動
keymap({ "n", "v" }, "H", "^", opts)
keymap({ "n", "v" }, "L", "$", opts)

-- 搜尋與捲動置中
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- 🔥 黑洞刪除 (你的習慣：d 不會污染剪貼簿)
keymap({ "n", "v" }, "d", '"_d', opts)
keymap("n", "dd", '"_dd', opts)
keymap("n", "D", '"_D', opts)
keymap({ "n", "v" }, "x", '"_x', opts)

-- ==========================================
-- 4. 取代原本 VS Code 的功能 (轉移到 LazyVim/Neovim 原生)
-- ==========================================

-- --- 檔案與視窗管理 ---

-- <Space>e: 開啟/聚焦 檔案總管 (LazyVim 預設是用 NeoTree)
-- LazyVim 原本是 <leader>e，這行其實可以不寫，但為了確保邏輯一致還是寫上
-- <Space>w: 存檔 (原本是 VSCode save)
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- <Space>q: 關閉分頁/Buffer (原本是 VSCode closeActiveEditor)
-- LazyVim 預設 <leader>q 是 Quit (離開 Vim)，<leader>bd 才是關閉 Buffer
-- 這裡依你的習慣改成 <leader>q 關閉 Buffer
-- 註：如果你有用 snacks.nvim 或 mini.bufremove，建議改成 <cmd>bd<cr> 的對應指令，但 <cmd>bd<cr> 最通用

-- <Space>o: 下方插入空行 (不進入 Insert Mode)
keymap("n", "<leader>o", "o<Esc>", { desc = "Insert Empty Line Below" })

-- --- 導航與搜尋 (使用 LazyVim 的 Picker) ---

-- <Space>f: 全域搜尋 (原本是 VSCode findInFiles)
-- LazyVim 預設通常是 <leader>/ 或 <leader>sg
-- 這裡我們呼叫 LazyVim 的 helper 來啟動搜尋 (會自動判斷是用 Telescope 還是 Fzf-lua)
keymap("n", "<leader>f", function()
    LazyVim.pick("live_grep")()
end, { desc = "Find in Files (Grep)" })

-- <Space><Space>: 快速開檔 (原本是 VSCode quickOpen)
-- LazyVim 預設就是這個鍵位，這裡保留註解或明確定義皆可
--keymap('n', '<leader><leader>', function() LazyVim.pick("files")() end, { desc = "Find Files (Root)" })

-- --- 歷史導航 (跳轉) ---

-- <Space>a / <Space>d (原本是 VSCode navigateBack/Forward)
-- Neovim 原生對應的是 Ctrl-o (Back) 和 Ctrl-i (Forward)
keymap("n", "<leader>a", "<C-o>", { desc = "Go Back" })
keymap("n", "<leader>d", "<C-i>", { desc = "Go Forward" })

-- --- LSP 智慧跳轉 ---
-- LazyVim 預設已經有 gd, gr, gi，這裡不需要額外設定，除非你要覆蓋預設行為
-- 但 <leader>rn (重新命名) 預設是 <leader>cr，我們可以改回你的習慣
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- --- 錯誤診斷 ---
-- 原本是 gl/gL 跳下一個/上一個錯誤
-- LazyVim 預設是 ]d 和 [d
keymap("n", "gl", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
keymap("n", "gL", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- --- 剪貼簿與操作 (Windows/Linux 通用習慣) ---

-- 複製貼上 (Ctrl+C / Ctrl+V) - 依賴 vim.opt.clipboard = "unnamedplus"
-- Visual Mode 複製
keymap("v", "<C-c>", "y", { desc = "Copy" })

-- Insert Mode 貼上 (從系統剪貼簿)
-- <C-r>+ 是 Neovim 原生從暫存器貼上的方式
keymap("i", "<C-v>", "<C-r>+", { desc = "Paste" })

-- Visual Mode 補回 Block Select (因為你可能把 <C-v> 覆蓋掉了)
keymap("n", "<leader>v", "<C-v>", { desc = "Visual Block Mode" })

-- ==========================================
-- 🔥 視窗快速切換 (Window Navigation)
-- ==========================================
-- 不用再按 Ctrl+w 了，直接用 Ctrl + 方向鍵
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- 設定 Diagnostic 的顯示方式
vim.diagnostic.config({
    virtual_text = false, -- 🌟 關閉行尾那個會被切掉的文字
    signs = true, -- 保持左側邊欄的紅點/圖示
    underline = true, -- 保持波浪線
    update_in_insert = false,
    severity_sort = true,
    float = {
        focused = false,
        style = "minimal",
        border = "rounded", -- 讓浮動視窗有圓角，比較好看
        source = "always",
        header = "",
        prefix = "",
    },
})

-- 讓游標停在那行時，自動跳出錯誤訊息 (選配)
-- 如果你不想手動按 gl，可以加這段
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- 先刪除 LazyVim 預設的綁定，避免衝突
vim.keymap.del("n", "<C-/>")
vim.keymap.del("n", "<leader>ft") -- 如果你也想改掉 leader ft

-- 重新綁定，強制給予一個固定 id (例如 "single_terminal")
vim.keymap.set("n", "<C-/>", function()
    Snacks.terminal.toggle(nil, { id = "single_term" })
end, { desc = "Terminal (Single Instance)" })

-- 處理某些終端機下 Ctrl+/ 會變成 Ctrl+_ 的問題
vim.keymap.set("n", "<C-_>", function()
    Snacks.terminal.toggle(nil, { id = "single_term" })
end, { desc = "Terminal (Single Instance)" })

