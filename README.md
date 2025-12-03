# 🚀 Neovim Configuration

> A modern, feature-rich Neovim configuration built for productivity and aesthetics

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![Version](https://img.shields.io/badge/version-0.11+-blue?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

</div>

---

## ✨ Features

<table>
  <tr>
    <td>🎨</td>
    <td><b>Beautiful UI</b></td>
    <td>Multiple colorschemes with transparent backgrounds</td>
  </tr>
  <tr>
    <td>⚡</td>
    <td><b>Blazing Fast</b></td>
    <td>Lazy loading and optimized performance</td>
  </tr>
  <tr>
    <td>🧠</td>
    <td><b>Smart LSP</b></td>
    <td>40+ language servers configured</td>
  </tr>
  <tr>
    <td>🔍</td>
    <td><b>Powerful Search</b></td>
    <td>Snacks.nvim picker integration</td>
  </tr>
  <tr>
    <td>📝</td>
    <td><b>Completion</b></td>
    <td>blink.cmp with emoji and dictionary support</td>
  </tr>
  <tr>
    <td>🎯</td>
    <td><b>File Navigation</b></td>
    <td>Harpoon for lightning-fast file switching</td>
  </tr>
</table>

---

## 📋 Requirements

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 16.0 (for certain LSP servers)
- **Python** >= 3.8 (for Python support)
- A [Nerd Font](https://www.nerdfonts.com/) installed
- Terminal with true color support

### Optional Dependencies

```bash
# For better search performance
brew install fzf ripgrep fd

# For clipboard support
brew install xclip  # Linux
brew install pbcopy # macOS (built-in)

# For word definitions
brew install wordnet
```

---

## 🚀 Installation

### Quick Install

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone <your-repo-url> ~/.config/nvim

# Create backup directories
mkdir -p ~/.backup-nvim ~/.swap-nvim ~/.undo-nvim

# Launch Neovim
nvim
```

The plugin manager (lazy.nvim) will automatically bootstrap and install all plugins on first launch.

---

## 📁 Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/               # Core configuration
│   │   ├── options.lua     # Vim options
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── autocmds.lua    # Auto commands
│   │   └── diagnostics.lua # Diagnostic settings
│   ├── lsp/                # LSP configuration
│   │   └── servers.lua     # Server configurations
│   └── plugins/            # Plugin configurations
│       ├── coding/         # Completion, snippets
│       ├── editor/         # Editor enhancements
│       ├── lang/           # Language-specific
│       ├── lsp/            # LSP plugins
│       ├── tools/          # Git, terminal, etc.
│       └── ui/             # UI enhancements
```

---

## 🎨 Colorschemes

This config comes with multiple beautiful colorschemes:

- 🌃 **Tokyo Night** (default) - A clean, dark theme
- 🌊 **Catppuccin** - Soothing pastel theme
- 🤖 **Cyberdream** - Futuristic cyberpunk theme
- 🌙 **OneDark** - Classic dark theme
- 🎮 **Sonokai** - High contrast theme
- 🌆 **2077** - Cyberpunk-inspired theme

**Switch colorschemes:** `<leader>uC`

---

## ⌨️ Key Mappings

> Leader key: `<Space>`

### General

| Key | Mode | Action |
|-----|------|--------|
| `<C-h/j/k/l>` | Normal | Navigate windows |
| `<leader>e` | Normal | File explorer |
| `<leader>h` | Normal | Harpoon menu |
| `<C-t>` | Normal | Toggle terminal |

### File Operations

| Key | Mode | Action |
|-----|------|--------|
| `<leader><space>` | Normal | Smart find files |
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Find Git files |
| `<leader>fr` | Normal | Recent files |
| `<leader>/` | Normal | Live grep |
| `<leader>,` | Normal | Buffers |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | References |
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename |
| `<leader>ca` | Normal | Code actions |
| `[d` / `]d` | Normal | Previous/next diagnostic |
| `<leader>df` | Normal | Format code |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | Normal | LazyGit |
| `<leader>gb` | Normal | Git branches |
| `<leader>gs` | Normal | Git status |
| `<leader>gl` | Normal | Git log |
| `<leader>gd` | Normal | Git diff |

### Buffer Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>bn` | Normal | Next buffer |
| `<leader>bp` | Normal | Previous buffer |
| `<leader>bd` | Normal | Delete buffer |

### Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>p` | Normal | Paste from system clipboard |

### Build Tools

**Maven:**
- `<leader>mi` - Clean install
- `<leader>mt` - Run tests
- `<leader>mk` - Package
- `<leader>mc` - Clean

**CMake:**
- `<leader>cc` - Configure
- `<leader>cm` - Build
- `<leader>cr` - Run

---

## 🧩 Plugin Highlights

### Core Plugins

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[blink.cmp](https://github.com/saghen/blink.cmp)** - Fast completion engine
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP installer
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### UI Enhancements

- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Dashboard, pickers, and more
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)** - LSP progress notifications
- **[rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)** - Rainbow parentheses

### Editor Features

- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close pairs
- **[auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)** - Automatic saving
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations

### Tools

- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal integration
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Diagnostics list
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding helper
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Git diff viewer

---

## 🔧 Supported Languages

### Core Languages

<table>
  <tr>
    <td>☕ Java</td>
    <td>🐍 Python</td>
    <td>🦀 Rust</td>
    <td>⚡ C/C++</td>
  </tr>
  <tr>
    <td>🐹 Go</td>
    <td>🌙 Lua</td>
    <td>💎 C#</td>
    <td>🎯 Kotlin</td>
  </tr>
</table>

### Web Development

<table>
  <tr>
    <td>📜 TypeScript/JavaScript</td>
    <td>🎨 HTML/CSS</td>
    <td>⚛️ React/JSX</td>
    <td>🌊 Tailwind CSS</td>
  </tr>
  <tr>
    <td>🔥 Svelte</td>
    <td>📊 GraphQL</td>
    <td>🟦 JSON/YAML</td>
    <td>✨ Emmet</td>
  </tr>
</table>

### Other Languages

- 🍎 Swift
- 🎯 Dart
- ⚙️ Scala
- 🗄️ SQL
- 📝 Markdown
- 📄 LaTeX
- 🐘 PHP
- 💎 Ruby
- 📋 Terraform
- 🐪 Perl
- 🤖 Arduino
- 📊 MATLAB

---

## 🎯 LSP Configuration

This config uses **Neovim 0.11+ native LSP API** with `vim.lsp.config()` and `root_markers` for project detection.

### Automatic Installation

All LSP servers are automatically installed via Mason on first launch:

```lua
:Mason  -- Open Mason UI
:MasonUpdate  -- Update all packages
```

### Custom Server Configs

Server configurations are centralized in `lua/lsp/servers.lua`. Each server includes:

- **Filetypes**: Supported file types
- **Root markers**: Project root detection
- **Settings**: Language-specific settings
- **Capabilities**: Completion capabilities via blink.cmp

---

## 🛠️ Formatters

Auto-formatting is enabled on save for all supported languages:

<table>
  <tr>
    <td><b>Language</b></td>
    <td><b>Formatter</b></td>
  </tr>
  <tr>
    <td>JavaScript/TypeScript</td>
    <td>Prettier</td>
  </tr>
  <tr>
    <td>Python</td>
    <td>Black + isort</td>
  </tr>
  <tr>
    <td>Lua</td>
    <td>StyLua</td>
  </tr>
  <tr>
    <td>C/C++</td>
    <td>clang-format</td>
  </tr>
  <tr>
    <td>Java</td>
    <td>google-java-format</td>
  </tr>
  <tr>
    <td>Rust</td>
    <td>rustfmt</td>
  </tr>
  <tr>
    <td>Go</td>
    <td>gofmt</td>
  </tr>
  <tr>
    <td>C#</td>
    <td>CSharpier</td>
  </tr>
</table>

**Toggle auto-format:** Modify `lua/core/autocmds.lua`

---

## 💡 Completion System

### Blink.cmp Features

- **LSP completions** - Intelligent code completion
- **Path completions** - File system paths
- **Buffer completions** - From open buffers
- **Snippet support** - LuaSnip integration
- **Emoji support** - 😎 Type emojis easily
- **Dictionary** - English word suggestions

### Snippet Trigger

Snippets are triggered with `;` prefix:

```
;func → expands to function snippet
;for → expands to for loop
;if → expands to if statement
```

**Navigate snippets:** `<Up>` / `<Down>`

---

## 🎮 Special Features

### Harpoon Quick Navigation

Mark up to 4 files for instant access:

1. `<leader>a` - Add current file to Harpoon
2. `<leader>h` - Open Harpoon menu
3. `<leader>1-4` - Jump to marked file 1-4

### Dashboard

Beautiful startup dashboard with:
- Recent files
- Projects
- Git status (when in git repo)
- Custom ASCII art
- Quick actions

### Trouble Integration

Split diagnostics and symbols side-by-side:

- `<leader>xx` - Bottom diagnostics panel
- `<leader>cs` - Right symbol outline (top)
- `<leader>cl` - Right LSP references (bottom)

---

## 🐛 Troubleshooting

### LSP Not Working

```vim
:LspInfo          " Check active LSP servers
:Mason            " Verify server installation
:checkhealth lsp  " Run health check
```

### Plugins Not Loading

```vim
:Lazy sync       " Sync all plugins
:Lazy clean      " Remove unused plugins
:Lazy restore    " Restore to lockfile state
```

### Performance Issues

```vim
:Lazy profile    " Profile plugin load times
:checkhealth     " Run full health check
```

### Reset Configuration

```bash
# Remove plugin cache
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim

# Restart Neovim
nvim
```

---

## 🎨 Customization

### Change Leader Key

Edit `init.lua`:

```lua
vim.g.mapleader = ","  -- Change from space to comma
```

### Add Custom Keybindings

Edit `lua/core/keymaps.lua`:

```lua
keymap("n", "<leader>w", ":w<CR>", opts)  -- Save with <leader>w
```

### Add New LSP Server

Edit `lua/lsp/servers.lua`:

```lua
-- In get_server_list():
"your_language_server",

-- In setup_server_configs():
vim.lsp.config("your_language_server", {
    filetypes = { "your_filetype" },
    root_markers = { ".git" },
})
```

### Modify Colorscheme

Edit `lua/plugins/ui/colorschemes.lua` to set your preferred default:

```lua
vim.cmd.colorscheme("catppuccin")  -- Change default
```

---

## 📚 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Docs](https://lazy.folke.io/)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [Treesitter Docs](https://tree-sitter.github.io/tree-sitter/)

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This configuration is available under the MIT License.

---

## 🙏 Credits

Built with love using:
- [Neovim](https://neovim.io/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- All the amazing plugin authors

---

<div align="center">

**Happy Coding! 🚀**

*Made with ❤️ and Neovim*

</div>