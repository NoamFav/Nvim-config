---
title: Features
---

# Features

A tour of what this config actually does, day-to-day. For the plugin behind each feature, see [Plugin Reference](PLUGINS.md); for the exact keys, see [Key Mappings](KEYMAPS.md).

← Back to [README](../README.md)

---

## Table of Contents

- [Finding Things](#finding-things)
- [LSP & Completion](#lsp--completion)
- [Git & Version Control](#git--version-control)
- [Editing Quality-of-Life](#editing-quality-of-life)
- [Language-Specific Tooling](#language-specific-tooling)
- [Notebooks & Documents](#notebooks--documents)
- [Appearance](#appearance)

---

## Finding Things

Everything search-related goes through [`snacks.nvim`](https://github.com/folke/snacks.nvim)'s picker — one fuzzy-finder UI for files, buffers, grep, git objects, LSP symbols, diagnostics, help pages, and more, instead of juggling separate plugins with separate keybindings.

- **Smart find** (`<leader><space>`) picks between recent files and a full file search depending on context
- **Live grep** (`<leader>/`) and **grep word/selection** (`<leader>sw`) — backed by ripgrep
- **File explorer** (`<leader>e`) and a **dashboard** on startup showing recent files, projects, and live `git status`
- **Harpoon** (`<leader>a` to pin, `<leader>1`-`<leader>4` to jump) for the 3-4 files you bounce between constantly while working a task — faster than any fuzzy search for files you already know you want

## LSP & Completion

28 language servers, wired through Neovim 0.11's **native** `vim.lsp.config`/`vim.lsp.enable` — no `nvim-lspconfig` server-definition tables duplicating what's already in [`lua/lsp/servers.lua`](../lua/lsp/servers.lua).

- **blink.cmp** completion — LSP, path, snippets, buffer text, emoji, and a personal dictionary, all fuzzy-scored together and updating on every keystroke
- **Lspsaga** — a nicer floating UI for hover docs (`K`) and rename (`<leader>rn`) than the LSP defaults
- **Trouble** — pinnable, auto-refreshing panes for diagnostics, LSP symbols, and references, so you can leave a diagnostics list open in a split while you fix things instead of re-triggering a picker each time
- **Cross-language semantic-token styling** ([`lua/core/semantic_tokens.lua`](../lua/core/semantic_tokens.lua)) — one styling pass (readonly = italic, deprecated = strikethrough, stdlib = italic, …) applied consistently across every server that emits standard semantic tokens, instead of relying on each colorscheme's per-language guesses
- **fidget.nvim** — LSP progress spinners in the corner instead of blocking the command line, plus it takes over `vim.notify` for a consistent notification history (`<leader>n`)

## Git & Version Control

- **LazyGit** (`<leader>gg`) for anything beyond a quick stage/commit — full TUI, no context switch to a terminal
- **Gitsigns** — hunk markers in the sign column as you edit
- **git-blame.nvim** — inline virtual-text blame for the current line
- **Diffview** — proper side-by-side diffs and file history (`:DiffviewOpen`)
- **git-conflict.nvim** — highlights merge conflict markers and gives keymaps to pick a side without hand-editing `<<<<<<<` blocks

## Editing Quality-of-Life

- **Treesitter** — syntax highlighting, indentation, and folding all driven by real parse trees instead of regex
- **treesitter-context** — a sticky header pinned to the top of the window showing which function/loop/if you're scrolled into (`<leader>uk` to toggle)
- **rainbow-delimiters** — nested brackets get distinct colors per depth
- **hlargs** — function parameters get one consistent color across every supported language, independent of the LSP's own semantic-token choices
- **auto-save.nvim** — saves on `InsertLeave`/`TextChanged`/`BufLeave` so "did I save that" stops being a question
- **nvim-autopairs**, **Comment.nvim** (`gcc`/`gc`/`gbc`/`gb`) — the usual editing conveniences

## Language-Specific Tooling

Beyond the LSP server itself, a few languages get dedicated tooling layered on top (all in [`lua/plugins/lang/`](../lua/plugins/lang/) — see [Plugin Reference](PLUGINS.md#language-extras-pluginslang) for the full list):

- **Go** — [go.nvim](https://github.com/ray-x/go.nvim) adds `:GoRun`, `:GoTest*`, a coverage overlay, struct-tag editing, `:GoIfErr`, `:GoFillStruct`, `:GoImpl` — all without touching `gopls` itself, which stays owned by `servers.lua`
- **C/C++** — [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) adds inlay hints and an AST viewer on top of `clangd`
- **Web** — Tailwind class previews ([tailwind-tools.nvim](https://github.com/luckasRanarison/tailwind-tools.nvim)) and JSX/TSX highlighting
- **42 School** — automatic header stamping (`<F1>`) and live Norm linting on `.c`/`.h` save, plus a `<leader>cf` shortcut to run `c_formatter_42`

## Notebooks & Documents

- **Jupyter notebooks** — [Molten](https://github.com/benlubas/molten-nvim) runs cells against a real kernel and renders plots inline via [image.nvim](https://github.com/3rd/image.nvim)'s Kitty-graphics-protocol backend, directly in the buffer — no browser tab
- **LaTeX** — [VimTeX](https://github.com/lervag/vimtex) compiles on save via `latexmk` and can open your PDF viewer synced to the cursor position
- **Markdown** — [markview.nvim](https://github.com/OXY2Dev/markview.nvim) renders headings/tables/checkboxes live in-buffer; [glow.nvim](https://github.com/ellisonleao/glow.nvim) (`:Glow`) for a full rendered preview when you want one

## Appearance

- **5 colorschemes** (Tokyo Night default, Catppuccin, Cyberdream, OneDark, Sonokai, plus the author's own [2077.nvim](https://github.com/NoamFav/2077.nvim)), switchable live with `<leader>uC` — see [README § Colorschemes](../README.md#colorschemes)
- All configured **transparent** by default
- **lualine** statusline/tabline that reads its theme from whichever colorscheme is active, rather than needing its own separate theme config
