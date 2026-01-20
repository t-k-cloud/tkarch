## Clean Installation
```sh
# https://wiki.archlinux.org/title/Language_Server_Protocol
sudo npm install -g pyright
sudo pacman -S clang # for clangd

find ~ -name 'nvim' -type d | xargs rm -rf
git checkout .
nvim # will bootstrap for the first time...
```

## Key Bindings

| Command | Mode | Source File | Description |
|---------|------|-------------|-------------|
| `<Leader><S-s>` | Normal | w32zhong.lua | Toggle search highlight |
| `<Leader>ta` | Normal | w32zhong.lua | Toggle tab/space visualization |
| `<Leader>ts` | Visual | w32zhong.lua | Remove trailing spaces in selection |
| `<Leader>nu` | Normal | w32zhong.lua | Toggle line numbers |
| `<Leader>sp` | Normal | w32zhong.lua | Toggle spell check |
| `<Leader>ss` | Normal | w32zhong.lua | Start substitution for word under cursor |
| `<Leader>cl` | Normal | w32zhong.lua | Toggle column ruler at cursor position |
| `<Leader>up` | Normal | w32zhong.lua | Run blog upload script |
| `<Leader>pu` | Normal | w32zhong.lua | Run blog publish script |
| `<Leader>ci` | Normal | w32zhong.lua | Set C-style indentation (4-space tabs, no expansion) |
| `<Leader>pi` | Normal | w32zhong.lua | Set Python-style indentation (4 spaces, expanded) |
| `<Leader>wi` | Normal | w32zhong.lua | Set Web-style indentation (2 spaces, expanded) |
| `<Leader>y` | Visual | w32zhong.lua | Copy selection to system clipboard |
| `<Leader>p` | Normal | w32zhong.lua | Paste from system clipboard replacing word under cursor |
| `<Leader>p` | Visual | w32zhong.lua | Paste from system clipboard replacing selection |
| `<Leader>*` | Normal | w32zhong.lua | Toggle highlighting for word under cursor |
| `<Leader>0` | Normal | w32zhong.lua | Clear all highlighted words |
| `<Leader>l` | Normal | init.lua | Go to next buffer (BufferLineCycleNext) |
| `<Leader>h` | Normal | init.lua | Go to previous buffer (BufferLineCyclePrev) |
| `<Leader><Leader>` | Normal | init.lua | Toggle between current and last buffer |
| `<Leader>x` | Normal | init.lua | Close current buffer (keeping previous open) |
| `<Leader>1-9` | Normal | init.lua | Jump to buffer at position 1-9 |
| `<Leader>=1-9` | Normal | init.lua | Move current buffer to position 1-9 |
| `<Leader>=-` | Normal | init.lua | Move current buffer to end of buffer list |
| `<leader>gt` | Normal | init.lua | Open LazyGit |
| `<leader>td` | Normal | init.lua | Toggle diagnostics on/off |
| `<leader>dn` | Normal | init.lua | Go to next diagnostic |
| `<leader>dN` | Normal | init.lua | Go to previous diagnostic |
| `<leader>ai` | Normal | init.lua | Toggle CodeCompanion AI chat |
| `<leader>ai` | Visual | init.lua | Add selected text to AI chat |
| `AI` | Command | init.lua | Abbreviation for CodeCompanionChat |
| `mm` | Normal | plugins.lua | Toggle letter mark on current line (marks.nvim) |
| `md` | Normal | plugins.lua | Delete mark on current line (marks.nvim) |
| `mD` | Normal | plugins.lua | Delete all marks in current buffer (marks.nvim) |
| `mn` | Normal | plugins.lua | Jump to next mark in current buffer (marks.nvim) |
| `mN` | Normal | plugins.lua | Jump to previous mark in current buffer (marks.nvim) |
| `'x` | Normal | Vim Default | Jump to mark x (where x is any letter) |
| `m0` | Normal | plugins.lua | Set bookmark (⚑) at current position (marks.nvim) |
| `m]` | Normal | plugins.lua | Jump to next bookmark (marks.nvim) |
| `m[` | Normal | plugins.lua | Jump to previous bookmark (marks.nvim) |
| `m-` | Normal | plugins.lua | Delete bookmark at current position (marks.nvim) |
| `m_` | Normal | plugins.lua | Delete all bookmarks (marks.nvim) |
| `g?` | Normal | plugins.lua | Show help for oil.nvim (File explorer) |
| `-` | Normal | plugins.lua | Navigate to parent directory (oil.nvim) |
| `g.` | Normal | plugins.lua | Toggle hidden files visibility (oil.nvim) |
| `<CR>` | Normal | plugins.lua | Select/open file or directory (oil.nvim) |
| `<M-\>` | Insert | plugins.lua | Accept word suggestion (Copilot) |
| `<M-]>` | Insert | plugins.lua | Next suggestion (Copilot) |
| `<M-[>` | Insert | plugins.lua | Previous suggestion (Copilot) |
| `<C-\>` | Insert | plugins.lua | Accept suggestion (Copilot) |
| `<C-s>` | Normal/Insert | plugins.lua | Send message (CodeCompanion chat) |
| `ga` | Normal | plugins.lua | Accept suggested change (CodeCompanion inline) |
| `gr` | Normal | plugins.lua | Reject suggested change (CodeCompanion inline) |
| `<PageUp>` | Insert | init.lua | Scroll completion docs up (nvim-cmp) |
| `<PageDown>` | Insert | init.lua | Scroll completion docs down (nvim-cmp) |
| `<CR>` | Insert | init.lua | Confirm completion selection (nvim-cmp) |
| `<Up>` | Insert | init.lua | Select previous completion item (nvim-cmp) |
| `<Down>` | Insert | init.lua | Select next completion item (nvim-cmp) |
| `<Tab>` | Insert | init.lua | Smart tab: expand snippet, jump next, or select completion |
| `<S-Tab>` | Insert | init.lua | Smart shift-tab: jump previous or select previous completion |


## AI Sign-In
* Copilot: `:Copilot auth` or export the `~/.config/github-copilot/*.json`
* CodeCompanion: `export ANTHROPIC_API_KEY=...`
