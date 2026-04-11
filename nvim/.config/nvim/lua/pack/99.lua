vim.pack.add({ { src = 'https://github.com/ThePrimeagen/99' } })

_99 = require('99')

_99.setup({
	model = 'opencode/big-pickle',
	md_files = {
		'AGENT.md',
	},
})

vim.keymap.set('v', '<leader>9v', function()
	_99.visual()
end, { desc = '99 Visual Fill' })

vim.keymap.set('n', '<leader>9gg', function()
	_99.vibe()
end, { desc = '99 Vibe Code' })

vim.keymap.set('n', '<leader>9s', function()
	_99.search()
end, { desc = '99 Search' })

vim.keymap.set('n', '<leader>9x', function()
	_99.stop_all_requests()
end, { desc = '99 Stop all requests' })
