require('w32zhong')
require('plugins')
-- run :PackerSync and then :PackerStatus for new plugin installation

require('hardline').setup {
	theme = 'default',
	bufferline = true,
	bufferline_settings = {
		exclude_terminal = false,  -- don't show terminal buffers in bufferline
		show_index = true,        -- show buffer indexes (not the actual buffer numbers)
	},
	sections = {         -- define sections
		{class = 'mode', item = require('hardline.parts.mode').get_item},
		{class = 'med', item = require('hardline.parts.cwd').get_item},
		{class = 'med', item = '%='}, -- padding
		{class = 'warning', item = require('hardline.parts.whitespace').get_item},
		{class = 'mode', item = require('hardline.parts.line').get_item},
	},
}
