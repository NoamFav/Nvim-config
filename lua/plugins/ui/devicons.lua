return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		default = true,
		color_icons = true,
		-- default green node icon doesn't tell .env apart from any other file at a glance
		override_by_extension = {
			["env"] = { icon = "", name = "Env" },
		},
	},
}
