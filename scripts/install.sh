#!/usr/bin/env bash
# Exhaustive installer for this config: backup, clone, prep dirs, install
# core requirements, optionally install language runtimes, and (best-effort)
# fetch OmniSharp — mirrors docs/INSTALL.md and docs/REQUIREMENTS.md; treat
# those as the source of truth if this script and the docs ever disagree.
set -euo pipefail

REPO_URL="https://github.com/NoamFav/Nvim-config"
CONFIG_DIR="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
DATA_DIR="${NVIM_DATA_DIR:-$HOME/.local/share/nvim}"
LOCAL_BIN="$HOME/.local/bin"

ASSUME_YES=0
SKIP_FONT=0
SKIP_OMNISHARP=0
LANGUAGES=""

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------
log() { printf '\033[1;36m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$1" >&2; }
err() { printf '\033[1;31mxx\033[0m %s\n' "$1" >&2; }
die() {
	err "$1"
	exit 1
}
confirm() {
	[[ "$ASSUME_YES" -eq 1 ]] && return 0
	local reply
	read -r -p "$1 [y/N] " reply
	[[ "$reply" =~ ^[Yy]$ ]]
}

usage() {
	cat <<'EOF'
Usage: install.sh [options]

  -l, --languages LIST   Comma-separated languages to install runtimes for
                          (go,rust,python,node,java,clang,dotnet,kotlin,php,
                          ruby,terraform,dart,arduino,scala,latex). "all"
                          installs every one of them.
  -y, --yes              Non-interactive: assume yes, skip all prompts,
                          skip language selection unless --languages is set.
      --skip-font         Don't attempt to install a Nerd Font.
      --skip-omnisharp    Don't attempt to fetch the OmniSharp binary.
  -h, --help              Show this help.

Covers macOS (Homebrew), Ubuntu/Debian (apt), Fedora (dnf), and Arch (pacman).
Windows: use WSL2 and run this inside it, or see docs/INSTALL.md#windows.
EOF
}

# ---------------------------------------------------------------------------
# Arg parsing
# ---------------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
	case "$1" in
	-l | --languages)
		LANGUAGES="$2"
		shift 2
		;;
	-y | --yes)
		ASSUME_YES=1
		shift
		;;
	--skip-font)
		SKIP_FONT=1
		shift
		;;
	--skip-omnisharp)
		SKIP_OMNISHARP=1
		shift
		;;
	-h | --help)
		usage
		exit 0
		;;
	*)
		die "Unknown option: $1 (see --help)"
		;;
	esac
done

# ---------------------------------------------------------------------------
# OS / arch detection
# ---------------------------------------------------------------------------
OS="$(uname -s)"
ARCH="$(uname -m)"
PM=""
DISTRO=""

case "$OS" in
Darwin)
	PM="brew"
	DISTRO="macos"
	;;
Linux)
	if command -v apt >/dev/null 2>&1; then
		PM="apt"
		DISTRO="$(. /etc/os-release 2>/dev/null && echo "${ID:-debian}" || echo debian)"
	elif command -v dnf >/dev/null 2>&1; then
		PM="dnf"
		DISTRO="fedora"
	elif command -v pacman >/dev/null 2>&1; then
		PM="pacman"
		DISTRO="arch"
	else
		die "No supported package manager found (apt/dnf/pacman). See docs/INSTALL.md."
	fi
	;;
*)
	die "Unsupported OS: $OS. On Windows, run this from inside WSL2, or see docs/INSTALL.md#windows."
	;;
esac
log "Detected: $DISTRO ($PM), arch $ARCH"

# ---------------------------------------------------------------------------
# GitHub release binary fetcher — used for tools whose distro packages are
# missing, ancient, or inconsistent (lazygit, tree-sitter CLI, arduino-cli,
# OmniSharp). Downloads the newest release asset whose name matches $2,
# extracts it if needed, and installs the resulting binary as $LOCAL_BIN/$3.
# ---------------------------------------------------------------------------
fetch_release_asset_url() {
	local repo="$1" pattern="$2"
	curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" |
		grep -o "\"browser_download_url\": *\"[^\"]*\"" |
		cut -d'"' -f4 |
		grep -E "$pattern" |
		head -n1
}

