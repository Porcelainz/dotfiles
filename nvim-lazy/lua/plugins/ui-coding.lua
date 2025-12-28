-- lua/plugins/ui-coding.lua
return {
  -- 1. 移除 hlchunk
  { "shellRaining/hlchunk.nvim", enabled = false },

  -- ==========================================
  -- 2. mini.indentscope (當前範圍動畫線)
  -- ==========================================
  {
    "nvim-mini/mini.indentscope",
    version = false,
    enabled = true,
    -- 🔥 新增這裡：設定初始載入邏輯，遇到 Terminal 就禁用
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    opts = {
      symbol = "│",
      options = {
        try_as_border = true,
      },
    },
  },

  -- ==========================================
  -- 3. indent-blankline (靜態縮排線)
  -- ==========================================
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    opts = {
      indent = { 
        char = "│", 
        tab_char = "│", -- 🔥 讓 Tab 縮排也顯示成直線，就不會出現 > 了
      },
      -- 2. Scope 設定：這是「當前範圍」的高亮
      -- 如果你不需要當前範圍特別亮，可以維持 enabled = false
      -- 但通常建議開著，VSCode 其實也有這條比較亮的線
      scope = { 
        enabled = true, 
        show_start = false, 
        show_end = false,
        highlight = { "Function", "Label" }, -- 這裡設定當前層級的顏色
      },
      
      -- 🔥 新增這裡：排除清單 (Exclude List)
      -- 告訴它不要在這些視窗畫線
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "terminal", -- 主要是這個
          "lspinfo",
          "checkhealth",
          "TelescopePrompt",
          "TelescopeResults",
        },
      },
    },
  },

  -- 4. 彩虹括號 (保持不變)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }
    end,
  },

  -- 5. 關掉行尾error message
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 這是 LazyVim 官方推薦修改診斷設定的地方
      diagnostics = {
        virtual_text = false, -- 🌟 這裡才是真正關閉行尾訊息的開關
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
    },
  },
}