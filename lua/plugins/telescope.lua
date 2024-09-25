  -- Fuzzy Finder - Telescope
  --  
return { 'nvim-telescope/telescope.nvim',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

	require('telescope').setup{
  		defaults = {
    		prompt_prefix = "> ",
    		color_devicons = true,

    		file_ignore_patterns = {
      			"node_modules/.*",
      			"\\.jpg",
      			"\\.jpeg",
      			"\\.png",
      			"\\.svg",
      			"\\.otf",
      			"\\.ttf"
        },
        mappings = {
            i = {
                ["<CR>"] = function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selections = picker:get_multi_selection()

                if vim.tbl_isempty(multi_selections) then
                    actions.select_default(prompt_bufnr)
                else
                    actions.close(prompt_bufnr)  -- Close Telescope first
                    for idx, entry in ipairs(multi_selections) do
                        vim.cmd(string.format("badd %s", entry.value))
                        -- Switch to the first selected file
                        if idx == 1 then
                            vim.cmd(string.format("buffer! %s", entry.value))
                        end
                    end
                end
                end,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
            },
        },
        },
    }
	end
}


