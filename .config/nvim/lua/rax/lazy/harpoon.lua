return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end)
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


        vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader><C-a>", function() harpoon:list():replace_at(1) end)
        vim.keymap.set("n", "<leader><C-s>", function() harpoon:list():replace_at(2) end)
        vim.keymap.set("n", "<leader><C-d>", function() harpoon:list():replace_at(3) end)
        vim.keymap.set("n", "<leader><C-f>", function() harpoon:list():replace_at(4) end)
    end
}
