-- lua/plugins/coding.lua

return {
  -- 1. 確保 nvim-cmp 是被停用的 (如果有的話)
  { "hrsh7th/nvim-cmp", enabled = false },

  -- 2. 設定新的霸主 blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- 'default' 預設是 Enter 確認，我們要把它改掉
        preset = "none", -- 設為 none，讓我們完全自定義按鍵，避免衝突

        -- 🔥 Tab: 確認選取 (Accept) / 跳下一個 snippet / 縮排
        ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
        
        -- Shift+Tab: 往回跳 snippet
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        -- 🔥 Enter: 什麼都不做，直接換行 (fallback)
        ['<CR>'] = { 'fallback' },
        -- 🔥 新增這裡：讓 Ctrl+j / Ctrl+k 也能上下移動
        ['<C-k>'] = { 'select_prev', 'fallback' }, -- 往上 (原本是 Ctrl-p)
        ['<C-j>'] = { 'select_next', 'fallback' }, -- 往下 (原本是 Ctrl-n)
        -- 上下鍵與 Ctrl-p/n: 選擇候選字
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        -- 捲動說明文件
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        
        -- 呼叫補全選單 (手動觸發)
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },
    },
  },
}