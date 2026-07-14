# ⚡ Nvim-config

<div align="center">

<img src="https://img.shields.io/badge/neovim-0.11+-57A143.svg?style=for-the-badge&logo=neovim" alt="Neovim">
<img src="https://img.shields.io/badge/lua-5.1+-2C2D72.svg?style=for-the-badge&logo=lua" alt="Lua">
<img src="https://img.shields.io/badge/plugin_manager-lazy.nvim-blueviolet.svg?style=for-the-badge" alt="lazy.nvim">
<img src="https://img.shields.io/badge/LSP-native%20vim.lsp.config-00ADD8.svg?style=for-the-badge" alt="Native LSP">
<img src="https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge" alt="License">

**A batteries-included Neovim configuration for polyglot development**

[Requirements](#requirements) · [Installation](#installation) · [Languages](#language-support--dependencies) · [Key Mappings](#key-mappings) · [Structure](#structure)

</div>

---

A fully loaded Neovim setup built on **lazy.nvim** and Neovim 0.11's native `vim.lsp.config` API — no `nvim-lspconfig` server definitions, just root markers and settings tables. 28 LSP servers, `blink.cmp` completion (with emoji/dictionary sources), Treesitter, Harpoon navigation, LazyGit/Diffview/Gitsigns, Trouble diagnostics, Jupyter notebooks via Molten, LaTeX via VimTeX, and five colorschemes.

---

## Requirements

### Core

| Requirement | Version | Why |
|---|---|---|
| [Neovim](https://neovim.io/) | `>= 0.11.0` | Native `vim.lsp.config`/`vim.lsp.enable` API used throughout [lua/lsp/servers.lua](lua/lsp/servers.lua) |
| [Git](https://git-scm.com/) | `>= 2.19.0` | Plugin management, Gitsigns, Diffview, git-blame |
| [Nerd Font](https://www.nerdfonts.com/) | any | Icons in lualine, devicons, mini-icons, which-key, Trouble |
| Terminal with true color | — | `termguicolors` is on; transparent colorschemes need a terminal that supports it |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | latest | Backs every `Snacks.picker` grep source |
| [fd](https://github.com/sharkdp/fd) | latest | Faster file discovery for `Snacks.picker.files` |
| [lazygit](https://github.com/jesseduffield/lazygit) | latest | `<leader>gg` opens `Snacks.lazygit()` |

```bash
brew install neovim git ripgrep fd lazygit
```

### Runtime toolchains (installed via Mason unless noted)

Mason (`:Mason`) auto-installs LSP servers and formatters on first launch, but each server still needs its **underlying language runtime** on `$PATH` — Mason doesn't install compilers/SDKs.

| Language | Runtime needed | Notes |
|---|---|---|
| Go | [Go](https://go.dev/) `>= 1.21` | `gopls`, `gofumpt`, and `go.nvim`'s `gomodifytags`/`gotests`/`iferr`/`impl`/`dlv` (built via `go install` on first launch) |
| Rust | [Rust](https://rustup.rs/) (cargo) | `rust_analyzer`, `rustfmt` |
| Python | Python `>= 3.8` + pip | `pyright`, `black`, `isort`, `flake8` (via none-ls) |
| Node.js | Node `>= 16` | `ts_ls`, `eslint`, `html`, `emmet_ls`, `tailwindcss`, `jsonls`, `svelte`, `graphql`, `prettierd` |
| Java | JDK `>= 17` + [Maven](https://maven.apache.org/) | `jdtls`, `google-java-format`; Maven keymaps under `<leader>m*` shell out to `mvn` |
| C / C++ | Clang toolchain | `clangd`, `clang-format` |
| C# | [.NET SDK](https://dotnet.microsoft.com/) (+ Mono on non-Windows) | See [manual setup](#manual-setup-omnisharp) — OmniSharp is **not** Mason-managed |
| Kotlin | JDK + Gradle/Maven project | `kotlin_language_server`, `ktlint` |
| PHP | PHP + [Composer](https://getcomposer.org/) | `phpactor` |
| Ruby | Ruby + Bundler | `solargraph` (gem) |
| Lua | bundled (LuaJIT via Neovim) | `lua_ls`, `stylua` |
| Bash | — | `bashls`, `shfmt`, `beautysh` |
| Docker | — | `dockerls`; Dockerfile formatting expects `dockerfilelint` on `$PATH` (install manually, not Mason-managed) |
| Terraform | [Terraform](https://developer.hashicorp.com/terraform) CLI | `terraformls` |
| SQL | — | `sqlls`, `sqlfmt` |
| XML | — | `lemminx`, `xmlformatter` |
| Perl | Perl | `perlnavigator` |
| Arduino | [arduino-cli](https://arduino.github.io/arduino-cli/) | `arduino_language_server`; expects config at `~/.arduino15/arduino-cli.yaml` and targets an `adafruit:samd:adafruit_feather_m0` board — edit [lua/lsp/servers.lua](lua/lsp/servers.lua) for your board |
| Swift | Xcode command line tools | `sourcekit-lsp` via `xcrun` — **macOS only**, not Mason-managed |
| Dart | [Dart SDK](https://dart.dev/get-dart) | `dartls` — not Mason-managed |
| Scala | [Metals](https://scalameta.org/metals/) prerequisites (JDK, sbt/mill) | `metals` — not Mason-managed |
| LaTeX | A TeX distribution (e.g. [MacTeX](https://tug.org/mactex/) / TeX Live) incl. `latexmk` | `ltex-ls`, `latexindent`; compiled via VimTeX |
| MATLAB | MATLAB (with the `matlab` CLI on `$PATH`) | `<leader>rm` shells out to `matlab -nojvm -nosplash -nodesktop` |

```bash
# Example (macOS/Homebrew) — pick what you actually need
brew install go rustup python node openjdk maven composer terraform
```

> [!NOTE]
> Servers marked **not Mason-managed** are configured in [lua/lsp/servers.lua](lua/lsp/servers.lua) but excluded from `M.get_server_list()`'s Mason `ensure_installed` list, so you must install their binaries yourself and ensure they're on `$PATH`.

### Jupyter notebooks (Molten + image.nvim)

- A terminal with the **Kitty graphics protocol** (Kitty, WezTerm, Ghostty) — `image.nvim` is configured with `backend = "kitty"`
- Python packages: `pynvim`, `jupyter_client`, `cairosvg`, `pnglatex`
- [ImageMagick](https://imagemagick.org/) for plot rendering

```bash
pip install pynvim jupyter_client cairosvg pnglatex
brew install imagemagick
```

### 42 School tooling (optional)

[lua/plugins/lsp/norminette.lua](lua/plugins/lsp/norminette.lua) adds 42-header + Norm checking, and `<leader>cf` shells out to a formatter:

```bash
pip install norminette
# c_formatter_42 must be on $PATH — https://github.com/42-Short/c_formatter_42
```

Update `user`/`mail` in [lua/plugins/lsp/norminette.lua](lua/plugins/lsp/norminette.lua) and `vim.g.user42`/`vim.g.mail42` in [lua/core/options.lua](lua/core/options.lua) to your own login.

### Dictionary completion (optional)

`blink-cmp-dictionary` needs word lists and, ideally, `fzf`:

```bash
brew install fzf wordnet
mkdir -p ~/.config/dictionaries
cp /usr/share/dict/words ~/.config/dictionaries/words.txt
```

<a name="manual-setup-omnisharp"></a>
### Manual setup: OmniSharp

`servers.lua` expects the OmniSharp binary at `~/.local/bin/omnisharp` (not installed by Mason):

```bash
mkdir -p ~/.local/bin
# Download the matching release for your OS from:
# https://github.com/OmniSharp/omnisharp-roslyn/releases
# and extract it to ~/.local/bin/omnisharp
```

---

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim

# Create backup/swap/undo directories used by lua/core/options.lua
mkdir -p ~/.logs/nvim/backup ~/.logs/nvim/swap ~/.logs/nvim/undo

# Launch Neovim — lazy.nvim bootstraps itself, then installs all plugins
# and Mason auto-installs the LSP servers/formatters on first run
nvim
```

Run `:Mason` afterwards to confirm every server installed cleanly, and `:checkhealth` to catch any missing system dependency.

---

## Structure

```
~/.config/nvim/
├── init.lua                   # bootstraps lazy.nvim, loads core/*, starts lazy.setup("plugins")
└── lua/
    ├── core/
    │   ├── options.lua         # vim.opt settings, backup/swap/undo dirs, 42 login vars
    │   ├── keymaps.lua         # non-plugin-owned keymaps (windows, buffers, tabs, Maven, CMake, MATLAB…)
    │   ├── autocmds.lua        # autocommands
    │   ├── diagnostics.lua     # diagnostic sign/virtual-text config
    │   └── semantic_tokens.lua # cross-language @lsp.* highlight styling
    ├── lsp/
    │   └── servers.lua         # M.get_server_list() (Mason ensure_installed) + M.setup_server_configs()
    └── plugins/
        ├── init.lua            # misc single-file plugins + imports every group below
        ├── coding/              # blink.cmp, snippets
        ├── editor/              # treesitter, harpoon, autopairs, autosave, comment…
        ├── lang/                # per-language extras (go, java, c, web, latex, matlab, jupyter)
        ├── lsp/                 # mason, formatters, norminette
        ├── tools/               # git, terminal, trouble, which-key
        └── ui/                  # colorschemes, lualine, snacks, devicons, fidget…
```

---

## Key Mappings

> Leader key: `Space`

### Finding things (Snacks picker)
| Key | Action |
|-----|--------|
| `<leader><space>` | Smart find files |
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fb` / `<leader>,` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fp` | Projects |
| `<leader>/` / `<leader>sg` | Live grep |
| `<leader>sw` | Grep word/selection |
| `<leader>e` | File explorer |
| `<leader>sd` / `<leader>sD` | Diagnostics (workspace/buffer) |
| `<leader>ss` / `<leader>sS` | LSP symbols (buffer/workspace) |
| `<leader>uC` | Colorschemes picker |

### Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<leader>a` | Add file to Harpoon |
| `<leader>h` | Harpoon quick menu |
| `<leader>1-4` | Jump to Harpoon file 1-4 |
| `]]` / `[[` | Next/prev reference (Snacks words) |
| `<leader>bn/bp/bd` | Next/prev/delete buffer |
| `<leader>tn/tp/to/tc` | Tab next/prev/new/close |

### LSP
| Key | Action |
|-----|--------|
| `gd` / `gD` | Go to definition / declaration |
| `gr` | References |
| `gI` / `gy` | Implementations / type definition |
| `K` | Hover docs (Lspsaga) |
| `<leader>rn` | Rename (Lspsaga) |
| `<leader>ca` / `<leader>qf` | Code action menu / code action |
| `<leader>df` | Format buffer |
| `[d` / `]d` | Prev/next diagnostic (floating) |
| `<leader>xx` / `<leader>xX` | Trouble diagnostics (workspace/buffer) |
| `<leader>cs` / `<leader>cl` | Trouble symbols / LSP list |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` / `<leader>gs` / `<leader>gl` | Branches / status / log |
| `<leader>gd` | Diff (hunks) |
| `<leader>gB` | Open in browser |

### Terminal & Build Shortcuts
| Key | Action |
|-----|--------|
| `<C-t>` | Toggle floating terminal |
| `<leader>m{i,k,c,t,e,f,j}` | Maven install/package/clean/test/exec/javafx/javadoc |
| `<leader>c{c,m,r,t,b}` | CMake configure/build/run/ctest/`cmr` |
| `<leader>rm` | Run current file in MATLAB |
| `<leader>cf` | Format current C file with `c_formatter_42` |

### Clipboard
| Key | Action |
|-----|--------|
| `<leader>y` / `<leader>Y` | Yank (line) to system clipboard |
| `<leader>p` / `<leader>P` | Paste (before) from system clipboard |

---

## Colorschemes

Switch with `<leader>uC`:

- **Tokyo Night** (default, `night` style)
- **Catppuccin** (auto light/dark: latte/mocha)
- **Cyberdream**
- **OneDark**
- **Sonokai**
- **2077** ([NoamFav/2077.nvim](https://github.com/NoamFav/2077.nvim))

All are configured transparent by default.

---

## Language Support & Dependencies

Go, Rust, Python, Java, Kotlin, C/C++, C#, Swift, Dart, Scala, Lua, TypeScript/JavaScript (+ React/JSX), HTML/CSS, Tailwind, Svelte, GraphQL, SQL, JSON/YAML/XML/TOML, Markdown, LaTeX, PHP, Ruby, Bash, Docker, Terraform, Perl, Arduino, MATLAB.

See the [Requirements](#requirements) table above for the exact runtime each language needs — this section only lists what's covered, since the versions and install commands live there to avoid duplication.

---

## License

MIT — see [LICENSE](LICENSE)

---

<div align="center">
Made with ❤️ by <a href="https://github.com/NoamFav">NoamFav</a>
</div>
