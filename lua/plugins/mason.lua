-- lua/plugins/mason.lua
return {
	---------------------------------------------------------------------------
	-- Core LSP defaults (new API)
	---------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local caps = require("blink.cmp").get_lsp_capabilities()

			-- Apply shared defaults to all servers
			vim.lsp.config("*", {
				capabilities = caps,
				on_attach = function(_, bufnr)
					-- Keep your old buffer-local setting
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				end,
			})

			-- === Per-server overrides / custom configs (define only; enabling happens later) ===

			-- TypeScript
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("tailwindcss", {})
			-- Java (JDTLS)
			vim.lsp.config("jdtls", {
				cmd = { "jdtls" },
				root_dir = function(fname)
					return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }, fname)
				end,
				settings = {
					java = {
						contentProvider = { preferred = "fernflower" },
					},
				},
				on_attach = function(_, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				end,
			})

			-- Python (pyright)
			vim.lsp.config("pyright", {
				root_dir = function(fname)
					local util = require("lspconfig.util")
					return util.find_git_ancestor(fname)
						or util.root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git")(fname)
						or util.path.dirname(fname)
				end,
			})

			-- C# / Unity (OmniSharp)
			local unity_project_path = vim.fn.expand("~/Neoware/ShadowedHunterMetroidvania")
			local solution_path = unity_project_path .. "/ShadowedHunterMetroidvania.sln"

			vim.lsp.config("omnisharp", {
				on_attach = function(_, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				end,
				handlers = {
					["textDocument/definition"] = function(...)
						local ok, extended = pcall(require, "omnisharp_extended")
						return ok and extended.handler(...) or vim.lsp.handlers["textDocument/definition"](...)
					end,
				},
				cmd = {
					vim.fn.expand("~/.local/bin/omnisharp"),
					"--languageserver",
					"--solution-path=" .. solution_path,
					"--hostPID",
					tostring(vim.fn.getpid()),
				},
				root_dir = function(fname)
					local util = require("lspconfig").util
					local unity_root =
						util.root_pattern("Assembly-CSharp.csproj", "*.sln", "Assets", "Packages/manifest.json")(fname)
					if unity_root then
						return unity_root
					end
					return util.root_pattern("*.sln", "*.csproj", ".git")(fname) or util.path.dirname(fname)
				end,
				filetypes = { "cs", "vb" },
				init_options = {
					enableDecompilationSupport = true,
					useEditorConfig = true,
					enableMsBuildLoadProjectsOnDemand = true,
					enableAnalyzersSupport = true,
					enableImportCompletion = true,
					maxProjectResults = 250,
					enablePackageRestore = true,
					sdk = { name = "Microsoft.NET.Sdk", version = "6.0.0" },
				},
				settings = {
					omnisharp = {
						useModernNet = false,
						enableMsBuildLoadProjectsOnDemand = true,
						enableRoslynAnalyzers = true,
						enableEditorConfigSupport = true,
						enableImportCompletion = true,
						enableAsyncCompletion = true,
						projectLoadTimeout = 120,
						useGlobalMono = "always",
						monoPath = "/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono",
					},
				},
			})

			-- Kotlin
			vim.lsp.config("kotlin_language_server", {
				cmd = { "kotlin-language-server" },
				root_dir = require("lspconfig").util.root_pattern("build.gradle", "settings.gradle", ".git"),
			})

			-- Swift
			vim.lsp.config("sourcekit", {
				cmd = { "xcrun", "sourcekit-lsp" },
				filetypes = { "swift" },
				root_dir = require("lspconfig").util.root_pattern("Package.swift", ".git"),
			})

			-- Dart
			vim.lsp.config("dartls", {
				cmd = { "dart", "language-server", "--protocol=lsp" },
				filetypes = { "dart" },
				root_dir = function(fname)
					local util = require("lspconfig").util
					return util.root_pattern("pubspec.yaml", ".git")(fname) or util.path.dirname(fname)
				end,
				init_options = {
					closingLabels = true,
					flutterOutline = true,
					onlyAnalyzeProjectsWithOpenFiles = true,
					outline = true,
					suggestFromUnimportedLibraries = true,
				},
				settings = { dart = { completeFunctionCalls = true, showTodos = true } },
			})

			-- Scala (Metals)
			vim.lsp.config("metals", {
				root_dir = function(fname)
					local util = require("lspconfig").util
					return util.root_pattern("build.sbt", "build.sc", ".git")(fname) or util.path.dirname(fname)
				end,
				settings = {
					metals = {
						showImplicitArguments = true,
						superMethodLensesEnabled = true,
						showInferredType = true,
					},
				},
			})

			-- SQL
			vim.lsp.config("sqlls", {
				root_dir = function(fname)
					local util = require("lspconfig").util
					return util.root_pattern(".sql_project", ".git")(fname) or util.path.dirname(fname)
				end,
			})

			-- Perl
			vim.lsp.config("perlnavigator", {
				root_dir = require("lspconfig").util.root_pattern(".git", "."),
			})

			-- Arduino
			vim.lsp.config("arduino_language_server", {
				cmd = {
					"arduino-language-server",
					"-cli",
					"arduino-cli",
					"-cli-config",
					vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
					"-fqbn",
					"adafruit:samd:adafruit_feather_m0",
				},
				filetypes = { "arduino", "ino" },
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Mason core
	---------------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	---------------------------------------------------------------------------
	-- Mason-LSPConfig (install & enable servers)
	---------------------------------------------------------------------------
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function()
			local servers = {
				-- Language Servers
				"jdtls", -- Java
				"pyright", -- Python
				"rust_analyzer", -- Rust
				"clangd", -- C/C++
				"gopls", -- Go
				"emmet_ls", -- HTML/CSS
				"html", -- HTML
				"tailwindcss", -- Tailwind CSS
				"jsonls", -- JSON
				"solargraph", -- Ruby
				"sqlls", -- SQL
				"yamlls", -- YAML
				"bashls", -- Bash
				"dockerls", -- Docker
				"elixirls", -- Elixir
				"vimls", -- Vim
				"lua_ls", -- Lua
				"eslint", -- JavaScript/TypeScript
				"graphql", -- GraphQL
				"phpactor", -- PHP
				"perlnavigator", -- Perl
				"terraformls", -- Terraform
				"hls", -- Haskell
				"kotlin_language_server",
				"marksman", -- Markdown
				"svelte", -- Svelte
				"lemminx", -- XML
				"ltex", -- LaTeX
				"ts_ls", -- TypeScript
				"arduino_language_server",
				-- note: tailwindcss listed once
			}

			return {
				ensure_installed = servers,
				-- We will explicitly enable after setup to avoid deprecated .setup calls
				-- (mason-lspconfig can do automatic enabling in newer versions, but we keep it explicit here)
				-- automatic_installation = true, -- optional
				handlers = {},
				_servers_to_enable = servers, -- pass through for our config() below
			}
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup({
				ensure_installed = opts.ensure_installed,
				-- automatic_installation = true, -- enable if you want Mason to auto-install missing servers
			})

			-- Explicitly enable all known servers (safe if already enabled)
			-- Servers with custom config defined above will use those configs.
			for _, name in ipairs(opts._servers_to_enable or {}) do
				pcall(vim.lsp.enable, name)
			end
		end,
	},

	---------------------------------------------------------------------------
	-- UI sugar for LSP
	---------------------------------------------------------------------------
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = true,
					sign = false,
					virtual_text = true,
				},
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Extra tools via Mason
	---------------------------------------------------------------------------
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd", -- JS/TS/HTML/CSS/JSON/YAML/MD
					"black", -- Python
					"isort", -- Python imports
					"stylua", -- Lua
					"clang-format", -- C/C++
					"csharpier", -- C#
					"google-java-format",
					"ktlint", -- Kotlin
					"shfmt", -- Shell
					"beautysh", -- Shell (alt)
					"rustywind", -- Tailwind class sorter
					"gofumpt", -- Go
					"sqlfmt", -- SQL
					"xmlformatter", -- XML
					"latexindent", -- LaTeX
				},
				auto_update = true,
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Formatter (unchanged)
	---------------------------------------------------------------------------
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					javascript = { require("formatter.filetypes.javascript").prettier },
					typescript = { require("formatter.filetypes.javascript").prettier },
					javascriptreact = { require("formatter.filetypes.javascript").prettier },
					typescriptreact = { require("formatter.filetypes.typescript").prettier },
					python = { require("formatter.filetypes.python").black },
					lua = { require("formatter.filetypes.lua").stylua },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					c = { require("formatter.filetypes.c").clangformat },
					cs = {
						function()
							return { exe = "dotnet-csharpier", args = { "--write-stdout" }, stdin = true }
						end,
					},
					java = { require("formatter.filetypes.java").google_java_format },
					sh = { require("formatter.filetypes.sh").shfmt },
					rust = { require("formatter.filetypes.rust").rustfmt },
					go = { require("formatter.filetypes.go").gofmt },
					html = { require("formatter.filetypes.html").prettier },
					css = { require("formatter.filetypes.css").prettier },
					json = { require("formatter.filetypes.json").prettier },
					yaml = { require("formatter.filetypes.yaml").prettier },
					toml = { require("formatter.filetypes.toml").prettier },
					markdown = { require("formatter.filetypes.markdown").prettier },
					sql = {
						function()
							return { exe = "sqlfmt", args = { "-" }, stdin = true }
						end,
					},
					xml = {
						function()
							return { exe = "xmlformatter", args = { "-" }, stdin = true }
						end,
					},
					latex = {
						function()
							return { exe = "latexindent", args = { "-" }, stdin = true }
						end,
					},
					dockerfile = {
						function()
							return {
								exe = "dockerfilelint",
								args = { vim.api.nvim_buf_get_name(0) },
								stdin = true,
							}
						end,
					},
					arduino = {
						function()
							return {
								exe = "clang-format",
								args = { "--assume-filename=sketch.ino" },
								stdin = true,
							}
						end,
					},
				},
			})

			-- Autoformat on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				command = "FormatWrite",
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Treesitter (your special-case "turtle" from before)
	---------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "turtle" },
				highlight = { enable = true },
			})
		end,
	},
}
