-- Python
-- refer to: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pylsp.lua
vim.lsp.config['python-lsp'] = {
  -- Command and arguments to start the server.
  cmd = { 'pylsp' },
  -- Filetypes to automatically attach to.
  filetypes = { 'python' },
  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains specific files.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { 'pyproject.toml', 'setup.py' , '.git' },
  -- Specific settings to send to the server. The schema for this is
  -- defined by the server.
  settings = {
  }
}
