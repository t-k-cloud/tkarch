## Clean Installation
```sh
find ~ -name 'nvim' -type d | xargs rm -rf
git checkout .
nvim # will bootstrap for the first time...
```

## Key Bindings

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