install_release_binary() {
	local repo="$1" pattern="$2" binary_name="$3" inner_path="${4:-}"
	local url
	url="$(fetch_release_asset_url "$repo" "$pattern")"
	if [[ -z "$url" ]]; then
		warn "Couldn't find a $binary_name release asset matching '$pattern' for $OS/$ARCH — install it manually."
		return 1
	fi
	log "Fetching $binary_name from $url"
	local tmp
	tmp="$(mktemp -d)"
	trap 'rm -rf "$tmp"' RETURN
	local archive="$tmp/asset"
	curl -fsSL "$url" -o "$archive"
	mkdir -p "$LOCAL_BIN"
	case "$url" in
	*.tar.gz | *.tgz)
		tar -xzf "$archive" -C "$tmp"
		;;
	*.zip)
		command -v unzip >/dev/null 2>&1 || die "unzip is required to install $binary_name"
		unzip -q "$archive" -d "$tmp"
		;;
	*.gz)
		gunzip -c "$archive" >"$tmp/$binary_name"
		;;
	*)
		cp "$archive" "$tmp/$binary_name"
		;;
	esac
	local found="$tmp/${inner_path:-$binary_name}"
	if [[ ! -f "$found" ]]; then
		# Case-insensitive: some projects ship e.g. "OmniSharp" for a
		# binary this script installs as lowercase "omnisharp".
		found="$(find "$tmp" -type f -iname "$binary_name" -perm -u+x | head -n1)"
	fi
	if [[ ! -f "$found" ]]; then
		found="$(find "$tmp" -type f -iname "$binary_name" | head -n1)"
	fi
	[[ -f "$found" ]] || {
		warn "Extracted $binary_name but couldn't locate the binary inside the archive — install it manually."
		return 1
	}
	install -m 755 "$found" "$LOCAL_BIN/$binary_name"
	log "Installed $LOCAL_BIN/$binary_name"
}

lazygit_arch() {
	# lazygit's own release naming: lazygit_<ver>_linux_<x86_64|arm64>.tar.gz
	case "$ARCH" in
	x86_64 | amd64) echo "x86_64" ;;
	arm64 | aarch64) echo "arm64" ;;
	*) echo "$ARCH" ;;
	esac
}

tree_sitter_arch() {
	# tree-sitter's own release naming: tree-sitter-linux-<x64|arm64>.gz
	case "$ARCH" in
	x86_64 | amd64) echo "x64" ;;
	arm64 | aarch64) echo "arm64" ;;
	*) echo "$ARCH" ;;
	esac
}

# ---------------------------------------------------------------------------
# Core requirements
# ---------------------------------------------------------------------------
install_nerd_font() {
	[[ "$SKIP_FONT" -eq 1 ]] && return 0
	log "Installing JetBrainsMono Nerd Font"
	case "$PM" in
	brew)
		brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null ||
			warn "Font cask install failed — see https://www.nerdfonts.com/font-downloads"
		;;
	apt | dnf | pacman)
		if command -v pacman >/dev/null 2>&1 && [[ "$PM" == "pacman" ]]; then
			sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd ||
				warn "Pacman font package failed — see https://www.nerdfonts.com/font-downloads"
			return 0
		fi
		local font_dir="$HOME/.local/share/fonts"
		mkdir -p "$font_dir"
		local tmp
		tmp="$(mktemp -d)"
		curl -fsSL -o "$tmp/font.zip" \
			"https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
		unzip -q "$tmp/font.zip" -d "$font_dir"
		rm -rf "$tmp"
		command -v fc-cache >/dev/null 2>&1 && fc-cache -f "$font_dir" >/dev/null 2>&1
		;;
	esac
}

install_core_macos() {
	brew install neovim git ripgrep fd lazygit tree-sitter universal-ctags
}

install_core_debianlike() {
	sudo apt update
	sudo apt install -y git ripgrep fd-find universal-ctags build-essential curl unzip

	if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
		mkdir -p "$LOCAL_BIN"
		ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"
		log "Symlinked fdfind -> $LOCAL_BIN/fd"
	fi

	local nvim_ok=0
	if command -v nvim >/dev/null 2>&1; then
		local ver major minor
		ver="$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)"
		major="${ver%%.*}"
		minor="${ver#*.}"
		# Compare major.minor as integers, not as a decimal (0.9 > 0.11
		# numerically even though v0.9 predates v0.11).
		if [[ -n "$major" && -n "$minor" ]] && ((major > 0 || minor >= 11)); then
			nvim_ok=1
		fi
	fi
	if [[ "$nvim_ok" -eq 0 ]]; then
		if [[ "$DISTRO" == "ubuntu" ]] && command -v add-apt-repository >/dev/null 2>&1; then
			log "apt's neovim is too old (or missing) — adding the Neovim PPA"
			sudo add-apt-repository -y ppa:neovim-ppa/unstable
			sudo apt update
			sudo apt install -y neovim
		else
			log "Installing current Neovim via AppImage to $LOCAL_BIN/nvim"
			mkdir -p "$LOCAL_BIN"
			curl -fsSL -o "$LOCAL_BIN/nvim" \
				"https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
			chmod u+x "$LOCAL_BIN/nvim"
		fi
	fi

	install_release_binary "jesseduffield/lazygit" "lazygit_.*_linux_$(lazygit_arch)\.tar\.gz" lazygit
	install_release_binary "tree-sitter/tree-sitter" "tree-sitter-linux-$(tree_sitter_arch)\.gz" tree-sitter
}

