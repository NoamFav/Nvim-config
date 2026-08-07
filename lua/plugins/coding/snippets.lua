return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp", -- regex-triggered snippets are dead without this
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		-- pcall so a typo'd or missing snippets file doesn't take LuaSnip down with it
		local ok, fortytwo = pcall(require, "snippets.fortytwo")
		if ok then
			ls.add_snippets("c", fortytwo.c)
			ls.add_snippets("cpp", fortytwo.c)
			ls.add_snippets("make", fortytwo.make)
		end
	end,
}
