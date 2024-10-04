  -- Syntax Highlighting & Language Support (Treesitter)
return {
  -- Treesitter with rainbow coloring
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    ensure_installed = "all",
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          custom_captures = {
            -- Capture variables for custom highlights
            ["variable"] = "TSRainbow1", -- Change this to TSRainbow1, TSRainbow2, etc.
         },
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          extended_mode = true, -- Highlight more than just brackets
          max_file_lines = nil, -- No file line limit
        },
        fold = {
          enable = true,
          config = function()
            vim.cmd('set foldmethod=expr')
            vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
            vim.o.foldlevel = 99 -- Automatically unfold everything on startup
          end,
        },
      }
    end,
  },

  -- Rainbow plugin for variable highlighting
  {
    'p00f/nvim-ts-rainbow',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight variables
        },
      }
    end
  },
}

