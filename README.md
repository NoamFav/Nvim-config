# Neovim Configuration

This repository contains my Neovim setup, optimized for development with rich features like LSP support, auto-completion, Git integration, file exploration, and more. The configuration leverages `lazy.nvim` for efficient plugin management and `mason.nvim` for managing language servers. Below is an overview of the features, plugin list, installation instructions, and specific plugin configurations.

## Features

1. **Plugin Management**

   - **Lazy Loading and Performance**: Uses `lazy.nvim` to efficiently load plugins only when required, speeding up startup time and optimizing resource usage.

2. **LSP and Autocompletion**

   - **LSP Support**: Powered by `mason.nvim` and `nvim-lspconfig`, providing autocompletion, diagnostics, and jump-to-definition for multiple programming languages.
   - **Autocompletion with Snippets**: `nvim-cmp` offers intelligent autocompletion, integrated with `LuaSnip` and sources like buffer, path, and LSP.
   - **AI Code Suggestions**: `copilot.vim` and `ChatGPT.nvim` provide AI-driven autocompletion and code suggestions.

3. **Code Navigation and Search**

   - **Fuzzy Finder**: `telescope.nvim` enables quick file, buffer, and symbol searching, with additional media file search via `telescope-media-files.nvim`.
   - **File Explorer**: `nvim-tree.lua` provides a navigable file tree with icons for files and folders.
   - **Semantic Highlighting**: `semantic-highlight.vim` adds semantic code highlighting, enhancing code readability and structure understanding.
   - **Tag Navigation**: `tagbar` plugin offers a sidebar for navigating functions, classes, and other tags in your code.

4. **Git Integration**

   - **Git Blame**: `git-blame.nvim` displays blame information inline, showing who last modified each line.
   - **Git Diff and Review**: `diffview.nvim` provides a visual diff of changes and review capabilities within Neovim.
   - **Conflict Management**: `git-conflict.nvim` helps manage and resolve Git merge conflicts directly in Neovim.
   - **LazyGit Integration**: `lazygit.nvim` provides an interface to use LazyGit directly within Neovim.

5. **Editing and Productivity Enhancements**

   - **Commenting**: `Comment.nvim` allows easy toggling of comments in code.
   - **Auto-Save**: `auto-save.nvim` automatically saves files when they are modified.
   - **Auto Pairs**: `nvim-autopairs` automatically closes brackets and quotes as you type.
   - **Indentation Guides**: `indent-blankline.nvim` shows indentation levels for better code structure visualization.
   - **Todo Management**: `todo-comments.nvim` highlights and organizes TODO comments for easy tracking of tasks.
   - **Session Management**: `impatient.nvim` caches plugins for faster startup times.

6. **UI and Aesthetic Customization**

   - **Status Line**: `lualine.nvim` provides a customizable and minimal status line.
   - **Icons**: `nvim-web-devicons` adds file-type icons, enhancing the look of Neovim's interface.
   - **Color Schemes**: Includes themes like `onedark.nvim`, `sonokai`, and `2077.nvim` for aesthetic customization.
   - **Dashboard**: `dashboard-nvim` provides a start screen with quick access to frequently used files and sessions.
   - **Notifications**: `nvim-notify` manages pop-up notifications with customizable visuals.

7. **Terminal Integration**

   - **Toggleable Terminal**: `toggleterm.nvim` adds a terminal inside Neovim that can be toggled on and off with a keybind.

8. **Specialized Language Support**

   - **LaTeX Support**: `vimtex` provides rich LaTeX support for compiling and navigating LaTeX projects.
   - **Matlab Support**: `vim-matlab` offers Matlab language support, including syntax highlighting and file structure navigation.
   - **JavaScript JSX Enhancements**: `vim-jsx-pretty` improves JSX syntax highlighting for JavaScript projects.

9. **Other Utilities**
   - **Snippet Management**: `vim-vsnip` manages code snippets for quick insertion.
   - **Media File Search**: `telescope-media-files.nvim` allows searching within media files.
   - **Which Key**: `which-key.nvim` shows possible keybindings, improving discoverability of shortcuts.

## Installation

### Prerequisites

#### Neovim

Ensure you have **Neovim v0.5+** installed. You can install or update Neovim with the following commands based on your system:

