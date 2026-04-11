vim.pack.add({ { src = 'http://github.com/tpope/vim-fugitive' } })

local fugitive = vim.api.nvim_create_augroup('fugitive', {})
vim.api.nvim_create_autocmd('BufWinEnter', {
	group = fugitive,
	pattern = '*',
	callback = function()
		if vim.bo.ft ~= 'fugitive' then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		vim.keymap.set('n', '<leader>p', function()
			vim.cmd.Git('push')
		end, { buffer = bufnr, remap = false, desc = 'Fugitive push' })

		-- rebase always
		vim.keymap.set('n', '<leader>P', function()
			vim.cmd.Git({ 'pull', '--rebase' })
		end, { buffer = bufnr, remap = false, desc = 'Fugite pull' })

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set('n', '<leader>t', ':Git push -u origin', { buffer = bufnr, remap = false, desc = 'Fugitive push set tracking' });
	end,
})

vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'diffget left ' })
vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'diffget right' })
