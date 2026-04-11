vim.pack.add({
	{ src = 'https://github.com/saghen/blink.cmp',            version = vim.version.range('1.*') },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' }
})

require('blink.cmp').setup({
	completion = { documentation = { auto_show = true } },
	keymap = { preset = 'default' },
	signature = { enabled = true }
})
