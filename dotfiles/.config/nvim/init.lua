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

vim.keymap.set("n", "<leader>gt", ':LazyGit<CR>')

-- LSP servers
-- use i mode CTRL-X CTRL-O to trigger completion
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

require('lsp')
vim.lsp.enable('python-lsp')

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, desc = "Toggle diagnostics"})

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

-- Copilot (ALT-] or -[ to cycle suggestions, and Ctrl-\ or Alt-\ to accept all or words)
vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#93a1a1', bg = '#002b36', })

-- CodeCompanion
-- refer to https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
vim.keymap.set("n", "<leader>ai", ':CodeCompanionChat Toggle<CR>', { noremap = true, desc = "AI (toggle)"})
vim.keymap.set("v", "<leader>ai", ':CodeCompanionChat Add<CR>', { noremap = true, desc = "AI (add selected)"})
vim.keymap.set('c',  'ai', 'CodeCompanionChat') -- command-line abbreviation

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
		{ name = 'buffer' },
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
