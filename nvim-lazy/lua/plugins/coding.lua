-- lua/plugins/coding.lua

return {
  -- 1. 確保 nvim-cmp 是被停用的 (如果有的話)
  { "hrsh7th/nvim-cmp", enabled = false },

  -- 2. 設定 blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "none",

        -- 🔥 重點 1：Enter (CR) 只做換行，完全不碰選字
        ['<CR>'] = { 'fallback' },

        -- 🔥 重點 2：Tab 負責「確認選字」
        -- 邏輯順序：
        -- 1. 如果有選單 (menu)，按 Tab = 確認選字 (select_and_accept)
        -- 2. 如果沒選單但在 snippet 裡，按 Tab = 跳下一個 (snippet_forward)
        -- 3. 都沒有，按 Tab = 縮排 (fallback)
        ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
        
        -- Shift+Tab 往回跳 snippet
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        -- 導航鍵保持原樣 (Ctrl+k/j 或 上下)
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },
      -- 💡 額外建議：既然要用 Enter 確認，建議開啟這個設定
      -- 這樣當你打字時，LSP 會自動幫你選中第一個最準確的項目
      completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      },
    },
  },
}