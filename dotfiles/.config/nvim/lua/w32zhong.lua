vim.g.mapleader = ' '
vim.cmd.colorscheme 'desert'
vim.opt.termguicolors = true
vim.opt.incsearch = true

-- vim.o: behaves like :set
-- vim.go: behaves like :setglobal
-- vim.bo: for buffer-scoped options
-- vim.wo: for window-scoped options (can be double indexed)

-- style the cursor (block + blink)
vim.g.matchparen_disable_cursor_hl = 1
vim.api.nvim_set_hl(0, "MatchParen", {reverse=true})
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- disable mouse integration (allowing cursor-select copy etc.)
vim.o.mouse = ""

-- enforce utf-8 file encoding
vim.o.fileencodings = "utf-8"

-- ensure enough UNDO buffer
vim.o.undolevels = 1000000

-- consider both Unix and Dos file formats
vim.opt.fileformats = {"unix", "dos"}

-- toggle search highlight (Upper s)
vim.keymap.set("n", "<Leader><S-s>", function()
	vim.o.hlsearch = not vim.o.hlsearch
	-- print("hlsearch: " .. tostring(vim.o.hlsearch))
end, { noremap = true, silent = true })

-- toggle tab/space view (ta)
vim.opt.listchars = { tab = "> ", trail = "-" }

vim.keymap.set('n', '<Leader>ta', function()
	vim.o.list = not vim.o.list
end, { noremap = true, silent = true })

-- remove trailing spaces (ts)
vim.keymap.set("v", "<Leader>ts", "<Esc>:'<,'>s/\\s\\+$//gc<CR>", { noremap = true, silent = true })

-- line number (nu)
vim.keymap.set('n', '<Leader>nu', function()
	vim.o.number = not vim.o.number
end, { noremap = true, silent = true })

-- spell check (sp)
vim.keymap.set('n', '<Leader>sp', function()
	vim.wo.spell = not vim.wo.spell
end, { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "SpellBad", {
	fg = "Red",         -- foreground color for GUI
	underline = true,   -- optional: mimic cterm=underline
})

-- substitute the word under the cursor (ss)
vim.keymap.set("n", "<Leader>ss", ":%s/<C-r><C-w>/", { noremap = true })

-- column ruler (cl)
vim.keymap.set('n', '<Leader>cl', function()
	local col = vim.wo.colorcolumn
	if col == "" then
		local cursor_col = vim.fn.virtcol(".")
		vim.wo.colorcolumn = tostring(cursor_col)
	else
		vim.wo.colorcolumn = ""
	end
end, { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#ff00ff" })

-- blog upload/publish (up/pu)
vim.keymap.set("n", "<Leader>up", "<Esc>:!tk-blog-upload.sh % &<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>pu", "<Esc>:!tk-blog-upload.sh % publish<CR>", { noremap = true, silent = true })

-- syntax files
vim.filetype.add({
	extension = {
		blog = "tkblog",
	},
})

-- file extensions
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.mojo", "*.🔥" },
	callback = function()
		vim.cmd("setfiletype mojo")
	end,
})
-- print(vim.bo.filetype)

-- C-style indentation modes (ci)
vim.keymap.set('n', '<Leader>ci', function()
	vim.bo.tabstop = 4
	vim.bo.softtabstop = 4
	vim.bo.shiftwidth = 4
	vim.bo.expandtab = false
	vim.bo.autoindent = true
	print("C indent")
end, { noremap = true, silent = true })

-- Python-style indentation modes (pi)
vim.keymap.set('n', '<Leader>pi', function()
	vim.bo.tabstop = 4
	vim.bo.softtabstop = 4
	vim.bo.shiftwidth = 4
	vim.bo.expandtab = true
	vim.bo.autoindent = true
	print("Python indent")
end, { noremap = true, silent = true })

-- WEB-style indentation modes (wi)
vim.keymap.set('n', '<Leader>wi', function()
	vim.bo.tabstop = 2
	vim.bo.softtabstop = 2
	vim.bo.shiftwidth = 2
	vim.bo.expandtab = true
	vim.bo.autoindent = true
	print("WEB indent")
end, { noremap = true, silent = true })

-- shortcut copy/paste to register (y/p)
vim.keymap.set('v', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>p', 'viw"+p', { noremap = true, silent = true })
vim.keymap.set('v', '<Leader>p', '"+p', { noremap = true, silent = true })

-- multi-word highlighting (*/0)
_G.hl_words = {}
vim.api.nvim_set_hl(0, "Search2", { fg = "white", bg = "blue", bold = true })

local function make_OR_pattern(words)
	local escaped = {}
	for _, word in ipairs(_G.hl_words) do
		table.insert(escaped, "\\<" .. vim.fn.escape(word, '\\') .. "\\>")
	end
	return table.concat(escaped, "\\|")
end

vim.keymap.set("n", "<Leader>*", function()
	local word = vim.fn.expand("<cword>")
	local index = vim.fn.index(_G.hl_words, word)
	if index == -1 then
		table.insert(_G.hl_words, word)
	else
		table.remove(_G.hl_words, index + 1)
	end
	pattern = make_OR_pattern(_G.hl_words)
	print("pattern: " .. pattern)
	vim.cmd("match Search2 /" .. pattern .. "/")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>0", function()
	_G.hl_words = {}
	vim.cmd("match Search2 ''")
end, { noremap = true, silent = true })

-- buffer switch
vim.keymap.set('n', '<Leader>l', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader><Leader>', ':e #<CR>', { noremap = true, silent = true }) -- toggle
vim.keymap.set('n', '<Leader>x', ':bp <BAR> bd #<CR>', { noremap = true, silent = true }) -- close
for i = 1, 19 do
	vim.keymap.set('n', '<leader>'..i, ':b'..i..'<CR>', { noremap = true, silent = true })
end
