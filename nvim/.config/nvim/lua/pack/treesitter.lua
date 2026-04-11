vim.pack.add({
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }
})

local async = require('nvim-treesitter.async')
local ts = require('nvim-treesitter')
local install = require('nvim-treesitter.install')

vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if vim.list_contains(ts.get_available(), lang) then
			async.async(function()
				async.await(install.install, lang)
				vim.treesitter.start(args.buf, lang)
			end)()
		end
	end,
	desc = 'install parsers and start treesitter',
})

local textobjects = require 'nvim-treesitter-textobjects.select'

vim.keymap.set({ 'x', 'o' }, 'af', function()
	textobjects.select_textobject('@function.outer', 'textobjects')
end, { desc = 'Around function textobject' })

vim.keymap.set({ 'x', 'o' }, 'if', function()
	textobjects.select_textobject('@function.inner', 'textobjects')
end, { desc = 'Inside function textobject' })

vim.keymap.set({ 'x', 'o' }, 'ac', function()
	textobjects.select_textobject('@class.outer', 'textobjects')
end, { desc = 'Around class textobject' })

vim.keymap.set({ 'x', 'o' }, 'ic', function()
	textobjects.select_textobject('@class.inner', 'textobjects')
end, { desc = 'Inside class textoject' })
