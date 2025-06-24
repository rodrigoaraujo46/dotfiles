function ColorMyPencils(color)
    vim.cmd.colorscheme(color)
end

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,    -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
            --ColorMyPencils("gruvbox")
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false,    -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
                on_highlights = function(hl)
                    hl.TelescopeNormal = {
                        bg = "none",
                        fg = "none",
                    }
                    hl.TelescopeBorder = {
                        bg = "none",
                        fg = "none",
                    }
                    hl.TelescopePromptNormal = {
                        bg = "none",
                    }
                    hl.TelescopePromptBorder = {
                        bg = "none",
                        fg = "none",
                    }
                    hl.TelescopePromptTitle = {
                        bg = "none",
                        fg = "none",
                    }
                    hl.TelescopePreviewTitle = {
                        bg = "none",
                        fg = "none",
                    }
                    hl.TelescopeResultsTitle = {
                        bg = "none",
                        fg = "none",
                    }
                end
            })
            --ColorMyPencils("tokyonight")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                variant = "moon",
                disable_background = false,
                styles = {
                    italic = false,
                },
            })
            ColorMyPencils("rose-pine")
        end
    },
}
