-- lua/plugins/ui.lua

return {
  -- 1. 設定 Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "left",
        width = 30,
        
        -- 🔥 新增這裡：按鍵映射 (Mappings)
        mappings = {
          -- l: 打開檔案 或 展開資料夾
          ["l"] = "open",
          
          -- h: 收合資料夾
          ["h"] = "close_node",
          
          -- 如果你習慣用空白鍵打開，可以保留；如果不喜歡，可以用下面這行停用它
          -- ["<space>"] = "none",
        },
      },
      -- 下面是你之前的設定 (保持不動)
      filesystem = {
        hijack_netrw_behavior = "open_default",
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          with_expanders = true, 
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
    },
  }, -- 2. Bufferline 設定 (保持不變)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}