install_core_fedora() {
	sudo dnf install -y neovim git ripgrep fd-find ctags gcc make curl unzip
	install_release_binary "jesseduffield/lazygit" "lazygit_.*_linux_$(lazygit_arch)\.tar\.gz" lazygit
	install_release_binary "tree-sitter/tree-sitter" "tree-sitter-linux-$(tree_sitter_arch)\.gz" tree-sitter
}

install_core_arch() {
	sudo pacman -S --needed neovim git ripgrep fd lazygit tree-sitter tree-sitter-cli ctags base-devel
}

install_core() {
	log "Installing core requirements"
	case "$PM" in
	brew) install_core_macos ;;
	apt) install_core_debianlike ;;
	dnf) install_core_fedora ;;
	pacman) install_core_arch ;;
	esac
	install_nerd_font
	export PATH="$LOCAL_BIN:$PATH"
}

# ---------------------------------------------------------------------------
# Language runtimes — see docs/REQUIREMENTS.md#language-runtimes
# ---------------------------------------------------------------------------
install_language() {
	local lang="$1"
	log "Installing runtime: $lang"
	case "$PM:$lang" in
	brew:go) brew install go ;;
	brew:rust) brew install rustup ;;
	brew:python) brew install python ;;
	brew:node) brew install node ;;
	brew:java) brew install openjdk maven ;;
	brew:clang) xcode-select --install 2>/dev/null || true ;;
	brew:dotnet) brew install dotnet ;;
	brew:kotlin) brew install kotlin ;;
	brew:php) brew install php composer ;;
	brew:ruby) brew install ruby ;;
	brew:terraform) brew install terraform ;;
	brew:dart) brew install dart-sdk ;;
	brew:arduino) brew install arduino-cli ;;
	brew:scala) brew install sbt ;;
	brew:latex) brew install --cask mactex-no-gui ;;

	apt:go) sudo apt install -y golang-go ;;
	apt:rust) curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y ;;
	apt:python) sudo apt install -y python3 python3-pip ;;
	apt:node) sudo apt install -y nodejs npm ;;
	apt:java) sudo apt install -y openjdk-21-jdk maven ;;
	apt:clang) sudo apt install -y clang ;;
	apt:dotnet) warn "No apt one-liner for .NET SDK — see docs/INSTALL.md#language-runtimes-by-package-manager" ;;
	apt:kotlin) install_release_binary "JetBrains/kotlin" "kotlin-compiler.*\.zip" kotlinc || warn "Install manually: https://kotlinlang.org/docs/command-line.html" ;;
	apt:php) sudo apt install -y php composer ;;
	apt:ruby) sudo apt install -y ruby-full ;;
	apt:terraform) warn "No apt one-liner for Terraform — see docs/INSTALL.md#language-runtimes-by-package-manager" ;;
	apt:dart) warn "No apt one-liner for Dart — see https://dart.dev/get-dart" ;;
	apt:arduino) install_release_binary "arduino/arduino-cli" "arduino-cli_.*Linux_64bit\.tar\.gz" arduino-cli ;;
	apt:scala) warn "No apt one-liner for sbt — see https://www.scala-sbt.org/download" ;;
	apt:latex) sudo apt install -y texlive-full ;;

	dnf:go) sudo dnf install -y golang ;;
	dnf:rust) curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y ;;
	dnf:python) sudo dnf install -y python3 python3-pip ;;
	dnf:node) sudo dnf install -y nodejs ;;
	dnf:java) sudo dnf install -y java-21-openjdk maven ;;
	dnf:clang) sudo dnf install -y clang ;;
	dnf:dotnet) sudo dnf install -y dotnet-sdk-8.0 ;;
	dnf:kotlin) install_release_binary "JetBrains/kotlin" "kotlin-compiler.*\.zip" kotlinc || warn "Install manually: https://kotlinlang.org/docs/command-line.html" ;;
	dnf:php) sudo dnf install -y php composer ;;
	dnf:ruby) sudo dnf install -y ruby ;;
	dnf:terraform) sudo dnf install -y terraform ;;
	dnf:dart) warn "No dnf one-liner for Dart — see https://dart.dev/get-dart" ;;
	dnf:arduino) install_release_binary "arduino/arduino-cli" "arduino-cli_.*Linux_64bit\.tar\.gz" arduino-cli ;;
	dnf:scala) warn "No dnf one-liner for sbt — see https://www.scala-sbt.org/download" ;;
	dnf:latex) sudo dnf install -y texlive-scheme-full ;;

	pacman:go) sudo pacman -S --needed go ;;
	pacman:rust) sudo pacman -S --needed rustup ;;
	pacman:python) sudo pacman -S --needed python python-pip ;;
	pacman:node) sudo pacman -S --needed nodejs npm ;;
	pacman:java) sudo pacman -S --needed jdk-openjdk maven ;;
	pacman:clang) sudo pacman -S --needed clang ;;
	pacman:dotnet) sudo pacman -S --needed dotnet-sdk ;;
	pacman:kotlin) sudo pacman -S --needed kotlin ;;
	pacman:php) sudo pacman -S --needed php composer ;;
	pacman:ruby) sudo pacman -S --needed ruby ;;
	pacman:terraform) sudo pacman -S --needed terraform ;;
	pacman:dart) warn "Dart is AUR-only — install with yay/paru: yay -S dart" ;;
	pacman:arduino) warn "arduino-cli is AUR-only — install with yay/paru: yay -S arduino-cli" ;;
	pacman:scala) sudo pacman -S --needed sbt ;;
	pacman:latex) sudo pacman -S --needed texlive-most ;;

	*) warn "Don't know how to install '$lang' on $PM — see docs/REQUIREMENTS.md#language-runtimes" ;;
	esac
}

