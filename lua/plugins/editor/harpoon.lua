return {
	-- default branch is harpoon v1 — mark/ui api, hardcoded 4 slots, not the
	-- newer list-based v2. works fine, never had a reason to migrate
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Harpoon Add File",
		},
		{
			"<leader>h",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Harpoon Menu",
		},
		{
			"<leader>1",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Harpoon File 1",
		},
		{
			"<leader>2",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Harpoon File 2",
		},
		{
			"<leader>3",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Harpoon File 3",
		},
		{
			"<leader>4",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Harpoon File 4",
		},
	},
}
