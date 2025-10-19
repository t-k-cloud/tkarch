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
	-- Vim Default: use `x to jump to mark x
	use {
		'chentoast/marks.nvim',
		opt = false,
		config = function()
			require('marks').setup {
				default_mappings = false,
				cyclic = true,
				refresh_interval = 250,
				mappings = {
					-- letter marks (named within a buffer)
					set = false,
					toggle = "mm",
					delete_line = "md",
					delete_buf = "mD",
					next = "mn",
					prev = "mN",
					-- bookmarks (work across buffers)
					set_bookmark0 = "m0",
					next_bookmark0 = "m]",
					prev_bookmark0 = "m[",
					delete_bookmark = "m-",
					delete_bookmark0 = "m_",
				},
				bookmark_0 = {
					sign = "⚑"
				}
			}
		end
	}

	-- tab and status bars --
	use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
	use {'ojroques/nvim-hardline'}

	-- file explorer --
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				use_default_keymaps = false,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["<CR>"] = "actions.select",
				}
			})
		end,
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
						adapter = "gemini",
						keymaps = {
							send = {
								modes = { n = "<C-s>", i = "<C-s>" },
							},
						}
					},
					inline = {
						adapter = "gemini",
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
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-2.5-flash-preview-05-20"
							},
						}
					})
				end,
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
		tag = 'v8.6.0',
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
