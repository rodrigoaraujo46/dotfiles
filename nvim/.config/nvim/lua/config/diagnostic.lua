local severity = vim.diagnostic.severity

local signs = {
	[severity.ERROR] = ' ',
	[severity.WARN]  = ' ',
	[severity.INFO]  = ' ',
	[severity.HINT]  = ' '
}

local highlights = {
	[severity.ERROR] = 'DiagnosticError',
	[severity.WARN]  = 'DiagnosticWarn',
	[severity.INFO]  = 'DiagnosticInfo',
	[severity.HINT]  = 'DiagnosticHint'
}

vim.diagnostic.config({
	virtual_text = {
		prefix = function(d)
			return signs[d.severity]
		end,
	},
	signs = {
		text = signs,
		numhl = highlights
	},
	float = {
		header = '',
		scope = 'line',
		severity_sort = true,
		prefix = function(d)
			return signs[d.severity], highlights[d.severity]
		end,
		format = function(d)
			if d.code == nil then
				return d.message .. ' '
			end
			return d.message .. ' [' .. d.code .. '] '
		end,
		suffix = function(d)
			return d.source, 'Comment'
		end
	},
	severity_sort = true
})
