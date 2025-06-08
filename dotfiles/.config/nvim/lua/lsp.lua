-- refer to: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/*
--
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
	capabilities = capabilities
})
