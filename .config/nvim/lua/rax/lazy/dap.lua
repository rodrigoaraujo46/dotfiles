return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup({})
            vim.api.nvim_create_user_command("DapUiToggle", function()
                require("dapui").toggle()
            end, {})
            vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", {})
            vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", {})
            vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", {})
        end
    },
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup({})
        end
    }
}
