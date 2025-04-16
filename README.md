<div align="center">

# 🚀 Neovim Configuration

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**A powerful, feature-rich Neovim setup for modern development**

</div>

---

## 📚 Overview

This repository contains a comprehensive Neovim configuration optimized for development with rich features including LSP support, intelligent code completion, Git integration, and much more. The setup leverages `lazy.nvim` for efficient plugin management and `mason.nvim` for handling language servers.

<details open>
<summary><b>✨ Key highlights</b></summary>

- **Modern plugin manager** with lazy-loading for fast startup
- **Intelligent code completion** with LSP integration
- **AI-powered assistance** via Copilot and ChatGPT integration
- **Beautiful UI** with customizable themes and status line
- **Git integration** for seamless version control workflow
- **Enhanced productivity** with quick navigation and search
- **Specialized language support** for diverse programming needs

</details>

---

## 🌟 Features

<details open>
<summary><b>🧩 Plugin Management</b></summary>

- **Lazy Loading**: Uses `lazy.nvim` to efficiently load plugins only when required
- **Performance Optimization**: Minimizes startup time and resource usage
- **Module Organization**: Clean, modular configuration structure

</details>

<details open>
<summary><b>🧠 LSP and Autocompletion</b></summary>

- **LSP Support**: Powered by `mason.nvim` and `nvim-lspconfig`
- **Intelligent Autocompletion**: Using `nvim-cmp` with multiple sources
- **Snippet Integration**: Enhanced with `LuaSnip` for code snippets
- **AI Coding Assistants**: 
  - `copilot.vim` for AI-powered code suggestions
  - `ChatGPT.nvim` for AI-driven assistance

</details>

<details open>
<summary><b>🔍 Code Navigation and Search</b></summary>

- **Fuzzy Finding**: `telescope.nvim` for quick file and symbol search
- **File Explorer**: `nvim-tree.lua` with file icons and navigation
- **Semantic Highlighting**: Enhanced code readability with `semantic-highlight.vim`
- **Tag Navigation**: Code structure browsing with `tagbar`
- **Fast File Switching**: Quick file marking and jumping with `harpoon`

</details>

<details open>
<summary><b>📝 Git Integration</b></summary>

- **Inline Blame**: See commit information with `git-blame.nvim`
- **Change Visualization**: View diffs with `diffview.nvim`
- **Conflict Resolution**: Handle merge conflicts via `git-conflict.nvim`
- **Git UI**: Full Git experience with `lazygit.nvim` integration
- **Change Indicators**: Track changes in the gutter with `gitsigns.nvim`

</details>

<details open>
<summary><b>⚡ Editing and Productivity</b></summary>

- **Smart Commenting**: Toggle comments easily with `Comment.nvim`
- **Auto-saving**: Automatic file saving with `auto-save.nvim`
- **Bracket Pairing**: Auto-close brackets with `nvim-autopairs`
- **Code Structure**: Visual indentation with `indent-blankline.nvim`
- **Task Management**: Highlighted TODOs with `todo-comments.nvim`
- **Performance**: Faster startup with `impatient.nvim`

</details>

<details open>
<summary><b>🎨 UI and Aesthetics</b></summary>

- **Status Line**: Customizable interface with `lualine.nvim`
- **File Icons**: Enhanced visuals with `nvim-web-devicons`
- **Theme Selection**: Multiple themes including `onedark.nvim`, `sonokai`, and `2077.nvim`
- **Welcome Screen**: Custom dashboard with `dashboard-nvim`
- **Notifications**: Stylish alerts with `nvim-notify`

</details>

<details open>
<summary><b>💻 Terminal Integration</b></summary>

- **Integrated Terminal**: Toggle-able terminal with `toggleterm.nvim`
- **Visual Terminal**: Beautifully integrated within the editor

</details>

<details open>
<summary><b>🔧 Specialized Language Support</b></summary>

