return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		-- 42 piscine boilerplate (see lua/snippets/fortytwo.lua)
		local ok, fortytwo = pcall(require, "snippets.fortytwo")
		if ok then
			ls.add_snippets("c", fortytwo.c)
			ls.add_snippets("cpp", fortytwo.c)
			ls.add_snippets("make", fortytwo.make)
		end
	end,
}
