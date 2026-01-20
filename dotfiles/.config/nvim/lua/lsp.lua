-- refer to: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/*
--
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('pyright', {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
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

vim.lsp.config('clangd', {
	cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
	filetypes = { 'c', 'cpp', 'cuda' },
	capabilities = capabilities
})
