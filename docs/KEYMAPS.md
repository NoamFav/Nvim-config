---
title: Key Mappings
---

# Key Mappings

Every keymap defined in this config, grouped by what it's for. Leader key is `Space`.

← Back to [README](../README.md) · See also [Features](FEATURES.md) · [Plugin Reference](PLUGINS.md)

---

## Table of Contents

- [Finding Things (Snacks picker)](#finding-things-snacks-picker)
- [Navigation](#navigation)
- [LSP](#lsp)
- [Git](#git)
- [Terminal & Build Shortcuts](#terminal--build-shortcuts)
- [Clipboard](#clipboard)
- [Editing](#editing)
- [Which-key Groups](#which-key-groups)

---

## Finding Things (Snacks picker)

Defined in [`lua/plugins/ui/snacks.lua`](../lua/plugins/ui/snacks.lua).

| Key | Action |
|-----|--------|
| `<leader><space>` | Smart find files |
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fc` | Find config file (`stdpath("config")`) |
| `<leader>fb` / `<leader>,` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fp` | Projects |
| `<leader>/` / `<leader>sg` | Live grep |
| `<leader>sw` | Grep word/selection (normal + visual) |
| `<leader>sb` | Grep current buffer lines |
| `<leader>sB` | Grep open buffers |
| `<leader>e` | File explorer |
| `<leader>:` / `<leader>sc` | Command history |
| `<leader>n` | Notification history |
| `<leader>un` | Dismiss all notifications |
| `<leader>s"` | Registers |
| `<leader>s/` | Search history |
| `<leader>sa` | Autocmds |
| `<leader>sC` | Commands |
| `<leader>sd` / `<leader>sD` | Diagnostics (workspace/buffer) |
| `<leader>sh` | Help pages |
| `<leader>sH` | Highlights |
| `<leader>si` | Icons |
| `<leader>sj` | Jumps |
| `<leader>sk` | Keymaps |
| `<leader>sl` | Location list |
| `<leader>sm` | Marks |
| `<leader>sM` | Man pages |
| `<leader>sp` | Search lazy.nvim plugin specs |
| `<leader>sq` | Quickfix list |
| `<leader>sR` | Resume last picker |
| `<leader>su` | Undo history |
| `<leader>ss` / `<leader>sS` | LSP symbols (buffer/workspace) |
| `<leader>uC` | Colorschemes picker |
| `<leader>.` | Toggle scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>N` | Neovim news |

---

## Navigation

Defined in [`lua/core/keymaps.lua`](../lua/core/keymaps.lua) and [`lua/plugins/editor/harpoon.lua`](../lua/plugins/editor/harpoon.lua).

| Key | Action |
|-----|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between windows |
| `<leader>a` | Add file to Harpoon |
| `<leader>h` | Harpoon quick menu |
| `<leader>1` – `<leader>4` | Jump to Harpoon file 1–4 |
| `]]` / `[[` | Next/prev reference under cursor (Snacks words) |
| `<leader>bn` / `<leader>bp` / `<leader>bd` | Next/prev/delete buffer |
| `<leader>tn` / `<leader>tp` / `<leader>to` / `<leader>tc` | Tab next/prev/new/close |
| `<leader>pd` / `<leader>pu` | Page down/up |

---

## LSP

Defined in [`lua/core/keymaps.lua`](../lua/core/keymaps.lua), [`lua/plugins/ui/snacks.lua`](../lua/plugins/ui/snacks.lua), and [`lua/plugins/tools/trouble.lua`](../lua/plugins/tools/trouble.lua).

| Key | Action |
|-----|--------|
| `gd` | Go to definition (Snacks picker) |
| `gD` | Go to declaration |
| `gr` | References |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gai` / `gao` | Incoming/outgoing calls |
| `K` | Hover docs (Lspsaga) |
| `<leader>rn` | Rename (Lspsaga) |
| `<leader>ca` | Code action menu (`nvim-code-action-menu`) |
| `<leader>qf` | Code action (native) |
| `<leader>df` | Format buffer |
| `[d` / `]d` | Prev/next diagnostic (floating) |
| `<leader>xx` | Diagnostics (Trouble, pinned split) |
| `<leader>xX` | Buffer diagnostics (Trouble) |
| `<leader>cs` | Symbols (Trouble, right split) |
| `<leader>cl` | LSP list (Trouble, bottom split) |
| `<leader>xL` / `<leader>xQ` | Location/quickfix list (Trouble) |

---

## Git

Defined in [`lua/plugins/ui/snacks.lua`](../lua/plugins/ui/snacks.lua) (gitsigns/diffview/git-conflict ship their own default mappings on top of this).

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Git branches |
| `<leader>gs` | Git status |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log (current line) |
| `<leader>gf` | Git log for current file |
| `<leader>gd` | Git diff (hunks) |
| `<leader>gS` | Git stash |
| `<leader>gB` | Open current line in browser (normal + visual) |

---

## Terminal & Build Shortcuts

Defined in [`lua/core/keymaps.lua`](../lua/core/keymaps.lua) and [`lua/plugins/tools/terminal.lua`](../lua/plugins/tools/terminal.lua). These all shell out — see [Requirements](REQUIREMENTS.md) for the runtimes they depend on.

| Key | Action |
|-----|--------|
| `<C-t>` | Toggle floating terminal |
| `<leader>mi` | `mvn clean install` |
| `<leader>mk` | `mvn clean package` |
| `<leader>mc` | `mvn clean` |
| `<leader>mt` | `mvn test` |
| `<leader>me` | `mvn exec:exec` |
| `<leader>mf` | `mvn javafx:run` |
| `<leader>mj` | `mvn javadoc:javadoc` |
| `<leader>cc` | `cmake .` |
| `<leader>cm` | `cmake --build .` |
| `<leader>cr` | `cmake --build . --target run` |
| `<leader>ct` | `ctest` |
| `<leader>cb` | `cmr` (custom build alias) |
| `<leader>rm` | Run current file in MATLAB |
| `<leader>cf` | Format current C file with `c_formatter_42` |
| `<F1>` | Insert/update 42-header (`:Stdheader`) |

---

## Clipboard

Defined in [`lua/core/keymaps.lua`](../lua/core/keymaps.lua) — yanks/pastes the system clipboard (`"+`) without setting `unnamedplus` globally.

| Key | Action |
|-----|--------|
| `<leader>y` | Yank to system clipboard (normal + visual) |
| `<leader>Y` | Yank line to system clipboard |
| `<leader>p` | Paste from system clipboard |
| `<leader>P` | Paste before, from system clipboard |

---

## Editing

Defined in [`lua/plugins/editor/comment.lua`](../lua/plugins/editor/comment.lua) and [`lua/plugins/editor/treesitter-context.lua`](../lua/plugins/editor/treesitter-context.lua).

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment, current line |
| `gc` (normal/operator/visual) | Toggle comment, linewise |
| `gbc` | Toggle comment, current block |
| `gb` (normal/operator/visual) | Toggle comment, blockwise |
| `<leader>uk` | Toggle sticky treesitter-context header |
| `<Leader>s` | Toggle semantic-highlight |

---

## Which-key Groups

[`lua/plugins/tools/which-key.lua`](../lua/plugins/tools/which-key.lua) labels these leader prefixes so the which-key popup shows a group name instead of a flat key list:

| Prefix | Group |
|---|---|
| `<leader>b` | buffer |
| `<leader>c` | code |
| `<leader>d` | diagnostics |
| `<leader>f` | find |
| `<leader>g` | git |
| `<leader>l` | lsp |
| `<leader>m` | maven |
| `<leader>n` | notifications |
| `<leader>t` | tabs/terminal |
| `<leader>x` | trouble |
