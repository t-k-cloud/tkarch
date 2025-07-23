-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- uncomment if we want to force a bootstrap
	-- packer_bootstrap = true

	-- colorscheme --
	use "rebelot/kanagawa.nvim"

	-- bookmarks --
	use {
		'tomasky/bookmarks.nvim',
		-- after = "telescope.nvim",
		event = "VimEnter",
		opt = false,
		config = function()
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

	-- status and tab bars --
	use {'ojroques/nvim-hardline'}

	-- file explorer --
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

	-- git explorer --
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- AI completion --

	-- Run `:Copilot auth` to sign in.
	-- Run `:Copilot! attach` to forcefully attach to current filetype.
	use {
		"zbirenbaum/copilot.lua",
		--cmd = "Copilot",
		--event = "InsertEnter",
		opt = false,
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept_word = "<M-\\>",
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						accept = "<C-\\>",
					},
				},
				filetypes = {
					["*"] = true
				},
				should_attach = function(_, bufname)
					return true
				end
			})
		end,
	}

	-- AI agent --

	-- Run :CodeCompanionChat to open a chat buffer.
	-- Type your prompt and send it by pressing Ctrl-s.
	-- The #buffer variable shares the full contents from the buffer that the user was last in
	-- when they initiated :CodeCompanionChat. To select another buffer, use the /buffer command.
	use {
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "anthropic",
						keymaps = {
							send = {
								modes = { n = "<C-s>", i = "<C-s>" },
							},
						}
					},
					inline = {
						adapter = "anthropic",
						keymaps = {
							accept_change = {
								modes = { n = "ga" },
								description = "Accept the suggested change",
							},
							reject_change = {
								modes = { n = "gr" },
								description = "Reject the suggested change",
							},
						},
					},
				},
			})
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		}
	}

	-- Markdown rendering --
	use({
		'MeanderingProgrammer/render-markdown.nvim',
		after = { 'nvim-treesitter' },
		requires = { 'echasnovski/mini.nvim', opt = true },
		config = function()
			require('render-markdown').setup({
				file_types = { 'markdown', "codecompanion" },
				code = { style = 'language' },
			})
		end,
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					"c",
					"cpp",
					"python",
					"lua",
					"javascript",
					"bash",
					"rust",
					"markdown",
					"markdown_inline"
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			}
		end
	}

	-- Snippets --
	use {'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-nvim-lsp'}

	use {'hrsh7th/cmp-buffer'}
	use {'hrsh7th/cmp-path'}
	use {'hrsh7th/cmp-cmdline'}

	use {'hrsh7th/cmp-vsnip'}
	use {'hrsh7th/vim-vsnip'}
	use {'hrsh7th/vim-vsnip-integ'}
	use {"rafamadriz/friendly-snippets"}

	-- LSP config --
	use {"neovim/nvim-lspconfig"}

	-- bootstrap for the 1st time and install everything...
	if packer_bootstrap then
		require('packer').sync()
		print('packer bootstrap done!')
	end
end)
