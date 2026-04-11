vim.pack.add({
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim', version = vim.version.range('0.2.*') }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Fuzzy files' })

vim.keymap.set('n', '<leader>ph', function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = 'Fuzzy hidden files' })

vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy git files' })

vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand('<cword>')
	builtin.grep_string({ search = word })
end, { desc = 'Grep current word' })

vim.keymap.set('n', '<leader>pWs', function()
	local word = vim.fn.expand('<cWORD>')
	builtin.grep_string({ search = word })
end, { desc = 'Grep current WORD' })

vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'Telescope help' })
