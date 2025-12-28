-- lua/plugins/editor.lua
return {
  -- 1. 針對 Snacks.nvim：取消它的 <leader>e 綁定
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- 這裡可以設定 explorer 相關行為，但最重要的是下面的 keys
      },
      explorer = {
        enabled = false, -- 直接嘗試關閉 explorer 模組 (可選，但改 keys 最保險)
      },
    },
    keys = {
      -- 🔥 關鍵操作：把 <leader>e 設為 false，表示「移除這個快捷鍵」
      { "<leader>e", false },
      -- 如果你發現 <leader>fe 也會觸發，也可以順便移除
      { "<leader>fe", false },
    },
  },

  -- 2. 針對 Neo-tree：再次確認 <leader>e 是屬於它的
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { 
        "<leader>e", 
        "<cmd>Neotree filesystem toggle left<cr>", 
        desc = "NeoTree (Sidebar)" 
      },
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_default", -- 確保打開資料夾時是用 Neo-tree
      },
    },
  },
}