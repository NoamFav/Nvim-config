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
