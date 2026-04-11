vim.pack.add({ { src = 'https://github.com/zbirenbaum/copilot.lua' } })


require('copilot').setup({
	suggestion = { auto_trigger = true }
})

local suggestion = require('copilot.suggestion')
vim.keymap.set('i', '<Tab>', function()
	if suggestion.is_visible() then
		suggestion.accept_line()
	else
		return '<Tab>'
	end
end, { expr = true, silent = true, desc = 'Copilot accept line' })

vim.keymap.set('i', '<S-Tab>', function()
	if suggestion.is_visible() then
		suggestion.accept()
	else
		return '<S-Tab>'
	end
end, { expr = true, silent = true, desc = 'Copilot accept all' })