- **macOS (Homebrew)**
  ```bash
  brew install neovim
  ```
- **Ubuntu (APT)**
  ```bash
  sudo apt update
  sudo apt install neovim
  ```
- **Windows**
  - Download the latest release from the [Neovim GitHub Releases](https://github.com/neovim/neovim/releases) page.
  - Extract the contents and add the `nvim` executable to your system path.

#### Package Managers (for Dependencies)

- **Homebrew (macOS and Linux)**: Recommended for managing dependencies and installations.

  - Install Homebrew if you haven’t already:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

- **APT (Ubuntu/Debian)**
  - For Ubuntu and Debian users, most packages can be installed via APT.

#### Additional Dependencies

These dependencies are needed for certain features and languages supported by your Neovim setup:

- **Java**: Required for Java development and some plugins that rely on Java runtime.

  - **macOS**:
    ```bash
    brew install java
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install default-jdk
    ```
  - **Windows**:
    - Download and install Java from [Oracle’s website](https://www.oracle.com/java/technologies/javase-downloads.html) or [AdoptOpenJDK](https://adoptopenjdk.net/).

- **Python**: Required for Python development and some plugins.

  - **macOS**:
    ```bash
    brew install python
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install python3
    ```
  - **Windows**:
    - Download from [python.org](https://www.python.org/downloads/) and install it.

- **SQL**: Required for SQLite database support.

  - **macOS**:
    ```bash
    brew install sqlite
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install sqlite3
    ```
  - **Windows**:
    - Download the latest version from [sqlite.org](https://www.sqlite.org/download.html) and add it to your system path.

- **PHP**: Required for PHP development.

  - **macOS**:
    ```bash
    brew install php
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install php
    ```
  - **Windows**:
    - Download from [php.net](https://www.php.net/downloads) and install it.

- **Go**: Required for Go development.

  - **macOS**:
    ```bash
    brew install go
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install golang
    ```
  - **Windows**:
    - Download from [golang.org](https://golang.org/dl/).

- **Rust**: Required for Rust development.

  - **macOS**:
    ```bash
    brew install rust
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install rustc
    ```
  - **Windows**:
    - Download and install Rust from [rust-lang.org](https://www.rust-lang.org/).

- **Ruby**: Required for Ruby development and some plugins.

  - **macOS**:
    ```bash
    brew install ruby
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install ruby-full
    ```
  - **Windows**:
    - Download from [ruby-lang.org](https://www.ruby-lang.org/en/downloads/) and install it.

- **Haskell**: Required for Haskell development.

  - **macOS**:
    ```bash
    brew install ghc cabal-install
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install ghc cabal-install
    ```
  - **Windows**:
    - Download from [haskell.org](https://www.haskell.org/platform/windows.html) and install it.

- **Node.js & npm**: Required for JavaScript, TypeScript development, and many language servers.

  - **macOS**:
    ```bash
    brew install node
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install nodejs npm
    ```
  - **Windows**:
    - Download from [nodejs.org](https://nodejs.org/).

- **LaTeX** (for `vimtex` and `latexindent` formatting): Required for LaTeX development.

  - **macOS**:
    ```bash
    brew install --cask mactex
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install texlive-full
    ```
  - **Windows**:
    - Install MiKTeX from [miktex.org](https://miktex.org/).

- **Perl**: Required for Perl development.

  - **macOS**:
    ```bash
    brew install perl
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install perl
    ```

- **Kotlin**: Required for Kotlin development.

  - **macOS**:
    ```bash
    brew install kotlin
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install kotlin
    ```

- **Docker**: Required for Docker-related development.

  - **macOS**:
    ```bash
    brew install --cask docker
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install docker.io
    ```
  - **Windows**:
    - Install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop).

- **Git**: Necessary for version control and Git-related plugins.

  - **macOS**:
    ```bash
    brew install git
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install git
    ```
  - **Windows**:
    - Download from [git-scm.com](https://git-scm.com/download/win).

- **LazyGit**: For a more visual Git experience within Neovim.

  - **macOS**:
    ```bash
    brew install lazygit
    ```
  - **Ubuntu**:
    ```bash
    sudo add-apt-repository ppa:lazygit-team/release
    sudo apt update
    sudo apt install lazygit
    ```
  - **Windows**:
    - Download from [LazyGit Releases](https://github.com/jesseduffield/lazygit/releases).

- **Ripgrep**: Required by Telescope for live grep functionality.
  - **macOS**:
    ```bash
    brew install ripgrep
    ```
  - **Ubuntu**:
    ```bash
    sudo apt install ripgrep
    ```
  - **Windows**:
    - Download from [Ripgrep GitHub Releases](https://github.com/BurntSushi/ripgrep/releases).

### Language Support Requirements

The following additional language server binaries are required for `mason.nvim` to provide support for specific programming languages. Run these commands as needed to install servers or formatters for each language.

- **Python**

  ```bash
  # Install python3 and pip if not installed
  sudo apt install python3 python3-pip   # Ubuntu
  brew install python                    # macOS

  # Install Python language server
  pip install 'python-lsp-server[all]'
  ```

- **JavaScript/TypeScript**

  ```bash
  npm install -g typescript typescript-language-server
  ```

- **Go**

  ```bash
  go install golang.org/x/tools/gopls@latest
  ```

- **Rust**

  ```bash
  # Install rust-analyzer
  brew install rust-analyzer              # macOS
  sudo apt install rust-analyzer          # Ubuntu
  ```

- **LaTeX (if using `vimtex`)**
  - You’ll need a LaTeX distribution installed:
    - **macOS**:
      ```bash
      brew install --cask mactex
      ```
    - **Ubuntu**:
      ```bash
      sudo apt install texlive-full
      ```
    - **Windows**:
      - Install MiKTeX from [miktex.org](https://miktex.org/).

### Installing the Configuration

1. **Clone the Repository**

   ```bash
   git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim
   ```

2. **Open Neovim and Install Plugins**
   Open Neovim and use `lazy.nvim` to install plugins:

   ```vim
   :Lazy install
   ```

3. **Verify Language Server Installation**
   Run `:Mason` in Neovim to open Mason’s interface. Install or update any required language servers from within Mason's menu.

---

## Plugin List

| Plugin                       | Description                                            |
| ---------------------------- | ------------------------------------------------------ |
| `2077.nvim`                  | Cyberpunk-themed colorscheme for Neovim                |
| `auto-save.nvim`             | Automatically saves files when changes are detected    |
| `ChatGPT.nvim`               | ChatGPT integration for code suggestions and AI help   |
| `cmp-buffer`                 | Source for buffer words in autocompletion              |
| `cmp-cmdline`                | Source for Neovim command-line completion              |
| `cmp-nvim-lsp`               | Provides LSP completion source for `nvim-cmp`          |
| `cmp-path`                   | File path source for autocompletion                    |
| `cmp-vsnip`                  | Snippet support for `nvim-cmp` with `vim-vsnip`        |
| `Comment.nvim`               | Plugin for easy commenting in code                     |
| `copilot.vim`                | GitHub Copilot integration for AI-driven suggestions   |
| `dashboard-nvim`             | Customizable start screen dashboard                    |
| `diffview.nvim`              | Git diff viewer for comparing file changes             |
| `git-blame.nvim`             | Shows Git blame info inline                            |
| `git-conflict.nvim`          | Helps manage and resolve Git merge conflicts           |
| `gitsigns.nvim`              | Shows Git changes in the sign column                   |
| `harpoon`                    | Mark and easily switch between files                   |
| `impatient.nvim`             | Speeds up Neovim startup by caching Lua modules        |
| `indent-blankline.nvim`      | Adds indentation guides for better code readability    |
| `lazy.nvim`                  | Plugin manager for lazy loading plugins                |
| `lazygit.nvim`               | Integration of LazyGit in Neovim                       |
| `lualine.nvim`               | Highly customizable status line                        |
| `LuaSnip`                    | Snippet engine for Neovim                              |
| `nui.nvim`                   | UI component library for Neovim                        |
| `nvim-autopairs`             | Automatically closes pairs like parentheses and braces |
| `nvim-cmp`                   | Completion engine with support for multiple sources    |
| `nvim-notify`                | Popup notification manager                             |
| `nvim-tree.lua`              | File explorer with icons for file types                |
| `nvim-treesitter`            | Syntax highlighting and parsing with Treesitter        |
| `nvim-ts-rainbow`            | Rainbow parentheses and brackets in Treesitter         |
| `nvim-web-devicons`          | Adds icons to Neovim plugins                           |
| `onedark.nvim`               | OneDark colorscheme for Neovim                         |
| `plenary.nvim`               | Lua utility functions used by other plugins            |
| `popup.nvim`                 | Popup API for Neovim plugins                           |
| `semantic-highlight.vim`     | Provides semantic highlighting based on Treesitter     |
| `sonokai`                    | Colorscheme inspired by Monokai                        |
| `tagbar`                     | Displays tags in a side panel for code navigation      |
| `telescope-media-files.nvim` | Media files extension for Telescope                    |
| `telescope.nvim`             | Fuzzy finder and search tool                           |
| `todo-comments.nvim`         | Highlight TODO comments in code                        |
| `toggleterm.nvim`            | Easily toggle between terminal windows                 |
| `trouble.nvim`               | Pretty diagnostics and quickfix list                   |
| `vim-gradle`                 | Syntax highlighting and support for Gradle files       |
| `vim-jsx-pretty`             | Improved JSX/React syntax highlighting                 |
| `vim-matlab`                 | MATLAB support for syntax and indentation              |
| `vim-vsnip`                  | Lightweight snippet plugin for Vim                     |
| `vimtex`                     | LaTeX support with syntax highlighting and compilation |
| `which-key.nvim`             | Displays possible keybindings on a key press           |
| `formatter.nvim`             | Plugin for formatting code using external formatters   |
| `lspsaga.nvim`               | Light-weight UI for LSP features                       |
| `mason.nvim`                 | Manages external language servers and tools            |
| `mason-lspconfig.nvim`       | Integrates Mason with Neovim's LSP client              |
| `mason-tool-installer.nvim`  | Installs additional tools via Mason                    |
| `nvim-code-action-menu`      | A code action menu for Neovim LSP                      |
| `nvim-lspconfig`             | Configurations for built-in LSP client                 |

For a complete list githubs, see the [Plugins Section](#full-plugin-list).

---

## Key Mappings

Key mappings are specified in `keymaps.vim` to streamline the workflow. Notable mappings include:

### General Key Mappings

- **`<leader>bn`**: Move to the next buffer.
- **`<leader>bp`**: Move to the previous buffer.
- **`<leader>bd`**: Delete the current buffer.
- **`<leader>tn`**: Move to the next tab.
- **`<leader>tp`**: Move to the previous tab.
- **`<leader>to`**: Open a new tab.
- **`<leader>tc`**: Close the current tab.
- **`<leader>pd`**: Page Down.
- **`<leader>pu`**: Page Up.
- **`<leader>ff`**: Find files using Telescope.
- **`<leader>fe`**: Open Telescope file browser.
- **`<leader>fd`**: Open diagnostics using Telescope.
- **`<leader>gf`**: Find Git files with Telescope.
- **`<leader>gs`**: Grep the current word with Telescope.
- **`<C-n>`**: Toggle the NvimTree file explorer.
- **`<leader>r`**: Refresh NvimTree.
- **`<leader>n`**: Find the current file in NvimTree.
- **`<C-t>`**: Toggle the terminal using ToggleTerm.
- **`<leader>tt`**: Toggle Tagbar view.
- **`<leader>tf`**: Toggle focus on Tagbar.

### Git Mappings

- **`<leader>lg`**: Open LazyGit directly.
- **`<leader>qf`**: Show quickfix list with code actions.
- **`<leader>xQ`**: Toggle the quickfix list in Trouble.

### Diagnostic and LSP Key Mappings

- **`<leader>dn`**: Go to the next diagnostic message.
- **`<leader>dp`**: Go to the previous diagnostic message.
- **`<leader>df`**: Format the current buffer.
- **`<leader>rn`**: Rename symbol using LSP Saga.
- **`K`**: Show hover documentation with LSP.
- **`<leader>ca`**: Open the code action menu.
- **`<leader>cl`**: Toggle LSP diagnostics on the right side using Trouble.
- **`<leader>xx`**: Toggle diagnostics view on the right.
- **`<leader>xX`**: Toggle diagnostics for the current buffer in Trouble.
- **`<leader>cs`**: Toggle symbols in Trouble.
- **`<leader>cc`**: Close Trouble diagnostics.

### Maven Shortcuts

- **`<leader>mm`**: Run `mvn clean install`.
- **`<leader>mp`**: Run `mvn clean package`.
- **`<leader>mc`**: Run `mvn clean`.
- **`<leader>mt`**: Run `mvn test`.
- **`<leader>me`**: Run `mvn exec:exec`.
- **`<leader>mf`**: Run JavaFX with `mvn javafx:run`.
- **`<leader>mj`**: Generate Javadoc with `mvn javadoc:javadoc`.

### Copilot Key Mappings

- **`<C-J>`**: Accept Copilot suggestion in insert mode.
- **`<C-K>`**: Dismiss Copilot suggestion in insert mode.

### Telescope Mappings for Navigation

- **`<leader>fb`**: Find buffers.
- **`<leader>fh`**: Find help tags.
- **`<leader>fg`**: Live grep for text.

### Code Actions

- **`<leader>ca`**: Open the code action menu with `CodeActionMenu`.
- **`<leader>qf`**: Quick fix options.
- **`<leader>rm`**: Run MATLAB script (Linux/Unix-specific setup).

### AI-related Mappings (ChatGPT and Copilot)

- **`<leader>ai`**: Open ChatGPT window.
- **`<leader>ac`**: Complete code with ChatGPT.
- **`<leader>ae`**: Edit with instruction in ChatGPT.

### Buffer and Tab Navigation

- **`<leader>bn`**: Move to the next buffer.
- **`<leader>bp`**: Move to the previous buffer.
- **`<leader>bd`**: Delete the current buffer.
- **`<leader>tn`**: Move to the next tab.
- **`<leader>tp`**: Move to the previous tab.
- **`<leader>to`**: Open a new tab.
- **`<leader>tc`**: Close the current tab.

### Miscellaneous

- **`<leader>s`**: Toggle semantic highlighting.
- **`<C-,>`**: Toggle focus on NvimTree file explorer.
- **`<leader>t`**: Toggle Tagbar focus.
- **`<leader>xx`**: Toggle diagnostics view using Trouble.

Refer to `keymaps.vim` for additional custom mappings.

---

## File Structure and Configuration Details

- **`init.lua`**: Main configuration file, loads plugins and settings.
- **`lua/` Directory**: Contains individual configuration files for plugins and other settings.

### Key Files and Their Configurations:

- **`git.lua`**: Configures Git-related plugins such as `git-blame.nvim` and `diffview.nvim` for version control.
- **`gpt.lua`**: Settings for AI-based autocompletion with `copilot.vim`.
- **`latex.lua`**: Sets up LaTeX support, likely with `vimtex` for typesetting.
- **`lualine.lua`**: Customizes the Neovim statusline using `lualine.nvim`.
- **`mason.lua`**: Configures `mason.nvim` to manage LSP servers and additional tools.
- **`notifications.lua`**: Manages notifications using `nvim-notify`.
- **`nvim-cmp.lua`**: Sets up `nvim-cmp` for autocompletion with buffer, LSP, and snippet sources.
- **`nvim-tree.lua`**: Configures the file explorer (`nvim-tree.lua`).
- **`telescope.lua`**: Configures `telescope.nvim` for file and buffer search, along with live grep functionality.

---

## Full Plugin List

- [2077.nvim](https://github.com/hemangsk/2077.nvim)
- [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)
- [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [copilot.vim](https://github.com/github/copilot.vim)
- [dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
- [diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim)
- [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon)
- [impatient.nvim](https://github.com/lewis6991/impatient.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [popup.nvim](https://github.com/nvim-lua/popup.nvim)
- [semantic-highlight.vim](https://github.com/thiagoalessio/semantic-highlight.vim)
- [sonokai](https://github.com/sainnhe/sonokai)
- [tagbar](https://github.com/preservim/tagbar)
- [telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [vim-gradle](https://github.com/tfnico/vim-gradle)
- [vim-jsx-pretty](https://github.com/MaxMEllon/vim-jsx-pretty)
- [vim-matlab](https://github.com/swlkr/vim-matlab)
- [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
- [vimtex](https://github.com/lervag/vimtex)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
- [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

## License

This configuration is licensed under the MIT License. See the LICENSE file for more details.
