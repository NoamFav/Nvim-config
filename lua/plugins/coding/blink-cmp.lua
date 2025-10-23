-- Keep your existing blink-cmp.lua content here
-- Just ensure it returns a proper plugin spec
return {
	"saghen/blink.cmp",
	enabled = true,
	event = "InsertEnter",
	dependencies = {
		"moyiz/blink-emoji.nvim",
		"Kaiser-Yang/blink-cmp-dictionary",
		"L3MON4D3/LuaSnip",
	},
	-- ... rest of your blink-cmp config
}
