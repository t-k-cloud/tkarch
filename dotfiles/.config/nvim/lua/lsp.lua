-- refer to: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/*

vim.lsp.config('pyright', {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
				-- extraPaths is important for running modules, i.e., `python -m ...`
				extraPaths = { vim.fn.getcwd() },
			},
		},
	},
})

vim.lsp.enable('pyright')

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require('lspconfig')['pyright'].setup {
	capabilities = capabilities
}
