-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'tomasky/bookmarks.nvim',
		-- after = "telescope.nvim",
		event = "VimEnter",
		opt = false,
		config = function()
			print('setup bookmarks...')
			require('bookmarks').setup {
				save_file = vim.fn.expand "$HOME/.cache/nvim/bookmarks.txt",
				keywords =  {
					["@t"] = "☑️ ",
					["@w"] = "⚠️ ",
					["@f"] = "⛏ ",
				},
				on_attach = function(bufnr)
					local bm = require "bookmarks"
					local map = vim.keymap.set
					map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
					map("n","mj",bm.bookmark_ann) -- add or edit mark annotation at current line
					map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
					map("n","mN",bm.bookmark_prev) -- jump to previous mark in local buffer
					map("n","md",bm.bookmark_clean) -- clean all marks in local buffer
					map("n","mD",bm.bookmark_clear_all) -- removes all bookmarks
					map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
				end
			}
		end
	}

	use {'ojroques/nvim-hardline'}

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window.
		}
	})

end)
