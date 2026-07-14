<div align="center">

<!-- Animated Banner -->
<img src="https://capsule-render.vercel.app/api?type=venom&height=280&color=gradient&customColorList=12&text=NVIM-CONFIG&fontSize=110&fontColor=fff&animation=twinkling&desc=A%20Batteries-Included%20Neovim%20Setup%20%E2%80%94%2028%20LSPs%2C%20Zero-Lag%20Completion&descSize=18&descAlignY=72&stroke=FFFFFF&strokeWidth=1" alt="Nvim-config Banner" />

<!-- Animated Typing -->
<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=20&pause=1000&color=00D9FF&center=true&vCenter=true&multiline=true&repeat=true&width=900&height=80&lines=lazy.nvim+%2B+native+vim.lsp.config+%E2%80%94+no+nvim-lspconfig+server+defs;blink.cmp+%C2%B7+Treesitter+%C2%B7+Snacks+%C2%B7+Harpoon+%C2%B7+LazyGit+%C2%B7+Trouble" alt="Typing SVG" />

<br>

<!-- Badges -->
[![Neovim](https://img.shields.io/badge/Neovim-0.11+-57A143?style=for-the-badge&logo=neovim&logoColor=white&labelColor=0D1117)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-5.1+-2C2D72?style=for-the-badge&logo=lua&logoColor=white&labelColor=0D1117)](https://www.lua.org)
[![lazy.nvim](https://img.shields.io/badge/lazy.nvim-plugin_manager-7AA2F7?style=for-the-badge&labelColor=0D1117)](https://github.com/folke/lazy.nvim)
[![License](https://img.shields.io/badge/License-MIT-FF69B4?style=for-the-badge&labelColor=0D1117)](./LICENSE)

📖 [Full Plugin Reference](docs/PLUGINS.md) · 🛠️ [OS-by-OS Install Guide](docs/INSTALL.md)

</div>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- What is this -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=00D9FF&center=true&width=800&lines=%F0%9F%A7%A9+WHAT+IS+THIS+%3F" alt="What is this" />
</div>

<br>

<table align="center">
<tr>
<td width="50%" valign="top">

### The Idea
A single Neovim config that stays fast across **28 language servers** without turning into config soup. One central file — [`lua/lsp/servers.lua`](lua/lsp/servers.lua) — declares every server and its settings; Mason installs the binaries; native `vim.lsp.config`/`vim.lsp.enable` wires them up. No `nvim-lspconfig` server tables duplicating that work.

- **Native LSP** — Neovim 0.11's `vim.lsp.config` API, root markers instead of root-dir callbacks
- **Mason-driven installs** — servers + formatters auto-install on first launch
- **Cross-language semantic highlighting** — one styling pass for every LSP that emits semantic tokens

</td>
<td width="50%" valign="top">

### The Philosophy

```
 lua/lsp/servers.lua ──declares──► server list + settings
          │
          ├──► mason-lspconfig  (ensure_installed, auto-install)
          │
          └──► vim.lsp.enable() (native, per-server)

 Servers outside this loop (OmniSharp, sourcekit,
 dartls, metals) are configured but NOT Mason-managed —
 install their binaries yourself.
```

Formatting, Treesitter parsers, and colorschemes follow the same pattern: one file per concern, imported once from [`lua/plugins/init.lua`](lua/plugins/init.lua).

</td>
</tr>
</table>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Tech Stack -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=6A5ACD&center=true&width=800&lines=%F0%9F%92%BB+TECH+STACK+%F0%9F%92%BB" alt="Tech Stack" />
</div>

<br>

<div align="center">

### Core
<img src="https://skillicons.dev/icons?i=neovim,lua&theme=dark" />
<img src="https://img.shields.io/badge/tree--sitter-CLI%20%2B%20C%20compiler-DD4B39?style=for-the-badge&labelColor=0D1117" />

<br>

### Plugin & LSP Layer
<img src="https://img.shields.io/badge/lazy.nvim-Plugin%20Manager-7AA2F7?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/mason.nvim-LSP%2FFormatter%20Installer-00D9FF?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/blink.cmp-Completion-9B59B6?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/nvim--treesitter-Syntax%20%2F%20Folds-FF69B4?style=for-the-badge&labelColor=0D1117" />

<br>

### UI & Navigation
<img src="https://img.shields.io/badge/snacks.nvim-Picker%20%C2%B7%20Dashboard%20%C2%B7%20Explorer-00D9FF?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/Harpoon-File%20Nav-FF4500?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/LazyGit-Git%20TUI-FF69B4?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/Trouble-Diagnostics-9B59B6?style=for-the-badge&labelColor=0D1117" />

<br>

### Languages
<img src="https://skillicons.dev/icons?i=go,rust,py,java,c,cpp,cs,kotlin,swift,dart,scala,js,ts,react,html,css,tailwind,graphql,php,ruby,bash,docker,perl,arduino&theme=dark" />

</div>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Features -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=00D9FF&center=true&width=800&lines=%F0%9F%9A%80+FEATURES+%F0%9F%9A%80" alt="Features" />
</div>

<br>

> Every plugin backing these features — ~45 in total — is cataloged with a one-line description in [docs/PLUGINS.md](docs/PLUGINS.md).

<table align="center">
<tr>
<td width="50%" valign="top">

#### 🔍 Finding Things
- **Smart picker** — `Snacks.picker` for files, grep, buffers, git, LSP symbols, diagnostics, and more
- **Harpoon** — pin & jump between 4 files instantly
- **Dashboard** — recent files, projects, live git status

#### 🧠 LSP & Completion
- **28 language servers**, native `vim.lsp.config`, zero `nvim-lspconfig` boilerplate
- **blink.cmp** — LSP + path + snippets + buffer + emoji + dictionary sources
- **Trouble** — pinned diagnostics/symbols panes, follow-cursor
- **Lspsaga** — hover docs, rename, code action menu

</td>
<td width="50%" valign="top">

#### 🌐 Git & Tools
- **LazyGit**, Diffview, Gitsigns, git-blame, git-conflict — all wired through Snacks/native keymaps
- **Toggleterm** — floating terminal, one keystroke away
- **42 School** — header stamping + Norm linting + `c_formatter_42`

#### 📚 Language Extras
- **Jupyter notebooks** — Molten + image.nvim (Kitty graphics protocol)
- **LaTeX** — VimTeX + latexmk, live compile
- **Go** — go.nvim: run/test/coverage/struct-tags/`iferr`, all layered over `gopls`
- **C/C++** — clangd inlay hints + AST view + parameter highlighting

</td>
</tr>
</table>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Quickstart -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=FF69B4&center=true&width=800&lines=%E2%9C%A8+QUICKSTART+%E2%9C%A8" alt="Quickstart" />
</div>

<br>

```bash
# Core requirements — see docs/INSTALL.md for Linux/Windows equivalents
brew install neovim git ripgrep fd lazygit tree-sitter universal-ctags

# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone https://github.com/NoamFav/Nvim-config ~/.config/nvim

# Create the backup/swap/undo dirs lua/core/options.lua expects
mkdir -p ~/.logs/nvim/backup ~/.logs/nvim/swap ~/.logs/nvim/undo

# Launch — lazy.nvim bootstraps itself, installs plugins,
# then Mason auto-installs LSP servers + formatters
nvim
```

> [!TIP]
> Run `:Mason` after first launch to confirm every server installed cleanly, and `:checkhealth` to catch any missing system dependency.

> [!NOTE]
> A [Nerd Font](https://www.nerdfonts.com/) and a true-color terminal are required for icons and the transparent colorschemes to render correctly.

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Requirements -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=6A5ACD&center=true&width=800&lines=%F0%9F%93%A6+REQUIREMENTS+%F0%9F%93%A6" alt="Requirements" />
</div>

<br>

Mason (`:Mason`) auto-installs LSP servers and formatters on first launch, but each server still needs its **underlying language runtime** on `$PATH` — Mason doesn't install compilers or SDKs.

<details>
<summary><b>🌐 Core</b></summary>
<br>

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

</details>

<details>
<summary><b>🛠️ Language Runtimes</b></summary>
<br>

| Language | Runtime needed | Notes |
|---|---|---|
| Go | [Go](https://go.dev/) `>= 1.21` | `gopls`, `gofumpt`, and go.nvim's `gomodifytags`/`gotests`/`iferr`/`impl`/`dlv` (built via `go install` on first launch) |
| Rust | [Rust](https://rustup.rs/) (cargo) | `rust_analyzer`, `rustfmt` |
| Python | Python `>= 3.8` + pip | `pyright`, `black`, `isort`, `flake8` (via none-ls) |
| Node.js | Node `>= 16` | `ts_ls`, `eslint`, `html`, `emmet_ls`, `tailwindcss`, `jsonls`, `svelte`, `graphql`, `prettierd` |
| Java | JDK `>= 17` + [Maven](https://maven.apache.org/) | `jdtls`, `google-java-format`; `<leader>m*` shells out to `mvn` |
| C / C++ | Clang toolchain | `clangd`, `clang-format` |
| C# | [.NET SDK](https://dotnet.microsoft.com/) (+ Mono) | OmniSharp — **not Mason-managed**, see below |
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
| Arduino | [arduino-cli](https://arduino.github.io/arduino-cli/) | `arduino_language_server`; expects `~/.arduino15/arduino-cli.yaml`, targets `adafruit:samd:adafruit_feather_m0` — edit [lua/lsp/servers.lua](lua/lsp/servers.lua) for your board |
| Swift | Xcode command line tools | `sourcekit-lsp` via `xcrun` — **macOS only**, not Mason-managed |
| Dart | [Dart SDK](https://dart.dev/get-dart) | `dartls` — not Mason-managed |
| Scala | [Metals](https://scalameta.org/metals/) prerequisites (JDK, sbt/mill) | `metals` — not Mason-managed |
| LaTeX | TeX distribution (e.g. [MacTeX](https://tug.org/mactex/)) incl. `latexmk` | `ltex-ls`, `latexindent`; compiled via VimTeX |
| MATLAB | MATLAB with `matlab` CLI on `$PATH` | `<leader>rm` shells out to `matlab -nojvm -nosplash -nodesktop` |

```bash
# Example (macOS/Homebrew) — pick what you actually need
brew install go rustup python node openjdk maven composer terraform
```

> [!NOTE]
> OmniSharp, sourcekit, dartls, and metals are configured in [lua/lsp/servers.lua](lua/lsp/servers.lua) but excluded from `M.get_server_list()`'s Mason `ensure_installed` list — install their binaries yourself and put them on `$PATH`.

</details>

<details>
<summary><b>📓 Jupyter Notebooks (Molten + image.nvim)</b></summary>
<br>

| Requirement | Purpose |
|---|---|
| Kitty-graphics-protocol terminal (Kitty, WezTerm, Ghostty) | `image.nvim` is configured with `backend = "kitty"` |
| `pynvim`, `jupyter_client`, `cairosvg`, `pnglatex` (pip) | Molten kernel + LaTeX/plot rendering |
| [ImageMagick](https://imagemagick.org/) | Plot rendering |

```bash
pip install pynvim jupyter_client cairosvg pnglatex
brew install imagemagick
```

</details>

<details>
<summary><b>🏫 42 School Tooling (optional)</b></summary>
<br>

[lua/plugins/lsp/norminette.lua](lua/plugins/lsp/norminette.lua) adds header-stamping + Norm checking; `<leader>cf` shells out to a formatter.

```bash
pip install norminette
# c_formatter_42 must be on $PATH — https://github.com/42-Short/c_formatter_42
```

Update `user`/`mail` in [lua/plugins/lsp/norminette.lua](lua/plugins/lsp/norminette.lua) and `vim.g.user42`/`vim.g.mail42` in [lua/core/options.lua](lua/core/options.lua) to your own login.

</details>

<details>
<summary><b>📖 Dictionary Completion (optional)</b></summary>
<br>

```bash
brew install fzf wordnet
mkdir -p ~/.config/dictionaries
cp /usr/share/dict/words ~/.config/dictionaries/words.txt
```

</details>

<details>
<summary><b>🔧 Manual Setup: OmniSharp</b></summary>
<br>

`servers.lua` expects the OmniSharp binary at `~/.local/bin/omnisharp` (not installed by Mason):

```bash
mkdir -p ~/.local/bin
# Download the matching release for your OS from:
# https://github.com/OmniSharp/omnisharp-roslyn/releases
# and extract it to ~/.local/bin/omnisharp
```

</details>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Key Mappings -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=FF69B4&center=true&width=800&lines=%E2%8C%A8%EF%B8%8F+KEY+MAPPINGS+%E2%8C%A8%EF%B8%8F" alt="Key Mappings" />
</div>

<br>

> Leader key: `Space`

<details>
<summary><b>🔍 Finding Things (Snacks picker)</b></summary>
<br>

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

</details>

<details>
<summary><b>🧭 Navigation</b></summary>
<br>

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<leader>a` | Add file to Harpoon |
| `<leader>h` | Harpoon quick menu |
| `<leader>1-4` | Jump to Harpoon file 1-4 |
| `]]` / `[[` | Next/prev reference (Snacks words) |
| `<leader>bn/bp/bd` | Next/prev/delete buffer |
| `<leader>tn/tp/to/tc` | Tab next/prev/new/close |

</details>

<details>
<summary><b>🧠 LSP</b></summary>
<br>

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

</details>

<details>
<summary><b>🌱 Git</b></summary>
<br>

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` / `<leader>gs` / `<leader>gl` | Branches / status / log |
| `<leader>gd` | Diff (hunks) |
| `<leader>gB` | Open in browser |

</details>

<details>
<summary><b>💻 Terminal &amp; Build Shortcuts</b></summary>
<br>

| Key | Action |
|-----|--------|
| `<C-t>` | Toggle floating terminal |
| `<leader>m{i,k,c,t,e,f,j}` | Maven install/package/clean/test/exec/javafx/javadoc |
| `<leader>c{c,m,r,t,b}` | CMake configure/build/run/ctest/`cmr` |
| `<leader>rm` | Run current file in MATLAB |
| `<leader>cf` | Format current C file with `c_formatter_42` |

</details>

<details>
<summary><b>📋 Clipboard</b></summary>
<br>

| Key | Action |
|-----|--------|
| `<leader>y` / `<leader>Y` | Yank (line) to system clipboard |
| `<leader>p` / `<leader>P` | Paste (before) from system clipboard |

</details>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Colorschemes -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=00D9FF&center=true&width=800&lines=%F0%9F%8E%A8+COLORSCHEMES+%F0%9F%8E%A8" alt="Colorschemes" />
</div>

<br>

<div align="center">

Switch with `<leader>uC` — all configured transparent by default.

<img src="https://img.shields.io/badge/Tokyo%20Night-default-7AA2F7?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/Catppuccin-auto%20light%2Fdark-F5C2E7?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/Cyberdream-000000?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/OneDark-E5C07B?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/Sonokai-9ECE6A?style=for-the-badge&labelColor=0D1117" />
<img src="https://img.shields.io/badge/2077.nvim-FF00FF?style=for-the-badge&labelColor=0D1117" />

</div>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Structure -->
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=28&pause=1000&color=6A5ACD&center=true&width=800&lines=%F0%9F%93%81+STRUCTURE+%F0%9F%93%81" alt="Structure" />
</div>

<br>

> Hitting install snags on Linux/Windows? [docs/INSTALL.md](docs/INSTALL.md) has per-OS package manager commands and a troubleshooting table.

<details>
<summary><b>📁 Project Layout</b></summary>
<br>

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

</details>

<!-- Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">

<!-- Footer -->
<div align="center">

<img src="https://readme-typing-svg.herokuapp.com?font=Orbitron&size=22&pause=1000&color=6A5ACD&center=true&width=800&lines=Thanks+for+stopping+by!;Feel+free+to+%E2%AD%90+the+repo;Happy+hacking." alt="Footer typing" />

<br>

MIT — see [LICENSE](LICENSE)

Made with ♥ by [NoamFav](https://github.com/NoamFav)

<img src="https://capsule-render.vercel.app/api?type=waving&height=120&color=gradient&customColorList=12&section=footer" />

</div>
