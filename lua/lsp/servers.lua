-- lua/lsp/servers.lua
-- Central place to declare server lists and per-server configs
-- Neovim 0.11+ native LSP style: vim.lsp.config(...) + root_markers

local M = {}

M.get_server_list = function()
	return {
		-- core
		"jdtls",
		"pyright",
		"rust_analyzer",
		"clangd",
		"gopls",
		"lua_ls",

		-- web / js
		"ts_ls",
		"eslint",
		"html",
		"emmet_ls",
		"tailwindcss",
		"jsonls",
		"svelte",
		"graphql",

		-- misc langs & tools
		"bashls",
		"dockerls",
		"vimls",
		"yamlls",
		"lemminx",
		"marksman",
		"ltex",
		"phpactor",
		"solargraph",
		"terraformls",
		"sqlls",
		"perlnavigator",
		"kotlin_language_server",
		"arduino_language_server",
	}
end

M.setup_server_configs = function()
	---------------------------------------------------------------------------
	-- Minimal/no-op configs (let defaults do their thing)
	---------------------------------------------------------------------------
	vim.lsp.config("ts_ls", {})
	vim.lsp.config("tailwindcss", {})

	---------------------------------------------------------------------------
	-- Java (JDTLS)
	-- NOTE: no `require("jdtls.setup")` and no `root_dir` callback.
	---------------------------------------------------------------------------
	vim.lsp.config("jdtls", {
		cmd = { "jdtls" },
		filetypes = { "java" },
		root_markers = {
			".git",
			"mvnw",
			"pom.xml",
			"gradlew",
			"build.gradle",
			"settings.gradle",
		},
	})

	---------------------------------------------------------------------------
	-- Python
	---------------------------------------------------------------------------
	vim.lsp.config("pyright", {
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"setup.cfg",
			"setup.py",
			"requirements.txt",
			".git",
		},
	})

	---------------------------------------------------------------------------
	-- C# / Unity (OmniSharp)
	-- Keep your custom cmd/settings; just provide root_markers.
	---------------------------------------------------------------------------
	local unity_solution = vim.fn.expand("~/Neoware/ShadowedHunterMetroidvania/ShadowedHunterMetroidvania.sln")
	vim.lsp.config("omnisharp", {
		cmd = {
			vim.fn.expand("~/.local/bin/omnisharp"),
			"--languageserver",
			"--solution-path=" .. unity_solution,
			"--hostPID",
			tostring(vim.fn.getpid()),
		},
		filetypes = { "cs", "vb" },
		root_markers = {
			"*.sln",
			"*.csproj",
			"Assets",
			"Packages/manifest.json",
			".git",
		},
		handlers = {
			["textDocument/definition"] = function(...)
				local ok, extended = pcall(require, "omnisharp_extended")
				return ok and extended.handler(...) or vim.lsp.handlers["textDocument/definition"](...)
			end,
		},
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

	---------------------------------------------------------------------------
	-- Kotlin
	---------------------------------------------------------------------------
	vim.lsp.config("kotlin_language_server", {
		cmd = { "kotlin-language-server" },
		filetypes = { "kotlin" },
		root_markers = {
			"build.gradle",
			"settings.gradle",
			"pom.xml",
			".git",
		},
	})

	---------------------------------------------------------------------------
	-- Swift
	---------------------------------------------------------------------------
	vim.lsp.config("sourcekit", {
		cmd = { "xcrun", "sourcekit-lsp" },
		filetypes = { "swift" },
		root_markers = { "Package.swift", ".git" },
	})

	---------------------------------------------------------------------------
	-- Dart
	---------------------------------------------------------------------------
	vim.lsp.config("dartls", {
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		root_markers = { "pubspec.yaml", ".git" },
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

	---------------------------------------------------------------------------
	-- Scala (Metals)
	---------------------------------------------------------------------------
	vim.lsp.config("metals", {
		filetypes = { "scala", "sbt" },
		root_markers = { "build.sbt", "build.sc", ".git" },
		settings = {
			metals = {
				showImplicitArguments = true,
				superMethodLensesEnabled = true,
				showInferredType = true,
			},
		},
	})

	---------------------------------------------------------------------------
	-- SQL
	---------------------------------------------------------------------------
	vim.lsp.config("sqlls", {
		root_markers = { ".sql_project", ".git" },
	})

	---------------------------------------------------------------------------
	-- Perl
	---------------------------------------------------------------------------
	vim.lsp.config("perlnavigator", {
		root_markers = { ".git" },
	})

	---------------------------------------------------------------------------
	-- Arduino
	---------------------------------------------------------------------------
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
		root_markers = { ".git" }, -- adjust to your sketch layout if needed
	})
end

return M
