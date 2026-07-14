# Installation Guide

Platform-specific setup for this config. For *why* each dependency is needed, see the [Requirements](../README.md#requirements) section of the README — this doc is just the install commands, per OS.

← Back to [README](../README.md) · See also [Plugin Reference](PLUGINS.md)

---

## Table of Contents

- [Minimum requirements](#minimum-requirements)
- [macOS](#macos)
- [Ubuntu / Debian](#ubuntu--debian)
- [Fedora](#fedora)
- [Arch Linux](#arch-linux)
- [Windows](#windows)
- [Clone & first launch (all platforms)](#clone--first-launch-all-platforms)
- [Language runtimes](#language-runtimes-by-package-manager)
- [Verifying the install](#verifying-the-install)
- [Troubleshooting](#troubleshooting)

---

## Minimum requirements

Regardless of OS, you need on `$PATH` before first launch:

- Neovim `>= 0.11.0`
- Git `>= 2.19.0`
- ripgrep, fd, lazygit
- tree-sitter CLI + a C compiler (`cc`/`gcc`/`clang`) — `nvim-treesitter` compiles parsers with these
- Universal Ctags — required by `tagbar`
- A [Nerd Font](https://www.nerdfonts.com/), set as your terminal's font
- A true-color terminal (Kitty, WezTerm, Ghostty, iTerm2, Windows Terminal, Alacritty…)

Everything else (language runtimes, LSP servers, formatters) is either installed by Mason automatically or listed per-language in the [Requirements](../README.md#requirements) table — install only what you actually code in.

---

## macOS

```bash
# Homebrew: https://brew.sh
brew install neovim git ripgrep fd lazygit tree-sitter universal-ctags

# Nerd Font (pick one, or use `brew search nerd-font` for more)
brew install --cask font-jetbrains-mono-nerd-font

# A GPU-accelerated, true-color terminal with image support (recommended)
brew install --cask kitty
```

> [!NOTE]
> Swift (`sourcekit-lsp`) is macOS-only and ships with Xcode Command Line Tools: `xcode-select --install`.

---

## Ubuntu / Debian

The distro's `neovim` package is often too old for `>= 0.11`. Use the [Neovim PPA](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu) (Ubuntu) or the official AppImage (Debian/either):

```bash
# Ubuntu — PPA has current stable releases
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# Debian/Ubuntu fallback — AppImage (always current)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# Everything else
sudo apt install git ripgrep fd-find universal-ctags build-essential curl unzip

# lazygit isn't in apt — install the release binary
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# tree-sitter CLI isn't in apt either — via npm or cargo
npm install -g tree-sitter-cli
# or: cargo install tree-sitter-cli
```

> [!NOTE]
> On Debian/Ubuntu the `fd` binary is packaged as `fd-find` and installs as `fdfind`. Either alias it (`alias fd=fdfind`) or symlink `~/.local/bin/fd -> $(which fdfind)`.

Nerd Font: download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), unzip into `~/.local/share/fonts`, then `fc-cache -fv`.

---

## Fedora

```bash
sudo dnf install neovim git ripgrep fd-find lazygit ctags gcc make curl unzip

# tree-sitter CLI
npm install -g tree-sitter-cli
# or: cargo install tree-sitter-cli
```

Nerd Font: download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), unzip into `~/.local/share/fonts`, then `fc-cache -fv`.

---

## Arch Linux

Everything needed is in `extra`/AUR:

```bash
sudo pacman -S neovim git ripgrep fd lazygit tree-sitter tree-sitter-cli ctags base-devel

# Nerd Fonts are packaged individually, e.g.:
sudo pacman -S ttf-jetbrains-mono-nerd
```

---

## Windows

Native Windows works, but several plugins here (`molten-nvim`'s Python build steps, `c_formatter_42`, shell-based Maven/CMake keymaps) assume a POSIX shell. **WSL2 with an Ubuntu distro is recommended** — follow the [Ubuntu / Debian](#ubuntu--debian) steps inside WSL. If you want native Windows:

```powershell
# winget
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install JesseDuffield.lazygit
winget install universal-ctags.ctags

# tree-sitter CLI
npm install -g tree-sitter-cli

# Nerd Font
winget install DEVCOM.JetBrainsMonoNerdFont
```

You'll also need the [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) (C++ workload) so `nvim-treesitter` and any `:MasonInstall` builds have a C compiler.

> [!TIP]
> Windows Terminal supports true color and Nerd Font glyphs out of the box, but not the Kitty graphics protocol — Jupyter/Molten inline images won't render. Use WSL2 + a Linux-native Kitty/WezTerm if you need that.

---

## Clone & first launch (all platforms)

```bash
# Backup any existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone
git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim

# Directories lua/core/options.lua expects for backup/swap/undo files
mkdir -p ~/.logs/nvim/backup ~/.logs/nvim/swap ~/.logs/nvim/undo

# Launch — lazy.nvim bootstraps itself, installs plugins,
# then Mason auto-installs LSP servers + formatters
nvim
```

---

## Language runtimes by package manager

Only install what you actually need — see the [Requirements](../README.md#requirements) table in the README for which plugin/server needs each one.

| Language | macOS (brew) | Ubuntu/Debian (apt) | Fedora (dnf) | Arch (pacman) |
|---|---|---|---|---|
| Go | `brew install go` | `apt install golang-go` | `dnf install golang` | `pacman -S go` |
| Rust | `brew install rustup` | via [rustup.rs](https://rustup.rs) | via [rustup.rs](https://rustup.rs) | `pacman -S rustup` |
| Python | `brew install python` | `apt install python3 python3-pip` | `dnf install python3 python3-pip` | `pacman -S python python-pip` |
| Node.js | `brew install node` | via [nodesource](https://github.com/nodesource/distributions) or `nvm` | `dnf install nodejs` | `pacman -S nodejs npm` |
| Java (JDK) | `brew install openjdk` | `apt install openjdk-21-jdk` | `dnf install java-21-openjdk` | `pacman -S jdk-openjdk` |
| Maven | `brew install maven` | `apt install maven` | `dnf install maven` | `pacman -S maven` |
| Clang/LLVM | `xcode-select --install` | `apt install clang` | `dnf install clang` | `pacman -S clang` |
| .NET SDK | `brew install dotnet` | via [Microsoft's apt repo](https://learn.microsoft.com/dotnet/core/install/linux) | `dnf install dotnet-sdk-8.0` | `pacman -S dotnet-sdk` |
| PHP + Composer | `brew install php composer` | `apt install php composer` | `dnf install php composer` | `pacman -S php composer` |
| Ruby | `brew install ruby` | `apt install ruby-full` | `dnf install ruby` | `pacman -S ruby` |
| Terraform | `brew install terraform` | via [HashiCorp's apt repo](https://developer.hashicorp.com/terraform/install) | `dnf install terraform` | `pacman -S terraform` |
| Dart SDK | `brew install dart-sdk` | via [dart.dev](https://dart.dev/get-dart) | via [dart.dev](https://dart.dev/get-dart) | `pacman -S dart` (AUR) |
| Arduino CLI | `brew install arduino-cli` | via [arduino.github.io/arduino-cli](https://arduino.github.io/arduino-cli/latest/installation/) | same | `pacman -S arduino-cli` (AUR) |
| TeX distribution | `brew install --cask mactex-no-gui` | `apt install texlive-full` | `dnf install texlive-scheme-full` | `pacman -S texlive-most` |

---

## Verifying the install

```vim
:checkhealth      " catches missing system dependencies plugin-by-plugin
:Mason            " confirm every LSP server / formatter installed cleanly
:TSUpdate         " confirm treesitter parsers compiled (needs tree-sitter CLI + cc)
```

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| Boxes/question marks instead of icons | Terminal font isn't a Nerd Font, or the terminal is caching an old font list — restart the terminal |
| `:TSUpdate` fails / parsers won't compile | Missing tree-sitter CLI or C compiler — see [Minimum requirements](#minimum-requirements) |
| `tagbar` does nothing | Universal Ctags isn't installed, or the distro's default `ctags` (BSD/Emacs variant) shadows it — check `ctags --version` mentions "Universal Ctags" |
| Jupyter cells render as text, no plots | Not running Kitty/WezTerm/Ghostty, or `image.nvim`'s Python deps aren't installed — see [Requirements](../README.md#requirements) |
| C# / OmniSharp doesn't attach | Binary not placed at `~/.local/bin/omnisharp` — see [Manual Setup: OmniSharp](../README.md#manual-setup-omnisharp) |
| Swift/Dart/Scala LSP not attaching | Those servers aren't Mason-managed — install `sourcekit-lsp` (Xcode CLT), the Dart SDK, or Metals manually |
| `<leader>gg` does nothing | `lazygit` isn't installed or not on `$PATH` |
