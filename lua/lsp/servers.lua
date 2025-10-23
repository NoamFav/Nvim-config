-- LSP server configurations
local M = {}

M.get_server_list = function()
	return {
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
		"kotlin_language_server",
		"marksman",
		"svelte",
		"lemminx",
		"ltex",
		"ts_ls",
		"arduino_language_server",
	}
end

M.setup_server_configs = function()
	local lspconfig = require("lspconfig")

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
	})

	-- Python
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
			local util = lspconfig.util
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
		root_dir = lspconfig.util.root_pattern("build.gradle", "settings.gradle", ".git"),
	})

	-- Swift
	vim.lsp.config("sourcekit", {
		cmd = { "xcrun", "sourcekit-lsp" },
		filetypes = { "swift" },
		root_dir = lspconfig.util.root_pattern("Package.swift", ".git"),
	})

	-- Dart
	vim.lsp.config("dartls", {
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		root_dir = function(fname)
			local util = lspconfig.util
			return util.root_pattern("pubspec.yaml", ".git")(fname) or util.path.dirname(fname)
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

	-- Scala (Metals)
	vim.lsp.config("metals", {
		root_dir = function(fname)
			local util = lspconfig.util
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
			local util = lspconfig.util
			return util.root_pattern(".sql_project", ".git")(fname) or util.path.dirname(fname)
		end,
	})

	-- Perl
	vim.lsp.config("perlnavigator", {
		root_dir = lspconfig.util.root_pattern(".git", "."),
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
end

return M
