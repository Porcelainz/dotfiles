return {
    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-a>", -- 這裡改成 Ctrl+a 了
                clear_suggestion = "<C-]>",
                accept_word = "<C-j>",
            },
            -- 如果覺得 Ghost text 顏色太淡，可以在這邊加 color 設定
        })
    end,
}
