#if true then return {} end
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        enabled = false,
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = false,
                    debounce = 25,
                    keymap = {
                        accept = "<S-Tab>",
                        accept_word = false,
                        accept_line = "<Tab>",
                        next = false,
                        prev = false,
                        dismiss = false,
                    },
                },
            })
        end,
    },
}
