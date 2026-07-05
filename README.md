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

> **On a 42 cluster iMac?** You usually can't `brew`/`sudo`. Install the Python
> tools per-user instead: `pip install --user c-formatter-42 norminette` and make
> sure `~/.local/bin` is on your `$PATH`. `norminette` is the only hard dependency
> for the Norm workflow; everything else degrades gracefully if missing.

---

## Set your 42 identity

The 42 header stamps **your** login, not mine — it's read from your environment,
so there's nothing to edit. Just make sure these are exported (they already are on
a real 42 box):

```bash
export USER="your_login"                 # e.g. nfavier
export MAIL="your_login@student.42.fr"
```

Prefer to be explicit / override? Export `USER42` and `MAIL42` and they win. No
config file to edit means `git pull` never conflicts.

---

## Installation

```bash
# Back up any existing config first (won't clobber an existing backup)
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)

git clone -b 42 https://github.com/NoamFav/Nvim-config ~/.config/nvim
nvim   # lazy.nvim installs everything on first launch
```

---

## No Neovim? Bare-Vim fallback

Stuck on plain `vim` on the cluster with no way to install plugins? This repo
ships a self-contained [`vimrc`](vimrc) — no plugins, no plugin manager — with the
42 C style (tabs, column-80 marker, trailing-whitespace flags) and a **byte-correct
42 header** on `<F1>` that passes the Norm:

```bash
cp ~/.config/nvim/vimrc ~/.vimrc
# or fetch it directly:
# curl -fsSL https://raw.githubusercontent.com/NoamFav/Nvim-config/42/vimrc > ~/.vimrc
```

It also wires up `<leader>mm` (`make`), `<leader>mn` (`norminette %`), and
`<leader>mb` (`cc -Wall -Wextra -Werror % && ./a.out`) straight from Vim.

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
| `<leader>mv` | valgrind leak check on the binary _(Linux/cluster only)_ |
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

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Red errors / boxes on first launch | It's still installing. Quit, run `nvim` again, then `:Lazy sync`. |
| Icons show as `□` / tofu | Your terminal font isn't a Nerd Font. Install one and select it in your terminal. |
| `norminette` / `c_formatter_42` "not found" | Not on `$PATH`. `pip install --user norminette c-formatter-42` and add `~/.local/bin` to `$PATH`. |
| Header shows the wrong login | `export USER`/`MAIL` (or `USER42`/`MAIL42`) — see [Set your 42 identity](#set-your-42-identity). |
| Colors look washed out | Terminal isn't true-color. Set `TERM=xterm-256color` and enable truecolor. |
| Check the config's health | `:checkhealth` inside Neovim. |

---

## License

MIT

---

<div align="center">
Made with ❤️ by <a href="https://github.com/NoamFav">NoamFav</a> · <code>nfavier</code>
</div>
