return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                use_diagnostic_signs = true,
                focus = true,
                mode = "diagnostics"
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle({mode = "diagnostics"})
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").next({mode = "diagnostics", skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").previous({mode = "diagnostics", skip_groups = true, jump = true});
            end)

        end
    },
}