ALL_LANGUAGES="go rust python node java clang dotnet kotlin php ruby terraform dart arduino scala latex"

prompt_languages() {
	[[ "$ASSUME_YES" -eq 1 ]] && return 0
	echo
	echo "Which language runtimes do you want installed? ($ALL_LANGUAGES)"
	read -r -p "Comma-separated, 'all', or leave empty to skip: " LANGUAGES
}

install_languages() {
	[[ -z "$LANGUAGES" ]] && return 0
	local list="$LANGUAGES"
	[[ "$list" == "all" ]] && list="${ALL_LANGUAGES// /,}"
	local IFS=,
	for lang in $list; do
		lang="$(echo "$lang" | xargs)"
		[[ -z "$lang" ]] && continue
		if [[ " $ALL_LANGUAGES " == *" $lang "* ]]; then
			install_language "$lang"
		else
			warn "Unknown language '$lang' — skipping. Known: $ALL_LANGUAGES"
		fi
	done
}

# ---------------------------------------------------------------------------
# OmniSharp — not Mason-managed, servers.lua expects it at ~/.local/bin/omnisharp
# ---------------------------------------------------------------------------
install_omnisharp() {
	[[ "$SKIP_OMNISHARP" -eq 1 ]] && return 0
	case ":$LANGUAGES:" in
	*:dotnet:* | *:all:* ) ;;
	*) return 0 ;;
	esac
	log "Fetching OmniSharp (not Mason-managed)"
	local pattern
	case "$OS:$ARCH" in
	Darwin:arm64) pattern="omnisharp-osx-arm64.*\.tar\.gz" ;;
	Darwin:x86_64) pattern="omnisharp-osx-x64.*\.tar\.gz" ;;
	Linux:x86_64) pattern="omnisharp-linux-x64.*\.tar\.gz" ;;
	Linux:aarch64 | Linux:arm64) pattern="omnisharp-linux-arm64.*\.tar\.gz" ;;
	*)
		warn "No known OmniSharp asset for $OS/$ARCH — see docs/REQUIREMENTS.md#manual-setup-omnisharp"
		return 0
		;;
	esac
	install_release_binary "OmniSharp/omnisharp-roslyn" "$pattern" omnisharp ||
		warn "OmniSharp fetch failed — see docs/REQUIREMENTS.md#manual-setup-omnisharp"
}

# ---------------------------------------------------------------------------
# Backup, clone, prep dirs
# ---------------------------------------------------------------------------
backup_existing() {
	if [[ -d "$CONFIG_DIR" ]]; then
		local backup
		backup="$CONFIG_DIR.bak.$(date +%s)"
		log "Existing config found — moving to $backup"
		mv "$CONFIG_DIR" "$backup"
	fi
	if [[ -d "$DATA_DIR" ]]; then
		mv "$DATA_DIR" "$DATA_DIR.bak.$(date +%s)"
	fi
}

clone_and_prep() {
	log "Cloning $REPO_URL -> $CONFIG_DIR"
	git clone "$REPO_URL" "$CONFIG_DIR"
	mkdir -p "$HOME/.logs/nvim/backup" "$HOME/.logs/nvim/swap" "$HOME/.logs/nvim/undo"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
	install_core

	if [[ -z "$LANGUAGES" ]]; then
		prompt_languages
	fi
	install_languages
	install_omnisharp

	backup_existing
	clone_and_prep

	log "Done. Launching nvim — lazy.nvim + Mason install plugins/LSP servers automatically."
	log "Run :Mason and :checkhealth once it's up to confirm everything installed cleanly."
	exec nvim
}

main "$@"
