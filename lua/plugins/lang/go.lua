-- Full Go toolkit: :GoRun / :GoTest(Func|File|Pkg), coverage overlay,
-- struct-tag editing (:GoAddTag / :GoRmTag), :GoIfErr, :GoFillStruct,
-- :GoImpl, auto-imports, :GoDoc, and more.
--
-- gopls itself is configured in lua/lsp/servers.lua, so go.nvim is told NOT to
-- touch the LSP (lsp_cfg = false) or the keymaps — it just adds the tooling.
return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua", -- floating UI (coverage, docs, references)
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod", "gowork", "gotmpl" },
	event = { "CmdlineEnter" }, -- so :Go… commands are available from the cmdline too
	build = ':lua require("go.install").update_all_sync()', -- installs gomodifytags, gotests, iferr, impl, dlv…
	opts = {
		lsp_cfg = false, -- gopls is owned by lua/lsp/servers.lua
		lsp_inlay_hints = { enable = false }, -- inlay hints handled in servers.lua
		lsp_keymaps = false, -- keep existing LSP keymaps (snacks/lspsaga)
		trouble = true, -- route lists through trouble.nvim (already installed)
		luasnip = true, -- register gotests snippets with LuaSnip
		dap_debug = true, -- nvim-dap is installed now, let go.nvim wire up dlv
		dap_debug_gui = true,
	},
	config = function(_, opts)
		require("go").setup(opts)
	end,
}
