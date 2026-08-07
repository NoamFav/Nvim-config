return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod", "gowork", "gotmpl" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()',
	opts = {
		lsp_cfg = false,
		lsp_inlay_hints = { enable = false },
		lsp_keymaps = false,
		trouble = true,
		luasnip = true,
		dap_debug = true,
		dap_debug_gui = true,
	},
	config = function(_, opts)
		require("go").setup(opts)
	end,
}
