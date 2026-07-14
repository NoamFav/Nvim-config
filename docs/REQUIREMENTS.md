# Requirements

What this config needs installed, and *why* — organized by category. For OS-specific install commands (Homebrew/apt/dnf/pacman/winget), see [Install Guide](INSTALL.md) instead; this doc is the reference for what each dependency is for.

← Back to [README](../README.md) · See also [Install Guide](INSTALL.md)

---

## Table of Contents

- [Core](#core)
- [Language Runtimes](#language-runtimes)
- [Jupyter Notebooks](#jupyter-notebooks-molten--imagenvim)
- [42 School Tooling](#42-school-tooling-optional)
- [Dictionary Completion](#dictionary-completion-optional)
- [Manual Setup: OmniSharp](#manual-setup-omnisharp)

---

Mason (`:Mason`) auto-installs LSP servers and formatters on first launch, but each server still needs its **underlying language runtime** on `$PATH` — Mason doesn't install compilers or SDKs.

## Core

| Requirement | Version | Why |
|---|---|---|
| [Neovim](https://neovim.io/) | `>= 0.11.0` | Native `vim.lsp.config`/`vim.lsp.enable` API |
| [Git](https://git-scm.com/) | `>= 2.19.0` | Plugin management, Gitsigns, Diffview, git-blame |
| [Nerd Font](https://www.nerdfonts.com/) | any | Icons in lualine, devicons, mini-icons, which-key, Trouble |
| Terminal with true color | — | `termguicolors` is on; transparent colorschemes need support |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | latest | Backs every `Snacks.picker` grep source |
| [fd](https://github.com/sharkdp/fd) | latest | Faster file discovery for `Snacks.picker.files` |
| [lazygit](https://github.com/jesseduffield/lazygit) | latest | `<leader>gg` opens `Snacks.lazygit()` |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) | latest | `nvim-treesitter` (`main` branch) shells out to it for `:TSUpdate`/`.install()` |
| C compiler (`cc`/`gcc`/`clang`) | — | Needed alongside the tree-sitter CLI to compile parsers |
| [Universal Ctags](https://github.com/universal-ctags/ctags) | latest | Powers the `tagbar` sidebar outline |

## Language Runtimes

| Language | Runtime needed | Notes |
|---|---|---|
| Go | [Go](https://go.dev/) `>= 1.21` | `gopls`, `gofumpt`, and go.nvim's `gomodifytags`/`gotests`/`iferr`/`impl`/`dlv` (built via `go install` on first launch) |
| Rust | [Rust](https://rustup.rs/) (cargo) | `rust_analyzer`, `rustfmt` |
| Python | Python `>= 3.8` + pip | `pyright`, `black`, `isort`, `flake8` (via none-ls) |
| Node.js | Node `>= 16` | `ts_ls`, `eslint`, `html`, `emmet_ls`, `tailwindcss`, `jsonls`, `svelte`, `graphql`, `prettierd` |
| Java | JDK `>= 17` + [Maven](https://maven.apache.org/) | `jdtls`, `google-java-format`; `<leader>m*` shells out to `mvn` |
| C / C++ | Clang toolchain | `clangd`, `clang-format` |
| C# | [.NET SDK](https://dotnet.microsoft.com/) (+ Mono) | OmniSharp — **not Mason-managed**, see [below](#manual-setup-omnisharp) |
| Kotlin | JDK + Gradle/Maven project | `kotlin_language_server`, `ktlint` |
| PHP | PHP + [Composer](https://getcomposer.org/) | `phpactor` |
| Ruby | Ruby + Bundler | `solargraph` (gem) |
| Lua | bundled (LuaJIT via Neovim) | `lua_ls`, `stylua` |
| Bash | — | `bashls`, `shfmt`, `beautysh` |
| Docker | — | `dockerls`; Dockerfile formatting expects `dockerfilelint` on `$PATH` (manual, not Mason-managed) |
| Terraform | [Terraform](https://developer.hashicorp.com/terraform) CLI | `terraformls` |
| SQL | — | `sqlls`, `sqlfmt` |
| XML | — | `lemminx`, `xmlformatter` |
| Perl | Perl | `perlnavigator` |
| Arduino | [arduino-cli](https://arduino.github.io/arduino-cli/) | `arduino_language_server`; expects `~/.arduino15/arduino-cli.yaml`, targets `adafruit:samd:adafruit_feather_m0` — edit [lua/lsp/servers.lua](../lua/lsp/servers.lua) for your board |
| Swift | Xcode command line tools | `sourcekit-lsp` via `xcrun` — **macOS only**, not Mason-managed |
| Dart | [Dart SDK](https://dart.dev/get-dart) | `dartls` — not Mason-managed |
| Scala | [Metals](https://scalameta.org/metals/) prerequisites (JDK, sbt/mill) | `metals` — not Mason-managed |
| LaTeX | TeX distribution (e.g. [MacTeX](https://tug.org/mactex/)) incl. `latexmk` | `ltex-ls`, `latexindent`; compiled via VimTeX |
| MATLAB | MATLAB with `matlab` CLI on `$PATH` | `<leader>rm` shells out to `matlab -nojvm -nosplash -nodesktop` |

```bash
# Example (macOS/Homebrew) — pick what you actually need. See INSTALL.md for other OSes.
brew install go rustup python node openjdk maven composer terraform
```

> [!NOTE]
> OmniSharp, sourcekit, dartls, and metals are configured in [lua/lsp/servers.lua](../lua/lsp/servers.lua) but excluded from `M.get_server_list()`'s Mason `ensure_installed` list — install their binaries yourself and put them on `$PATH`.

## Jupyter Notebooks (Molten + image.nvim)

| Requirement | Purpose |
|---|---|
| Kitty-graphics-protocol terminal (Kitty, WezTerm, Ghostty) | `image.nvim` is configured with `backend = "kitty"` |
| `pynvim`, `jupyter_client`, `cairosvg`, `pnglatex` (pip) | Molten kernel + LaTeX/plot rendering |
| [ImageMagick](https://imagemagick.org/) | Plot rendering |

```bash
pip install pynvim jupyter_client cairosvg pnglatex
brew install imagemagick
```

## 42 School Tooling (optional)

[lua/plugins/lsp/norminette.lua](../lua/plugins/lsp/norminette.lua) adds header-stamping + Norm checking; `<leader>cf` shells out to a formatter.

```bash
pip install norminette
# c_formatter_42 must be on $PATH — https://github.com/42-Short/c_formatter_42
```

Update `user`/`mail` in [lua/plugins/lsp/norminette.lua](../lua/plugins/lsp/norminette.lua) and `vim.g.user42`/`vim.g.mail42` in [lua/core/options.lua](../lua/core/options.lua) to your own login.

## Dictionary Completion (optional)

```bash
brew install fzf wordnet
mkdir -p ~/.config/dictionaries
cp /usr/share/dict/words ~/.config/dictionaries/words.txt
```

## Manual Setup: OmniSharp

`servers.lua` expects the OmniSharp binary at `~/.local/bin/omnisharp` (not installed by Mason):

```bash
mkdir -p ~/.local/bin
# Download the matching release for your OS from:
# https://github.com/OmniSharp/omnisharp-roslyn/releases
# and extract it to ~/.local/bin/omnisharp
```
