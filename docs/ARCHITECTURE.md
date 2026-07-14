# Architecture

How this config is put together, for anyone extending it. For *what it does* see [Features](FEATURES.md); for *what's installed* see [Plugin Reference](PLUGINS.md).

← Back to [README](../README.md)

---

## Table of Contents

- [Design Philosophy](#design-philosophy)
- [The LSP Pipeline](#the-lsp-pipeline)
- [Load Order](#load-order)
- [Project Layout](#project-layout)

---

## Design Philosophy

One file per concern, imported once. The clearest example is LSP: [`lua/lsp/servers.lua`](../lua/lsp/servers.lua) is the **single source of truth** for which servers exist and how they're configured — nothing else in the repo defines a server. That file exports two functions:

- `get_server_list()` — a flat list of server names, consumed by `mason-lspconfig` as its `ensure_installed` list
- `setup_server_configs()` — per-server `vim.lsp.config(...)` calls (root markers, settings, custom `cmd`), called once from [`lua/plugins/lsp/mason.lua`](../lua/plugins/lsp/mason.lua)

This is deliberately **not** `nvim-lspconfig`-style — that plugin is only present for its `capabilities`/`on_attach` wildcard (`vim.lsp.config("*", ...)`); it doesn't own any server definitions here. Neovim 0.11's native `vim.lsp.config`/`vim.lsp.enable` does that job instead, so there's exactly one place to look when a server misbehaves.

The same one-file-per-concern pattern repeats elsewhere:

- **Formatters** — [`lua/plugins/lsp/formatters.lua`](../lua/plugins/lsp/formatters.lua) is the single filetype → formatter-exe mapping (used by both `mason-tool-installer`'s `ensure_installed` and `formatter.nvim`'s dispatch table)
- **Colorschemes** — [`lua/plugins/ui/colorschemes.lua`](../lua/plugins/ui/colorschemes.lua) declares every scheme; only Tokyo Night is `lazy = false` (the default), the rest load on-demand when picked via `<leader>uC`
- **Semantic-token styling** — [`lua/core/semantic_tokens.lua`](../lua/core/semantic_tokens.lua) is one styling pass that applies to *any* LSP emitting standard `@lsp.type.*`/`@lsp.mod.*` tokens, re-applied on every `ColorScheme` event so it survives switching themes

## The LSP Pipeline

```
 lua/lsp/servers.lua ──declares──► server list + settings
          │
          ├──► mason-lspconfig  (ensure_installed, auto-install on first launch)
          │
          └──► vim.lsp.enable() (native, per-server, scheduled after mason-lspconfig.setup())

 Servers outside this loop — OmniSharp, sourcekit, dartls, metals — are
 configured in servers.lua but deliberately excluded from get_server_list(),
 so Mason never tries (and fails) to install them. Install their binaries
 yourself; see docs/REQUIREMENTS.md.
```

Formatting follows a parallel but separate path: `mason-tool-installer` installs the formatter binaries, `formatter.nvim` dispatches to them per filetype, and `none-ls.nvim` runs a couple of linters (`flake8`) as LSP diagnostics rather than as formatters. Three different plugins, one job split cleanly by phase (install / format / lint) rather than one plugin doing all three.

## Load Order

```
init.lua
 ├─ bootstrap lazy.nvim (git clone if not present)
 ├─ set <leader> before any plugin loads
 ├─ require("core.options")          — vim.opt settings
 ├─ require("core.keymaps")          — non-plugin-owned keymaps
 ├─ require("core.autocmds")         — autocommands
 ├─ require("core.diagnostics")      — vim.diagnostic.config
 ├─ require("core.semantic_tokens").setup()
 └─ require("lazy").setup("plugins") — lazy-loads everything in lua/plugins/
```

`lua/plugins/init.lua` is the entry lazy.nvim actually loads; it declares a handful of standalone plugins directly, then `{ import = "plugins.<group>" }`s every subfolder (`ui`, `editor`, `coding`, `lsp`, `tools`, `lang`) so each group's files are free to add/remove plugins without touching this list.

## Project Layout

```
~/.config/nvim/
├── init.lua                    Bootstraps lazy.nvim, loads core/*, starts lazy.setup("plugins")
└── lua/
    ├── core/
    │   ├── options.lua         vim.opt settings, backup/swap/undo dirs, 42 login vars
    │   ├── keymaps.lua         Non-plugin-owned keymaps (windows, buffers, tabs, Maven, CMake, MATLAB…)
    │   ├── autocmds.lua        Autocommands
    │   ├── diagnostics.lua     Diagnostic sign/virtual-text config
    │   └── semantic_tokens.lua Cross-language @lsp.* highlight styling
    ├── lsp/
    │   └── servers.lua         get_server_list() (Mason ensure_installed) + setup_server_configs()
    └── plugins/
        ├── init.lua            Misc single-file plugins + imports every group below
        ├── coding/              blink.cmp, snippets
        ├── editor/              treesitter, harpoon, autopairs, autosave, comment…
        ├── lang/                Per-language extras (go, java, c, web, latex, matlab, jupyter)
        ├── lsp/                 mason, formatters, norminette
        ├── tools/               git, terminal, trouble, which-key
        └── ui/                  colorschemes, lualine, snacks, devicons, fidget…
```

See [Plugin Reference](PLUGINS.md#full-dependency-graph-mermaid) for a diagram of how these groups depend on each other.
