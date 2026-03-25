# ⚡ Nvim-config

<div align="center">

<img src="https://img.shields.io/badge/neovim-0.11+-57A143.svg?style=for-the-badge&logo=neovim" alt="Neovim">
<img src="https://img.shields.io/badge/lua-5.1+-2C2D72.svg?style=for-the-badge&logo=lua" alt="Lua">
<img src="https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge" alt="License">

**Modern, feature-rich Neovim configuration built for productivity**

[Installation](#installation) · [Key Mappings](#key-mappings) · [Languages](#supported-languages)

</div>

---

A fully loaded Neovim setup using lazy.nvim — 40+ LSP servers, blink.cmp completion, Treesitter syntax highlighting, Harpoon navigation, LazyGit integration, and multiple colorschemes including Tokyo Night and Catppuccin.

---

## Requirements

- Neovim >= 0.11.0
- Git >= 2.19.0
- Node.js >= 16.0 (for certain LSP servers)
- Python >= 3.8
- A [Nerd Font](https://www.nerdfonts.com/)
- Terminal with true color support

```bash
# Optional — better search performance
brew install fzf ripgrep fd
```

---

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim

# Create backup directories
mkdir -p ~/.backup-nvim ~/.swap-nvim ~/.undo-nvim

# Launch Neovim — lazy.nvim installs all plugins automatically
nvim
```

---

## Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/        # options, keymaps, autocmds, diagnostics
    ├── lsp/         # server configurations
    └── plugins/     # coding, editor, lang, lsp, tools, ui
```

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
| `<leader>1-4` | Jump to Harpoon file |

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

## Colorschemes

Switch with `<leader>uC`:

- **Tokyo Night** (default)
- **Catppuccin**
- **Cyberdream**
- **OneDark**
- **2077**

---

## Supported Languages

Go, Rust, Python, Swift, Java, Kotlin, C/C++, C#, Lua, TypeScript/JavaScript, React, HTML/CSS, Tailwind, Svelte, GraphQL, SQL, Markdown, LaTeX, PHP, Ruby, Dart, Arduino, MATLAB, and more.

---

## License

MIT

---

<div align="center">
Made with ❤️ by <a href="https://github.com/NoamFav">NoamFav</a>
</div>