- **LaTeX**: Rich typesetting with `vimtex`
- **MATLAB**: Syntax and navigation via `vim-matlab`
- **JSX/React**: Enhanced highlighting with `vim-jsx-pretty`
- **Gradle**: Build automation support with `vim-gradle`

</details>

---

## 🔧 Installation

### Prerequisites

<details open>
<summary><b>Neovim Requirements</b></summary>

Ensure you have **Neovim v0.5+** installed:

| OS | Installation Command |
|----|---------------------|
| **macOS** | `brew install neovim` |
| **Ubuntu** | `sudo apt update && sudo apt install neovim` |
| **Windows** | Download from [Neovim Releases](https://github.com/neovim/neovim/releases) |

</details>

<details>
<summary><b>Package Managers</b></summary>

- **Homebrew (macOS/Linux):**
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- **APT (Ubuntu/Debian):**
  Most packages can be installed via the default package manager.

</details>

<details>
<summary><b>Language Dependencies</b></summary>

<table>
<tr>
<th>Language</th>
<th>macOS</th>
<th>Ubuntu</th>
<th>Windows</th>
</tr>
<tr>
<td>Java</td>
<td><code>brew install java</code></td>
<td><code>sudo apt install default-jdk</code></td>
<td>Install from <a href="https://adoptopenjdk.net/">AdoptOpenJDK</a></td>
</tr>
<tr>
<td>Python</td>
<td><code>brew install python</code></td>
<td><code>sudo apt install python3</code></td>
<td>Install from <a href="https://www.python.org/downloads/">python.org</a></td>
</tr>
<tr>
<td>Node.js</td>
<td><code>brew install node</code></td>
<td><code>sudo apt install nodejs npm</code></td>
<td>Install from <a href="https://nodejs.org/">nodejs.org</a></td>
</tr>
<tr>
<td>Go</td>
<td><code>brew install go</code></td>
<td><code>sudo apt install golang</code></td>
<td>Install from <a href="https://golang.org/dl/">golang.org</a></td>
</tr>
<tr>
<td>Rust</td>
<td><code>brew install rust</code></td>
<td><code>sudo apt install rustc</code></td>
<td>Install from <a href="https://www.rust-lang.org/">rust-lang.org</a></td>
</tr>
<tr>
<td>Ruby</td>
<td><code>brew install ruby</code></td>
<td><code>sudo apt install ruby-full</code></td>
<td>Install from <a href="https://www.ruby-lang.org/en/downloads/">ruby-lang.org</a></td>
</tr>
<tr>
<td>LaTeX</td>
<td><code>brew install --cask mactex</code></td>
<td><code>sudo apt install texlive-full</code></td>
<td>Install from <a href="https://miktex.org/">miktex.org</a></td>
</tr>
</table>

</details>

<details>
<summary><b>Additional Tools</b></summary>

<table>
<tr>
<th>Tool</th>
<th>macOS</th>
<th>Ubuntu</th>
<th>Windows</th>
</tr>
<tr>
<td>Git</td>
<td><code>brew install git</code></td>
<td><code>sudo apt install git</code></td>
<td>Install from <a href="https://git-scm.com/download/win">git-scm.com</a></td>
</tr>
<tr>
<td>LazyGit</td>
<td><code>brew install lazygit</code></td>
<td><code>sudo add-apt-repository ppa:lazygit-team/release<br>sudo apt update<br>sudo apt install lazygit</code></td>
<td>Download from <a href="https://github.com/jesseduffield/lazygit/releases">LazyGit Releases</a></td>
</tr>
<tr>
<td>Ripgrep</td>
<td><code>brew install ripgrep</code></td>
<td><code>sudo apt install ripgrep</code></td>
<td>Download from <a href="https://github.com/BurntSushi/ripgrep/releases">Ripgrep Releases</a></td>
</tr>
<tr>
<td>Docker</td>
<td><code>brew install --cask docker</code></td>
<td><code>sudo apt install docker.io</code></td>
<td>Install <a href="https://www.docker.com/products/docker-desktop">Docker Desktop</a></td>
</tr>
</table>

</details>

<details>
<summary><b>Language Server Setup</b></summary>

<table>
<tr>
<th>Language</th>
<th>Installation</th>
</tr>
<tr>
<td>Python</td>
<td><code>pip install 'python-lsp-server[all]'</code></td>
</tr>
<tr>
<td>JavaScript/TypeScript</td>
<td><code>npm install -g typescript typescript-language-server</code></td>
</tr>
<tr>
<td>Go</td>
<td><code>go install golang.org/x/tools/gopls@latest</code></td>
</tr>
<tr>
<td>Rust</td>
<td><code>brew install rust-analyzer</code> (macOS)<br><code>sudo apt install rust-analyzer</code> (Ubuntu)</td>
</tr>
</table>

Most language servers can be installed directly through Mason (`:Mason`) once Neovim is configured.

</details>

### Configuration Installation

<details open>
<summary><b>Setup Steps</b></summary>

1. **Clone the Repository**

   ```bash
   git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim
   ```

2. **Open Neovim and Install Plugins**

   ```vim
   :Lazy install
   ```

3. **Verify Language Server Installation**

   Run `:Mason` in Neovim to install or update language servers.

</details>

---

## ⌨️ Key Mappings

<details open>
<summary><b>General Navigation</b></summary>

| Mapping | Action |
|---------|--------|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>to` | Open new tab |
| `<leader>tc` | Close tab |
| `<leader>pd` | Page down |
| `<leader>pu` | Page up |

</details>

<details open>
<summary><b>File and Code Navigation</b></summary>

| Mapping | Action |
|---------|--------|
| `<leader>ff` | Find files |
| `<leader>fe` | File browser |
| `<leader>fd` | Find diagnostics |
| `<leader>gf` | Git files |
| `<leader>gs` | Grep current word |
| `<C-n>` | Toggle file explorer |
| `<leader>r` | Refresh file explorer |
| `<leader>n` | Find current file |
| `<leader>tt` | Toggle tag browser |
| `<leader>tf` | Focus tag browser |

</details>

<details open>
<summary><b>LSP and Diagnostics</b></summary>

| Mapping | Action |
|---------|--------|
| `<leader>dn` | Next diagnostic |
| `<leader>dp` | Previous diagnostic |
| `<leader>df` | Format buffer |
| `<leader>rn` | Rename symbol |
| `K` | Show documentation |
| `<leader>ca` | Code action menu |
| `<leader>cl` | Toggle diagnostics |
| `<leader>xx` | Toggle diagnostics view |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Toggle symbols |
| `<leader>cc` | Close diagnostics |

</details>

<details>
<summary><b>Git Operations</b></summary>

| Mapping | Action |
|---------|--------|
| `<leader>lg` | Open LazyGit |
| `<leader>qf` | Show quickfix |
| `<leader>xQ` | Toggle quickfix |

</details>

<details>
<summary><b>Maven Commands</b></summary>

| Mapping | Action |
|---------|--------|
| `<leader>mm` | mvn clean install |
| `<leader>mp` | mvn clean package |
| `<leader>mc` | mvn clean |
| `<leader>mt` | mvn test |
| `<leader>me` | mvn exec:exec |
| `<leader>mf` | mvn javafx:run |
| `<leader>mj` | mvn javadoc:javadoc |

</details>

<details>
<summary><b>AI and Copilot</b></summary>

| Mapping | Action |
|---------|--------|
| `<C-J>` | Accept Copilot suggestion |
| `<C-K>` | Dismiss Copilot suggestion |
| `<leader>ai` | Open ChatGPT window |
| `<leader>ac` | Complete code with ChatGPT |
| `<leader>ae` | Edit with ChatGPT instruction |

</details>

<details>
<summary><b>Terminal and Miscellaneous</b></summary>

| Mapping | Action |
|---------|--------|
| `<C-t>` | Toggle terminal |
| `<leader>s` | Toggle semantic highlighting |
| `<C-,>` | Toggle focus on file explorer |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `<leader>fg` | Live grep text |
| `<leader>rm` | Run MATLAB script |

</details>

---

## 🧩 Plugin Gallery

<details open>
<summary><b>Core Plugins</b></summary>

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configurations for built-in LSP client |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Package manager for LSP servers |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder and search tool |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting |

</details>

<details>
<summary><b>UI and Appearance</b></summary>

| Plugin | Description |
|--------|-------------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [onedark.nvim](https://github.com/navarasu/onedark.nvim) | OneDark theme |
| [sonokai](https://github.com/sainnhe/sonokai) | Sonokai theme |
| [2077.nvim](https://github.com/hemangsk/2077.nvim) | Cyberpunk theme |
| [dashboard-nvim](https://github.com/glepnir/dashboard-nvim) | Start screen |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notifications |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow) | Rainbow parentheses |

</details>

<details>
<summary><b>Git Integration</b></summary>

| Plugin | Description |
|--------|-------------|
| [git-blame.nvim](https://github.com/f-person/git-blame.nvim) | Git blame information |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff viewer |
| [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) | Conflict resolution |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git status indicators |

</details>

<details>
<summary><b>Code Enhancement</b></summary>

| Plugin | Description |
|--------|-------------|
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Code commenting |
| [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim) | Auto-save files |
| [formatter.nvim](https://github.com/mhartington/formatter.nvim) | Code formatting |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODOs |
| [tagbar](https://github.com/preservim/tagbar) | Code structure view |
| [semantic-highlight.vim](https://github.com/thiagoalessio/semantic-highlight.vim) | Semantic highlighting |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |

</details>

<details>
<summary><b>Language Specific</b></summary>

| Plugin | Description |
|--------|-------------|
| [vimtex](https://github.com/lervag/vimtex) | LaTeX support |
| [vim-matlab](https://github.com/swlkr/vim-matlab) | MATLAB support |
| [vim-jsx-pretty](https://github.com/MaxMEllon/vim-jsx-pretty) | JSX/React syntax |
| [vim-gradle](https://github.com/tfnico/vim-gradle) | Gradle support |

</details>

<details>
<summary><b>AI and Assistance</b></summary>

| Plugin | Description |
|--------|-------------|
| [copilot.vim](https://github.com/github/copilot.vim) | GitHub Copilot integration |
| [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim) | ChatGPT integration |

</details>

<details>
<summary><b>Completion Sources</b></summary>

| Plugin | Description |
|--------|-------------|
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer words |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Command line |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP source |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File paths |
| [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip) | Snippet integration |

</details>

<details>
<summary><b>Utility Plugins</b></summary>

| Plugin | Description |
|--------|-------------|
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utilities |
| [popup.nvim](https://github.com/nvim-lua/popup.nvim) | Popup API |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI components |
| [impatient.nvim](https://github.com/lewis6991/impatient.nvim) | Startup optimization |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal integration |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | File navigation marks |

</details>

---

## 📂 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/                     # Lua configuration directory
│   ├── git.lua              # Git plugin configuration
│   ├── gpt.lua              # AI assistant configuration
│   ├── latex.lua            # LaTeX support setup 
│   ├── lualine.lua          # Status line configuration
│   ├── mason.lua            # LSP manager configuration
│   ├── notifications.lua    # Notification system
│   ├── nvim-cmp.lua         # Completion engine setup
│   ├── nvim-tree.lua        # File explorer configuration
│   └── telescope.lua        # Fuzzy finder setup
└── keymaps.vim              # Key mappings
```

---

## 📄 License

This configuration is licensed under the [MIT License](LICENSE).

<div align="center">

---

**Made with ❤️ by [Noam Fav](https://github.com/NoamFav)**

[⭐ Star this Repository](https://github.com/NoamFav/Nvim-config) • [🐛 Report Issue](https://github.com/NoamFav/Nvim-config/issues) • [🔄 Fork](https://github.com/NoamFav/Nvim-config/fork)

</div>
