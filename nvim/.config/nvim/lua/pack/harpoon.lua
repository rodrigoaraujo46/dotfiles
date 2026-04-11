vim.pack.add({ { src = 'https://github.com/rodrigoaraujo46/harpoon', version = 'harpoon2' } })

local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Add file to harpoon' })
vim.keymap.set('n', '<leader>A', function() harpoon:list():prepend() end, { desc = 'Prepend file to harpoon' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
	{ desc = 'Toggle harpoon quick menu' })

vim.keymap.set('n', '<A-j>', function() harpoon:list():select(1) end, { desc = 'Go to harpoon file 1' })
vim.keymap.set('n', '<A-k>', function() harpoon:list():select(2) end, { desc = 'Go to harpoon file 2' })
vim.keymap.set('n', '<A-l>', function() harpoon:list():select(3) end, { desc = 'Go to harpoon file 3' })
vim.keymap.set('n', '<A-;>', function() harpoon:list():select(4) end, { desc = 'Go to harpoon file 4' })

vim.keymap.set('n', '<leader><A-j>', function() harpoon:list():replace_at(1) end, { desc = 'Replace harpoon file 1' })
vim.keymap.set('n', '<leader><A-k>', function() harpoon:list():replace_at(2) end, { desc = 'Replace harpoon file 2' })
vim.keymap.set('n', '<leader><A-l>', function() harpoon:list():replace_at(3) end, { desc = 'Replace harpoon file 3' })
vim.keymap.set('n', '<leader><A-;>', function() harpoon:list():replace_at(4) end, { desc = 'Replace harpoon file 4' })
