-- lua/lsp/servers.lua
-- Central place to declare server lists and per-server configs
-- Neovim 0.11+ native LSP style: vim.lsp.config(...) + root_markers

local M = {}

M.get_server_list = function()
	return {
		-- 42: C, shell, and just enough Lua to edit this config
		"clangd",
		"bashls",
		"lua_ls",
	}
end

M.setup_server_configs = function()
	---------------------------------------------------------------------------
	-- C / C++ (clangd) — the star of the show
	---------------------------------------------------------------------------
	vim.lsp.config("clangd", {
		cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_markers = { "Makefile", "compile_commands.json", ".clangd", ".git" },
        init_options = {
            fallbackFlags = {"-Wall", "-Wextra"},
        },
	vim.lsp.config("ts_ls", {})
	vim.lsp.config("tailwindcss", {})

	---------------------------------------------------------------------------
	-- Go (gopls) — favourite language, so give it the works.
	-- NOTE: semanticTokens MUST be on for the @lsp.* styling in
	-- core/semantic_tokens.lua to reach Go at all (gopls keeps them off by default).
	---------------------------------------------------------------------------
	vim.lsp.config("gopls", {
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				semanticTokens = true, -- <- unlocks semantic-token styling for Go
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
			},
		},
	})

	-- Turn on inlay hints for Go buffers (kept out of gopls on_attach so the
	-- wildcard on_attach that sets omnifunc still applies).
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			if vim.bo[args.buf].filetype == "go" then
				pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
			end
		end,
	})

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
	-- Shell (bashls)
	---------------------------------------------------------------------------
	vim.lsp.config("bashls", {
		filetypes = { "sh", "bash" },
		root_markers = { ".git" },
	})

	---------------------------------------------------------------------------
	-- Lua — just enough to comfortably edit this config
	---------------------------------------------------------------------------
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
end

return M
