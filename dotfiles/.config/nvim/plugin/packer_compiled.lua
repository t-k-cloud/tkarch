-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/tk/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?.lua;/home/tk/.cache/nvim/packer_hererocks/2.1.1741730670/share/lua/5.1/?/init.lua;/home/tk/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?.lua;/home/tk/.cache/nvim/packer_hererocks/2.1.1741730670/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/tk/.cache/nvim/packer_hererocks/2.1.1741730670/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["bookmarks.nvim"] = {
    config = { "\27LJ\2\n–\2\0\1\b\0\20\0*6\1\0\0'\3\1\0B\1\2\0026\2\2\0009\2\3\0029\2\4\2\18\3\2\0'\5\5\0'\6\6\0009\a\a\1B\3\4\1\18\3\2\0'\5\5\0'\6\b\0009\a\t\1B\3\4\1\18\3\2\0'\5\5\0'\6\n\0009\a\v\1B\3\4\1\18\3\2\0'\5\5\0'\6\f\0009\a\r\1B\3\4\1\18\3\2\0'\5\5\0'\6\14\0009\a\15\1B\3\4\1\18\3\2\0'\5\5\0'\6\16\0009\a\17\1B\3\4\1\18\3\2\0'\5\5\0'\6\18\0009\a\19\1B\3\4\1K\0\1\0\18bookmark_list\aml\23bookmark_clear_all\amD\19bookmark_clean\amd\18bookmark_prev\amN\18bookmark_next\amn\17bookmark_ann\amj\20bookmark_toggle\amm\6n\bset\vkeymap\bvim\14bookmarks\frequireÛ\1\1\0\6\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0006\3\3\0009\3\4\0039\3\5\3'\5\6\0B\3\2\2=\3\b\0025\3\t\0=\3\n\0023\3\v\0=\3\f\2B\0\2\1K\0\1\0\14on_attach\0\rkeywords\1\0\3\a@w\f‚ö†Ô∏è \a@f\t‚õè \a@t\f‚òëÔ∏è \14save_file\1\0\3\14on_attach\0\14save_file\0\rkeywords\0$$HOME/.cache/nvim/bookmarks.txt\vexpand\afn\bvim\nsetup\14bookmarks\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/tk/.local/share/nvim/site/pack/packer/opt/bookmarks.nvim",
    url = "https://github.com/tomasky/bookmarks.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["codecompanion.nvim"] = {
    config = { "\27LJ\2\nÙ\3\0\0\b\0\23\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\21\0005\3\n\0005\4\3\0005\5\a\0005\6\5\0005\a\4\0=\a\6\6=\6\b\5=\5\t\4=\4\v\0035\4\f\0005\5\15\0005\6\14\0005\a\r\0=\a\6\6=\6\16\0055\6\18\0005\a\17\0=\a\6\6=\6\19\5=\5\t\4=\4\20\3=\3\22\2B\0\2\1K\0\1\0\15strategies\1\0\1\15strategies\0\vinline\18reject_change\1\0\2\16description Reject the suggested change\nmodes\0\1\0\1\6n\agr\18accept_change\1\0\2\18reject_change\0\18accept_change\0\1\0\2\16description Accept the suggested change\nmodes\0\1\0\1\6n\aga\1\0\2\fadapter\14anthropic\fkeymaps\0\tchat\1\0\2\vinline\0\tchat\0\fkeymaps\tsend\1\0\1\tsend\0\nmodes\1\0\1\nmodes\0\1\0\2\6n\n<C-s>\6i\n<C-s>\1\0\2\fadapter\14anthropic\fkeymaps\0\nsetup\18codecompanion\frequire\0" },
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/codecompanion.nvim",
    url = "https://github.com/olimorris/codecompanion.nvim"
  },
  ["copilot.lua"] = {
    config = { "\27LJ\2\n®\2\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\15suggestion\vkeymap\1\0\5\tnext\n<M-]>\16accept_word\n<M-\\>\vaccept\n<C-\\>\tprev\n<M-[>\16accept_line\1\1\0\6\vkeymap\0\22trigger_on_accept\2\rdebounce\3K\27hide_during_completion\2\17auto_trigger\1\fenabled\2\npanel\1\0\2\npanel\0\15suggestion\0\1\0\1\fenabled\1\nsetup\fcopilot\frequire\0" },
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["image.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/image.nvim",
    url = "https://github.com/3rd/image.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["mini.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/tk/.local/share/nvim/site/pack/packer/opt/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["neo-tree.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-hardline"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nvim-hardline",
    url = "https://github.com/ojroques/nvim-hardline"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["render-markdown.nvim"] = {
    config = { "\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15file_types\1\0\1\15file_types\0\1\3\0\0\rmarkdown\18codecompanion\nsetup\20render-markdown\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/tk/.local/share/nvim/site/pack/packer/opt/render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/tk/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: codecompanion.nvim
time([[Config for codecompanion.nvim]], true)
try_loadstring("\27LJ\2\nÙ\3\0\0\b\0\23\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\21\0005\3\n\0005\4\3\0005\5\a\0005\6\5\0005\a\4\0=\a\6\6=\6\b\5=\5\t\4=\4\v\0035\4\f\0005\5\15\0005\6\14\0005\a\r\0=\a\6\6=\6\16\0055\6\18\0005\a\17\0=\a\6\6=\6\19\5=\5\t\4=\4\20\3=\3\22\2B\0\2\1K\0\1\0\15strategies\1\0\1\15strategies\0\vinline\18reject_change\1\0\2\16description Reject the suggested change\nmodes\0\1\0\1\6n\agr\18accept_change\1\0\2\18reject_change\0\18accept_change\0\1\0\2\16description Accept the suggested change\nmodes\0\1\0\1\6n\aga\1\0\2\fadapter\14anthropic\fkeymaps\0\tchat\1\0\2\vinline\0\tchat\0\fkeymaps\tsend\1\0\1\tsend\0\nmodes\1\0\1\nmodes\0\1\0\2\6n\n<C-s>\6i\n<C-s>\1\0\2\fadapter\14anthropic\fkeymaps\0\nsetup\18codecompanion\frequire\0", "config", "codecompanion.nvim")
time([[Config for codecompanion.nvim]], false)
-- Config for: copilot.lua
time([[Config for copilot.lua]], true)
try_loadstring("\27LJ\2\n®\2\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\15suggestion\vkeymap\1\0\5\tnext\n<M-]>\16accept_word\n<M-\\>\vaccept\n<C-\\>\tprev\n<M-[>\16accept_line\1\1\0\6\vkeymap\0\22trigger_on_accept\2\rdebounce\3K\27hide_during_completion\2\17auto_trigger\1\fenabled\2\npanel\1\0\2\npanel\0\15suggestion\0\1\0\1\fenabled\1\nsetup\fcopilot\frequire\0", "config", "copilot.lua")
time([[Config for copilot.lua]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd render-markdown.nvim ]]

-- Config for: render-markdown.nvim
try_loadstring("\27LJ\2\n~\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15file_types\1\0\1\15file_types\0\1\3\0\0\rmarkdown\18codecompanion\nsetup\20render-markdown\frequire\0", "config", "render-markdown.nvim")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'bookmarks.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
