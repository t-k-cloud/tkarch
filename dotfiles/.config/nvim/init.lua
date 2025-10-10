-- use :source/:so to reload configs

-- my own coinfigs
require('w32zhong')

-- run :PackerSync and then :PackerStatus for new plugin installation
require('plugins')

-- tab and status bar coinfigs
local bufferline = require("bufferline")
bufferline.setup {
	options = {
		mode = "buffers",
		style_preset = bufferline.style_preset.minimal,
		numbers = "buffer_id",
		truncate_names = true,
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = false,
		sort_by = 'insert_after_current'
	}
}
vim.keymap.set('n', '<Leader>l', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>', ':e #<CR>', { noremap = true, silent = true }) -- toggle
vim.keymap.set('n', '<Leader>x', ':bp <BAR> bd #<CR>', { noremap = true, silent = true }) -- close
vim.keymap.set('n', '<leader>0', ':lua require("bufferline").move_to(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>-', ':lua require("bufferline").move_to(-1)<CR>', { noremap = true, silent = true })
for i = 1, 9 do
	-- By buffer ID:
	--vim.keymap.set('n', '<leader>'..i, ':b'..i..'<CR>', { noremap = true, silent = true })

	-- By buffer absolute index:
	vim.keymap.set('n', '<leader>'..i, ':lua require("bufferline").go_to('..i..', true)<CR>', { noremap = true, silent = true })
end
require('hardline').setup {
	theme = 'default',
	bufferline = false, -- leave this function to bufferline...
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

-- file explorer
require("oil").setup()

-- LazyGit configs
vim.keymap.set("n", "<leader>gt", ':LazyGit<CR>')

-- LSP diagnostic configs
vim.diagnostic.config({
	--signs = false, -- don't show signs in the gutter
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN] = '⚠',
		},
		severity = {min = vim.diagnostic.severity.ERROR},
	},
	update_in_insert = false, -- don't update diagnostics in insert
	underline = {
		severity = {min = vim.diagnostic.severity.ERROR},
	}, -- underline problematic code
	virtual_lines = {
		severity = {min = vim.diagnostic.severity.ERROR},
	},
})

-- Enable LSP for Python and other languages
require('lsp')
vim.lsp.enable('pyright')

-- Toggle LSP diagnostic messages
vim.diagnostic.enable(false)
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, desc = "Toggle diagnostics"})

-- Go to next or previous diagnostic message
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev)

-- print enabled LSP configs
--for name in vim.spairs(vim.lsp._enabled_configs) do
--	local config = vim.lsp.config[name]
--	for k, v in vim.spairs(config) do
--		print(name, ':', k, '->', vim.inspect(v))
--	end
--end
--print('Flush')

-- Copilot suggested line color scheme
vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#93a1a1', bg = '#002b36', })

-- CodeCompanion
-- refer to https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
vim.keymap.set("n", "<leader>ai", ':CodeCompanionChat Toggle<CR>', { noremap = true, desc = "AI (toggle)"})
vim.keymap.set("v", "<leader>ai", ':CodeCompanionChat Add<CR>', { noremap = true, desc = "AI (add selected)"})
vim.keymap.set('c',  'AI', 'CodeCompanionChat') -- command-line abbreviation

-- Auto-Completion
local cmp = require'cmp'
local function feedkey(key, mode)
	-- utility to feed <Plug> key
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode or "", false)
end
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = 'Normal:none,FloatBorder:none,CursorLine:PmenuSel'
		}),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<PageUp>'] = cmp.mapping.scroll_docs(-4), -- only for docs not for completion window
		['<PageDown>'] = cmp.mapping.scroll_docs(4), -- only for docs not for completion window
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		['<Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#expandable"]() == 1 then
				vim.fn["vsnip#expand"]()
			elseif vim.fn["vsnip#jumpable"](1) == 1 then
				feedkey("<Plug>(vsnip-jump-next)")
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback() -- insert a literal <Tab>
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback() -- insert a literal <S-Tab>
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users
		{
			name = 'buffer',
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end
			},
		},
	}),
})

-- Snippets keymap
-- (search mode)
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
-- (command mode)
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- allow our customized snippets to be discovered (e.g., tkblog).
vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"

-- print friendly-snippets files
-- print(vim.fn.stdpath("data") .. '/site/pack/packer/start/friendly-snippets/snippets')

-- print LSP capabilities
-- for key in vim.spairs(capabilities) do
-- 	local val = capabilities[key]
-- 	print(key, ':', vim.inspect(val))
-- end
-- print('Flush')

-- Jupyter Notebook
-- Install system-wide `jupytext --version`
require("jupytext").setup({
	jupytext = 'jupytext',
	format = "markdown",
	filetype = require("jupytext").get_filetype,
	new_template = '',
	sync_patterns = { '*.md', '*.py'},
})
