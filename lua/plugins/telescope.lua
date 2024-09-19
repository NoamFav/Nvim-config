  -- Fuzzy Finder - Telescope
return { 'nvim-telescope/telescope.nvim',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
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


