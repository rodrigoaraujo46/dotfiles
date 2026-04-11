vim.pack.add({ { src = 'https://github.com/folke/zen-mode.nvim' } })
local zen = require('zen-mode')

zen.setup({
	plugins = {
		options = { laststatus = 0 },
		tmux = { enabled = true },
	}
})

vim.keymap.set('n', '<leader>zz', function()
	local count = vim.v.count
	if count < 80 then
		count = 1
	end
	zen.toggle({ window = { width = count } })
end, { desc = 'toggle zen-mode' })
