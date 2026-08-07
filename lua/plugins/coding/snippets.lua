return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp", -- regex-triggered snippets are dead without this
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
