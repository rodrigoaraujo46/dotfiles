vim.pack.add({ { src = 'http://github.com/mfussenegger/nvim-lint' } })

local lint = require('lint')
lint.linters_by_ft = {
	go = { 'golangcilint' },
	sh = { 'shellcheck' },
	gitcommit = { 'gitlint' },
}

local lintG = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'InsertLeave', 'BufWritePost' }, {
	group = lintG,
	callback = function()
		lint.try_lint()
	end,
})
