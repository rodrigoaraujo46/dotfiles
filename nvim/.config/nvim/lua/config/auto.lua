local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local animus = augroup('animus', {})
local highlight = augroup('highlight', {})

autocmd('TextYankPost', {
	group = highlight,
	pattern = '*',
	callback = function()
		vim.hl.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

autocmd({ 'BufWritePre' }, {
	group = animus,
	pattern = '*',
	command = [[%s/\s\+$//e]],
})
