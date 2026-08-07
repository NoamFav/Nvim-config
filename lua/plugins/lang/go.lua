return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod", "gowork", "gotmpl" },
	-- CmdlineEnter so :GoInstallBinaries etc exist the moment I reach for the
	-- command line, without loading this on every buffer just in case
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()',
	opts = {
		-- gopls itself is entirely lsp/servers.lua's problem, not this plugin's
		lsp_cfg = false,
		lsp_inlay_hints = { enable = false }, -- lsp/servers.lua's LspAttach autocmd already does this
		lsp_keymaps = false, -- don't want a second set of gd/gr fighting the ones from snacks.lua
		trouble = true,
		luasnip = true,
		dap_debug = true,
		dap_debug_gui = true,
	},
	config = function(_, opts)
		require("go").setup(opts)
	end,
}
