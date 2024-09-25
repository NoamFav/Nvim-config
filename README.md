
This repository contains my personal Neovim configuration files, optimized for development, Git integration, and general programming workflows.

## Overview

This Neovim setup includes:
- **LSP support** for multiple languages (via `mason.nvim` and `nvim-lspconfig`).
- **Completion engine** (`nvim-cmp`) with snippets integration.
- **Git integration** with `vim-fugitive`, `git-blame.nvim`, `vgit.nvim`, `diffview.nvim`, and `git-messenger.vim`.
- **File explorer** (`nvim-tree`).
- **Statusline** (`lualine.nvim`).
- **Telescope** for fuzzy searching and file finding.

### Table of Contents
- [Installation](#installation)
- [Key Features](#key-features)
- [Plugins](#plugins)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [License](#license)

## Installation

### Prerequisites

- **Neovim v0.5+** (Make sure you have a recent version of Neovim installed)
- **[Ripgrep](https://github.com/BurntSushi/ripgrep)** for Telescope's live grep.
- **[Git](https://git-scm.com/)** for version control.

### Clone and Setup

To use this configuration, clone the repository and copy the files to your Neovim configuration folder:

```bash
git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
