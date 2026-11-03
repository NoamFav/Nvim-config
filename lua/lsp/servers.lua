local M = {}

-- core bug workaround: vim.lsp.inlay_hint's decoration provider can reapply a
-- cached hint position that's past the end of a line (after an edit shortens
-- it, or after another LSP client's stale hints get applied) and crash
-- nvim_buf_set_extmark with "Invalid 'col'/'line': out of range". unfixed
-- upstream as of 0.12.6 — see neovim/neovim#39772 and #36318 (fix PR #36333
-- was never merged) — so clamp it ourselves for just this one namespace.
do
	local inlay_hint_ns = vim.api.nvim_create_namespace("nvim.lsp.inlayhint")
	local set_extmark = vim.api.nvim_buf_set_extmark

	vim.api.nvim_buf_set_extmark = function(bufnr, ns_id, line, col, opts)
		if ns_id == inlay_hint_ns then
			local ok, line_count = pcall(vim.api.nvim_buf_line_count, bufnr)
			if not ok or line >= line_count then
				return -1
			end
			local cur_line = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or ""
			if col > #cur_line then
				col = #cur_line
			end
		end
		return set_extmark(bufnr, ns_id, line, col, opts)
	end
end

M.get_server_list = function()
	-- 42 branch: C, Python, Lua, Bash, Docker + Rust/Go (legacy) + data
	-- formats. Everything else lives on main, home quota here is ~5GB.
	local servers = {
		"pyright",
		"lua_ls",
		"bashls",
		"dockerls",
		-- installed here so mason tracks/updates it, but NOT auto-enabled below —
		-- plugins/lang/rust.lua's rustaceanvim starts and owns this client itself,
		-- see plugins/lsp/mason.lua's automatic_enable.exclude
		"rust_analyzer",
		"gopls",
		"jsonls",
		"yamlls",
		"taplo",
	}
	-- mason's clangd is a full ~400MB clang release; the cluster already ships
	-- one, so only fall back to mason's when there's no system clangd
	-- (setup_server_configs enables the system one itself)
	if vim.fn.executable("clangd") == 0 then
		table.insert(servers, 1, "clangd")
	end
	return servers
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
	-- not in mason's list when the system has clangd, so enable it here
	vim.lsp.enable("clangd")

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
end

return M
