local M = {}

M.get_server_list = function()
	return {
		-- core
		"jdtls",
		"pyright",
		-- installed here so mason tracks/updates it, but NOT auto-enabled below —
		-- plugins/lang/rust.lua's rustaceanvim starts and owns this client itself,
		-- see plugins/lsp/mason.lua's automatic_enable.exclude
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
	vim.lsp.config("clangd", {
		-- header-insertion=never: it kept guessing wrong and adding headers I didn't ask for
		cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_markers = { "Makefile", "compile_commands.json", ".clangd", ".git" },
		init_options = {
			fallbackFlags = { "-Wall", "-Wextra" },
		},
	})

	-- empty on purpose, mason-lspconfig's defaults are already fine here
	vim.lsp.config("ts_ls", {})
	vim.lsp.config("tailwindcss", {})

	-- Go (gopls)
	vim.lsp.config("gopls", {
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				semanticTokens = true,
				staticcheck = true,
				gofumpt = true,
				usePlaceholders = true,
				completeUnimported = true,
				analyses = {
					unusedparams = true,
					unusedwrite = true,
					nilness = true,
					shadow = true,
					useany = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				-- lets a lone scratch file (e.g. a leetcode.nvim buffer, no go.mod
				-- in sight) skip the "not part of a module" complaints with a
				-- //go:build leetcode tag instead of needing a whole module
				standaloneTags = { "ignore", "leetcode" },
			},
		},
	})

	-- go and rust only, inlay hints everywhere else gets noisy fast
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			if vim.tbl_contains({ "go", "rust" }, vim.bo[args.buf].filetype) then
				pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
			end
		end,
	})

	-- Java (JDTLS)
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

	-- Python
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

	-- Lua
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } }, -- <- fixes “undefined global `vim`”
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = { enable = false },
			},
		},
	})

	-- C# / Unity (OmniSharp) — Unity projects still lean on the old .NET
	-- Framework build, which means mono, when it's around
	local mono_path = vim.fn.exepath("mono")
	vim.lsp.config("omnisharp", {
		cmd = {
			vim.fn.expand("~/.local/bin/omnisharp"),
			"--languageserver",
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
				useGlobalMono = mono_path ~= "" and "always" or "never",
				monoPath = mono_path ~= "" and mono_path or nil,
			},
		},
	})

	-- Kotlin
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

	-- Swift
	-- ships with Xcode, mason doesn't manage this one, so it needs its own enable() call
	vim.lsp.config("sourcekit", {
		cmd = { "xcrun", "sourcekit-lsp" },
		filetypes = { "swift" },
		root_markers = { "Package.swift", "*.xcodeproj", "*.xcworkspace" },
	})
	vim.lsp.enable("sourcekit")

	-- Dart
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

	-- Scala (Metals)
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

	-- SQL
	vim.lsp.config("sqlls", {
		root_markers = { ".sql_project", ".git" },
	})

	-- Perl
	vim.lsp.config("perlnavigator", {
		root_markers = { ".git" },
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
		root_markers = { ".git" }, -- adjust to your sketch layout if needed
	})
end

return M
