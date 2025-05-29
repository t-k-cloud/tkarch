## Clean Installation
```sh
find ~ -name 'nvim' -type d | xargs rm -rf
git checkout .
nvim # will bootstrap for the first time...
```

| Command | Mode | Description |
|---------|------|-------------|
| **AI & Completion** |
| `<leader>ai` | n/v | AI chat (new conversation / add selected text) |
| `ai` | command | Command abbreviation for CodeCompanionChat |
| `<C-s>` | n/i | Send message in AI chat |
| `ga` | n | Accept AI suggested change |
| `gr` | n | Reject AI suggested change |
| `<M-\>` | i | Accept Copilot word suggestion |
| `<M-]>` | i | Next Copilot suggestion |
| `<M-[>` | i | Previous Copilot suggestion |
| `<C-\>` | i | Accept full Copilot suggestion |
| **Text Editing** |
| `<Leader><S-s>` | n | Toggle search highlight |
| `<Leader>ta` | n | Toggle tab/space visibility |
| `<Leader>ts` | v | Remove trailing spaces |
| `<Leader>ss` | n | Substitute word under cursor |
| `<Leader>y` | v | Copy to system clipboard |
| `<Leader>p` | n/v | Paste from system clipboard |
| `<Leader>*` | n | Toggle multi-word highlighting |
| `<Leader>0` | n | Clear multi-word highlighting |
| **Display & Navigation** |
| `<Leader>nu` | n | Toggle line numbers |
| `<Leader>sp` | n | Toggle spell check |
| `<Leader>cl` | n | Toggle column ruler at cursor |
| `<Leader>l` | n | Next buffer |
| `<Leader>h` | n | Previous buffer |
| `<Leader><Leader>` | n | Toggle between current/previous buffer |
| `<Leader>x` | n | Close current buffer |
| `<Leader>1-19` | n | Switch to buffer 1-19 |
| **Indentation Modes** |
| `<Leader>ci` | n | Set C-style indentation (tabs, 4 spaces) |
| `<Leader>pi` | n | Set Python-style indentation (spaces, 4) |
| `<Leader>wi` | n | Set Web-style indentation (spaces, 2) |
| **Bookmarks** |
| `mm` | n | Toggle bookmark at current line |
| `mj` | n | Add/edit bookmark annotation |
| `mn` | n | Jump to next bookmark |
| `mN` | n | Jump to previous bookmark |
| `md` | n | Clean bookmarks in current buffer |
| `mD` | n | Remove all bookmarks |
| `ml` | n | Show bookmarks list |
| **Development Tools** |
| `<leader>gt` | n | Open LazyGit |
| `<leader>td` | n | Toggle LSP diagnostics |
| `<leader>dn` | n | Go to next diagnostic |
| `<leader>dN` | n | Go to previous diagnostic |
| `<Leader>up` | n | Blog preview/upload |
| `<Leader>pu` | n | Blog publish |

