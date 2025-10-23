return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		vim.g.copilot_enabled = false
		vim.g.copilot_no_tab_map = true
	end,
}
