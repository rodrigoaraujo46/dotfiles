vim.pack.add({ { src = 'https://github.com/folke/trouble.nvim' } })

local trouble = require('trouble')
trouble.setup({ auto_close = true })

vim.keymap.set('n', '<leader>td', function()
	trouble.toggle({ mode = 'diagnostics' })
end, { desc = 'Toggle Trouble(diagnostics) ' })

vim.keymap.set('n', '<leader>tt', function()
	trouble.toggle({ mode = 'todo' })
end, { desc = 'Toggle Trouble(todo)' })

vim.keymap.set('n', ']t', function()
	trouble.next({ skip_groups = true, jump = true });
end, { desc = 'Next Trouble item' })

vim.keymap.set('n', '[t', function()
	trouble.prev({ skip_groups = true, jump = true });
end, { desc = 'Previous Trouble item' })
