  -- Fuzzy Finder - Telescope
return { 'nvim-telescope/telescope.nvim',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
    defaults = {
        mappings = {
            i = {
                ["<C-o>"] = require('telescope.actions').select_default + require('telescope.actions').center,
                ["<C-s>"] = require('telescope.actions').select_horizontal,
                ["<Tab>"] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_next,
                ["<S-Tab>"] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_previous,
            }
        }
    }
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
        		["<C-u>"] = false,
        		["<C-d>"] = false,
      			},
    		},
        	}
	}
	end
}


