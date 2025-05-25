-- use :source/:so to reload configs

-- my own coinfigs
require('w32zhong')

-- run :PackerSync and then :PackerStatus for new plugin installation
require('plugins')

require('hardline').setup {
	theme = 'default',
	bufferline = true,
	bufferline_settings = {
		exclude_terminal = false,  -- don't show terminal buffers in bufferline
		show_index = true,        -- show buffer indexes (not the actual buffer numbers)
	},
	sections = { -- define sections, see :help statusline
		{class = 'mode', item = require('hardline.parts.mode').get_item},
		{class = 'med', item = '%f'}, -- show file path
		'%<', -- align
		{class = 'med', item = '%='}, -- padding
		{class = 'warning', item = require('hardline.parts.whitespace').get_item},
		{class = 'high', item = require('hardline.parts.filetype').get_item},
		{class = 'mode', item = '%l,%v --%p%%--'},
	},
}

require("neo-tree").setup({
	filesystem = {
		name = {
			trailing_slash = true,
			highlight = "NeoTreeFileName",
		},
		hijack_netrw_behavior = "open_current",
	},
})

-- LSP servers
require('lsp')

vim.lsp.enable('python-lsp')

-- print enabled LSP configs
for name in vim.spairs(vim.lsp._enabled_configs) do
	local config = vim.lsp.config[name]
	for k, v in vim.spairs(config) do
		print(name, ':', k, '->', vim.inspect(v))
	end
end
print('Flush')
