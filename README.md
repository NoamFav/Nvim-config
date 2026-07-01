# 🟩 nvim-42

<div align="center">

<img src="https://img.shields.io/badge/neovim-0.11+-57A143.svg?style=for-the-badge&logo=neovim" alt="Neovim">
<img src="https://img.shields.io/badge/lua-5.1+-2C2D72.svg?style=for-the-badge&logo=lua" alt="Lua">
<img src="https://img.shields.io/badge/42-piscine-000000.svg?style=for-the-badge" alt="42">
<img src="https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge" alt="License">

**A Neovim config obsessed with C, shell, and Makefiles — built for the 42 piscine.**

[Install](#installation) · [Workflow](#the-42-workflow) · [Key Mappings](#key-mappings)

</div>

---

This is the `42` branch: the polyglot IDE has been stripped down to the three things that
actually matter at 42 — **C**, **shell (sh/bash)**, and **Makefiles** — plus the **norminette**
code standard and a fast norm → build → run loop (the piscine's local "CI/CD"). All the pretty
stuff stays: colorschemes, statusline, dashboard, icons, rainbow brackets, git signs,
todo-comments, and the symbol outline.

- **`c_formatter_42`** as the C formatter (norminette-style; clang-format is gone).
- **`42-header.nvim`** (`<F1>`) and **`norminette42.nvim`** (lint C/H on save).
- **`overseer.nvim`** task runner with a full 42 pipeline (make targets, norminette, single-file
  compile with `-Wall -Wextra -Werror`, run, and a chained norm+build gate).
- **`clangd`** with clangd_extensions (inlay hints, AST view).
- 42 boilerplate snippets: `main`, `mainargs`, `ftfn`, `guard`, and a norm-compliant `makefile`.
- Trimmed LSP: `clangd`, `bashls`, and a little `lua_ls` for editing this config.

---

## Requirements

- Neovim >= 0.11.0, Git, a [Nerd Font](https://www.nerdfonts.com/), true-color terminal.
- **External tools on `$PATH`:**

```bash
pip install c-formatter-42 norminette   # formatter + the Norm checker
brew install shellcheck fzf ripgrep fd  # shell linting + faster pickers
```

Mason auto-installs the rest (`shfmt`, `stylua`, `bash-language-server`).

---

## Installation

```bash
# Back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

git clone -b 42 https://github.com/NoamFav/Nvim-config ~/.config/nvim
nvim   # lazy.nvim installs everything on first launch
```

---

## The 42 workflow

Everything hangs off the `<leader>m` ("make/42") group and streams into a bottom task list +
quickfix. Tasks are also available via `<leader>ml` (`:OverseerRun`).

| Key | Action |
|-----|--------|
| `<leader>mm` | `make` |
| `<leader>mr` | `make re` |
| `<leader>mc` | `make clean` |
| `<leader>mf` | `make fclean` |
| `<leader>mn` | norminette (current file) |
| `<leader>mN` | norminette (whole project) |
| `<leader>mb` | `cc -Wall -Wextra -Werror` on the current file |
| `<leader>mx` | run `./a.out` |
| `<leader>mp` | **pipeline:** norminette → make |
| `<leader>mo` | toggle the task list |
| `<leader>cf` | format current C file with `c_formatter_42` |
| `<F1>` | insert / update the 42 header |

---

## Key Mappings

> Leader key: `Space`

### Navigation
| Key | Action |
|-----|--------|
| `<leader><space>` | Smart find files |
| `<leader>ff` | Find files |
| `<leader>/` | Live grep |
| `<leader>a` | Add file to Harpoon |
| `<leader>1`–`4` | Jump to Harpoon file |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<leader>rn` | Rename |
| `<leader>ca` | Code actions |
| `<leader>df` | Format |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Branches |
| `<leader>gd` | Diff |

---

## Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/        # options, keymaps, autocmds, diagnostics
    ├── lsp/         # clangd / bashls / lua_ls
    ├── snippets/    # 42 piscine boilerplate
    └── plugins/     # coding, editor, lang (c), lsp, tools, ui
```

---

## Colorschemes

Switch with `<leader>uC`: **Tokyo Night** (default), **Catppuccin**, **Cyberdream**,
**OneDark**, **2077**.

---

## License

MIT

---

<div align="center">
Made with ❤️ by <a href="https://github.com/NoamFav">NoamFav</a> · <code>nfavier</code>
</div>
