return {
	{
		"preservim/tagbar",
		config = function()
			-- Define the function to toggle Tagbar focus
			function ToggleTagbarFocus()
				local tagbar_win = vim.fn.bufwinnr("Tagbar")
				if tagbar_win ~= -1 then
					local current_win = vim.fn.winnr()
					if current_win == tagbar_win then
						vim.cmd("wincmd p") -- Move focus away from Tagbar
					else
						vim.cmd(tagbar_win .. "wincmd w") -- Move focus to Tagbar
					end
				else
					vim.cmd("TagbarToggle") -- Toggle Tagbar open or closed
					vim.cmd("wincmd l") -- Move focus to Tagbar if opened
				end
			end

			-- Map the toggle function to a keybinding (adjust as needed)
			vim.api.nvim_set_keymap("n", "<leader>t", ":lua ToggleTagbarFocus()<CR>", { noremap = true, silent = true })
		end,
	},
}
