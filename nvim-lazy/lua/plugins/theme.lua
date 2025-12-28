return {
  -- 1. 安裝並設定 Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte", -- 回歸 Latte (Light Theme)
      
      -- 你的無斜體鋼鐵意志
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },

      -- 針對 Latte 的舒適化調整
      custom_highlights = function(colors)
        return {
          -- 移除斜體 (你原本的設定)
          ["@namespace"] = { style = {} },
          ["@module"] = { style = {} },
          ["@lsp.type.namespace"] = { style = {} },
          ["@keyword.package"] = { style = {} },

          -- 🌟 散光救星：讓縮排線不要太刺眼但要清晰
          -- 使用稍微深一點的灰色，讓它在白底上穩定不閃爍
          ["IblIndent"] = { fg = colors.surface1 }, 
          ["IblScope"] = { fg = colors.rosewater, style = { "bold" } }, -- 當前範圍加粗一點

          -- 🌟 浮動視窗優化 (看 error message 用的 gl 視窗)
          -- 讓背景稍微深一點點，跟主代碼區隔開，看錯誤訊息更省力
          ["NormalFloat"] = { bg = colors.mantle },
          ["FloatBorder"] = { fg = colors.blue },
          
          -- 🌟 CursorLine (當前行高亮) 
          -- 散光怕找不到游標，把這一行的底色稍微調明顯一點點
          ["CursorLine"] = { bg = colors.surface0 },
        }
      end,
    },
  },

  -- 2. 啟動設定
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}