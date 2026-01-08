return {
  -- 1. 設定 Treesitter 與 檔案關聯
  {
    "nvim-treesitter/nvim-treesitter",
    -- 使用 init 在插件載入前就先設定好映射，這最安全，不會報錯
    init = function()
      -- A. 強制將 .tmpl 識別為 gotmpl 檔案類型
      vim.filetype.add({
        extension = {
          tmpl = "gotmpl", 
        },
      })

      -- B. 關鍵修復：染色引擎置換 (這行是 Neovim 內建功能，不需要 require 插件)
      -- 告訴 Neovim：「遇到 gotmpl 檔案時，請用 HTML 的規則來上色！」
      -- 這樣就解決了灰底問題，同時保留 HTML 標籤顏色
      vim.treesitter.language.register("html", "gotmpl")
    end,
    
    -- 只擴充安裝列表，不覆蓋 config
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gotmpl", "html" })
      end
    end,
  },

  -- 2. 讓 HTML 的 LSP 支援 gotmpl (補全 div, span 等標籤)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "gotmpl" },
        },
        -- 如果你有裝 emmet (HTML 快速縮寫)，這很有用
        emmet_language_server = {
          filetypes = { "html", "gotmpl" },
        },
        -- 如果你有裝 tailwindcss
        tailwindcss = {
          filetypes = { "html", "gotmpl" },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                gotmpl = "html",
              },
            },
          },
        },
      },
    },
  },
}