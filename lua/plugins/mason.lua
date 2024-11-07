return {
	{ "neovim/nvim-lspconfig" },
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
					"jdtls",
					"pyright",
					"rust_analyzer",
					"clangd",
					"gopls",
					"emmet_ls",
					"html",
					"tailwindcss",
					"jsonls",
					"solargraph",
					"sqlls",
					"yamlls",
					"bashls",
					"dockerls",
					"elixirls",
					"vimls",
					"lua_ls",
					"eslint",
					"graphql",
					"phpactor",
					"perlnavigator",
					"terraformls",
					"hls",
					"volar",
					"kotlin_language_server",
					"marksman",
					"svelte",
					"lemminx",
					"ltex",
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
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
					python = { require("formatter.filetypes.python").black },
					lua = { require("formatter.filetypes.lua").stylua },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					c = { require("formatter.filetypes.c").clangformat },
					java = { require("formatter.filetypes.java").google_java_format },
					sh = { require("formatter.filetypes.sh").shfmt },
					rust = { require("formatter.filetypes.rust").rustfmt },
					go = { require("formatter.filetypes.go").gofmt },
					html = { require("formatter.filetypes.html").prettier },
					css = { require("formatter.filetypes.css").prettier },
					json = { require("formatter.filetypes.json").prettier },
					yaml = { require("formatter.filetypes.yaml").prettier },
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
