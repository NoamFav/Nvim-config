return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
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
					"volar", -- Vue
					"kotlin_language_server", -- Kotlin
					"marksman", -- Markdown
					"svelte", -- Svelte
					"lemminx", -- XML
					"ltex", -- LaTeX
					"ts_ls", -- TypeScript
					"tailwindcss", -- Tailwind CSS
				},
				automatic_installation = true,
				auto_install = true,
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = function(client, bufnr)
							local function buf_set_keymap(...)
								vim.api.nvim_buf_set_keymap(bufnr, ...)
							end
							local function buf_set_option(...)
								vim.api.nvim_buf_set_option(bufnr, ...)
							end

							-- Enable completion triggered by <c-x><c-o>
							buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

							-- Other setup like key mappings, etc.
						end,
						capabilities = require("blink.cmp").get_lsp_capabilities(),
					})
				end,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = true, -- Disable the lightbulb to avoid shaking
					sign = false,
					virtual_text = true, -- You can keep virtual text if you prefer
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").ts_ls.setup({
				-- Any specific settings you want to include
			})
			require("lspconfig")["jdtls"].setup({
				cmd = { "jdtls" }, -- Mason will automatically handle the path
				root_dir = function(fname)
					return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }, fname)
				end,
				settings = {
					java = {
						contentProvider = { preferred = "fernflower" },
					},
				},
				on_attach = function(client, bufnr)
					local function buf_set_option(...)
						vim.api.nvim_buf_set_option(bufnr, ...)
					end
					buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				end,
			})
			require("lspconfig").pyright.setup({
				root_dir = function(fname)
					-- Find the git directory or any of the common Python project files
					return require("lspconfig.util").find_git_ancestor(fname)
						or require("lspconfig.util").root_pattern(
							"pyproject.toml",
							"setup.py",
							"requirements.txt",
							".git"
						)(fname)
						or require("lspconfig.util").path.dirname(fname)
				end,
			})
			-- Define the Unity project path
			local unity_project_path = vim.fn.expand("~/Neoware/ShadowedHunterMetroidvania")
			local solution_path = unity_project_path .. "/ShadowedHunterMetroidvania.sln"

			require("lspconfig").omnisharp.setup({
				capabilities = require("blink-cmp").get_lsp_capabilities(),
				on_attach = function(client, bufnr)
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
						local status, extended = pcall(require, "omnisharp_extended")
						if status then
							return extended.handler(...)
						else
							return vim.lsp.handlers["textDocument/definition"](...)
						end
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
					-- First try to find Unity-specific files
					local unity_root = require("lspconfig").util.root_pattern(
						"Assembly-CSharp.csproj",
						"*.sln",
						"Assets",
						"Packages/manifest.json"
					)(fname)

					if unity_root then
						return unity_root
					end

					-- Fallback to standard patterns
					return require("lspconfig").util.root_pattern("*.sln", "*.csproj", ".git")(fname)
						or require("lspconfig").util.path.dirname(fname)
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
					sdk = {
						name = "Microsoft.NET.Sdk",
						version = "6.0.0",
					},
				},
				-- Unity-specific settings
				settings = {
					omnisharp = {
						useModernNet = false, -- Unity typically uses Mono
						enableMsBuildLoadProjectsOnDemand = true,
						enableRoslynAnalyzers = true,
						enableEditorConfigSupport = true,
						enableImportCompletion = true,
						enableAsyncCompletion = true,
						projectLoadTimeout = 120,
						useGlobalMono = "always", -- Force using Mono for Unity projects
						monoPath = "/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono",
					},
				},
			})
			require("lspconfig").kotlin_language_server.setup({
				cmd = { "kotlin-language-server" },
				root_dir = require("lspconfig").util.root_pattern("build.gradle", "settings.gradle", ".git"),
			})
			require("lspconfig").sourcekit.setup({
				cmd = { "xcrun", "sourcekit-lsp" },
				filetypes = { "swift" },
				root_dir = require("lspconfig").util.root_pattern("Package.swift", ".git"),
			})
			require("lspconfig").dartls.setup({
				cmd = { "dart", "language-server", "--protocol=lsp" },
				filetypes = { "dart" },
				root_dir = function(fname)
					return require("lspconfig").util.root_pattern("pubspec.yaml", ".git")(fname)
						or require("lspconfig").util.path.dirname(fname) -- Fallback to file's directory
				end,
				init_options = {
					closingLabels = true,
					flutterOutline = true,
					onlyAnalyzeProjectsWithOpenFiles = true,
					outline = true,
					suggestFromUnimportedLibraries = true,
				},
				settings = {
					dart = {
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			})
			require("lspconfig").metals.setup({
				root_dir = function(fname)
					return require("lspconfig").util.root_pattern("build.sbt", "build.sc", ".git")(fname)
						or require("lspconfig").util.path.dirname(fname) -- Fallback to file's directory
				end,
				settings = {
					metals = {
						showImplicitArguments = true,
						superMethodLensesEnabled = true,
						showInferredType = true,
					},
				},
			})
			require("lspconfig").sqlls.setup({
				root_dir = function(fname)
					return require("lspconfig").util.root_pattern(".sql_project", ".git")(fname)
						or require("lspconfig").util.path.dirname(fname)
				end,
			})
			require("lspconfig").perlnavigator.setup({
				root_dir = require("lspconfig").util.root_pattern(".git", "."), -- Find the git directory or the current directory
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettierd", -- JavaScript, TypeScript, HTML, CSS, JSON, YAML, Markdown
					"black", -- Python
					"isort", -- Python imports sorting
					"stylua", -- Lua
					"clang-format", -- C/C++
					"csharpier", -- C#
					"google-java-format", -- Java
					"ktlint", -- Kotlin
					"shfmt", -- Shell scripts
					"beautysh", -- Alternative Shell formatter
					"rustywind", -- Rust
					"gofumpt", -- Go
					"sqlfmt", -- SQL
					"xmlformatter", -- XML
					"latexindent", -- LaTeX
				},
				auto_update = true,
			})
		end,
	},

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
							return {
								exe = "dotnet-csharpier",
								args = { "--write-stdout" },
								stdin = true,
							}
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
							return {
								exe = "sqlfmt", -- Change to sql-formatter if desired
								args = { "-" },
								stdin = true,
							}
						end,
					},
					xml = {
						function()
							return {
								exe = "xmlformatter",
								args = { "-" },
								stdin = true,
							}
						end,
					},
					latex = {
						function()
							return {
								exe = "latexindent",
								args = { "-" },
								stdin = true,
							}
						end,
					},

					dockerfile = {
						function()
							return {
								exe = "dockerfilelint", -- Replace with docker formatting tool if preferred
								args = { vim.api.nvim_buf_get_name(0) },
								stdin = true,
							}
						end,
					},
				},
			})

			-- Set up autoformatting on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				command = "FormatWrite",
			})
		end,
	},
}
