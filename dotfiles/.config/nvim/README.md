## Clean Installation
```sh
sudo npm install -g pyright

find ~ -name 'nvim' -type d | xargs rm -rf
git checkout .
nvim # will bootstrap for the first time...
```

## Key Bindings

**w32zhong.lua**:

| Command | Mode | Description |
|---------|------|-------------|
| `<Leader><S-s>` | Normal | Toggle search highlight |
| `<Leader>ta` | Normal | Toggle tab/space visualization |
| `<Leader>ts` | Visual | Remove trailing spaces in selection |
| `<Leader>nu` | Normal | Toggle line numbers |
| `<Leader>sp` | Normal | Toggle spell check |
| `<Leader>ss` | Normal | Start substitution for word under cursor |
| `<Leader>cl` | Normal | Toggle column ruler at cursor position |
| `<Leader>up` | Normal | Run blog upload script |
| `<Leader>pu` | Normal | Run blog publish script |
| `<Leader>ci` | Normal | Set C-style indentation (4-space tabs, no expansion) |
| `<Leader>pi` | Normal | Set Python-style indentation (4 spaces, expanded) |
| `<Leader>wi` | Normal | Set Web-style indentation (2 spaces, expanded) |
| `<Leader>y` | Visual | Copy selection to system clipboard |
| `<Leader>p` | Normal | Paste from system clipboard replacing word under cursor |
| `<Leader>p` | Visual | Paste from system clipboard replacing selection |
| `<Leader>*` | Normal | Toggle highlighting for word under cursor |
| `<Leader>0` | Normal | Clear all highlighted words |
| `<Leader>l` | Normal | Go to next buffer |
| `<Leader>h` | Normal | Go to previous buffer |
| `<Leader><Leader>` | Normal | Toggle between current and last buffer |
| `<Leader>x` | Normal | Close current buffer (keeping previous open) |
| `<Leader>1-19` | Normal | Jump to buffer number 1-19 |


**plugins.lua**:

| Command | Mode | Description |
|---------|------|-------------|
| `mm` | Normal | Toggle bookmark at current line |
| `mj` | Normal | Add or edit bookmark annotation at current line |
| `mn` | Normal | Jump to next bookmark in local buffer |
| `mN` | Normal | Jump to previous bookmark in local buffer |
| `md` | Normal | Clean all bookmarks in local buffer |
| `mD` | Normal | Remove all bookmarks globally |
| `ml` | Normal | Show marked file list in quickfix window |
| `<M-\>` | Insert | Accept word suggestion (Copilot) |
| `<M-]>` | Insert | Next suggestion (Copilot) |
| `<M-[>` | Insert | Previous suggestion (Copilot) |
| `<C-\>` | Insert | Accept suggestion (Copilot) |
| `<C-s>` | Normal/Insert | Send message (CodeCompanion chat) |
| `ga` | Normal | Accept suggested change (CodeCompanion inline) |
| `gr` | Normal | Reject suggested change (CodeCompanion inline) |


**init.lua** (leftover key bindings):

| Command | Mode | Description |
|---------|------|-------------|
| `<leader>gt` | Normal | Open LazyGit |
| `<leader>td` | Normal | Toggle diagnostics on/off |
| `<leader>dn` | Normal | Go to next diagnostic |
| `<leader>dN` | Normal | Go to previous diagnostic |
| `<leader>ai` | Normal | Toggle CodeCompanion AI chat |
| `<leader>ai` | Visual | Add selected text to AI chat |
| `ai` | Command | Abbreviation for CodeCompanionChat |
| `<PageUp>` | Insert | Scroll completion docs up |
| `<PageDown>` | Insert | Scroll completion docs down |
| `<CR>` | Insert | Confirm completion selection |
| `<Up>` | Insert | Select previous completion item |
| `<Down>` | Insert | Select next completion item |
| `<Tab>` | Insert | Smart tab (expand snippet, jump next, or select completion) |
| `<S-Tab>` | Insert | Smart shift-tab (jump previous or select previous completion) |

## AI Sign-In
* Copilot: `:Copilot auth`
* CodeCompanion: `export ANTHROPIC_API_KEY=...`
