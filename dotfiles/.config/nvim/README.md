## Clean Installation
```sh
find ~ -name 'nvim' -type d | xargs rm -rf
git checkout .
nvim # will bootstrap for the first time...
```

## Key Bindings

| Command | Mode | Description |
|---------|------|-------------|
| **w32zhong.lua** |
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

