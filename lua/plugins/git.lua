-- Git configuration file
return {
  -- Git integration via Fugitive
  {
    'tpope/vim-fugitive',
    config = function()
      -- Fugitive doesn't need much configuration, but you can add keymaps here
      -- Example keymap for opening Git status
      vim.api.nvim_set_keymap('n', '<leader>gg', ':G<CR>', { noremap = true, silent = true })
    end
  },

  -- Git blame annotations
  {
    'f-person/git-blame.nvim',
    config = function()
      -- Enable git blame
      vim.g.gitblame_enabled = 1
      -- Customizing the blame format
      vim.g.gitblame_message_template = '<author> • <date> • <summary>'
    end
  },

  -- Git diff viewer
  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('diffview').setup {
        -- Example config: auto open diff view when committing
        hooks = {
          diff_buf_read = function()
            vim.opt_local.wrap = false
            vim.opt_local.list = false
          end,
        }
      }
    end
  },

  -- Git conflict markers
  {
    'tanvirtin/vgit.nvim',
    config = function()
      require('vgit').setup {
        settings = {
          live_blame = {
            enabled = true,
          },
          scene = {
            diff_preference = 'split',
          },
          diff_strategy = 'index',
        },
      }
    end
  },

  -- Git messenger for commit messages
  {
    'rhysd/git-messenger.vim',
    config = function()
      -- Use floating window for commit messages
      vim.api.nvim_set_keymap('n', '<leader>gm', ':GitMessenger<CR>', { noremap = true, silent = true })
    end
  },

  { 'lewis6991/gitsigns.nvim',
dependencies = { 'nvim-lua/plenary.nvim' },
config = function()
	require('gitsigns').setup {
  	signs = {
    		add          = { text = '' },  -- Plus sign for added lines
    		change       = { text = '' },  -- Dot icon for changed lines
    		delete       = { text = '✘' },  -- Cross icon for deleted lines
    		topdelete    = { text = '' },  -- Arrow up for topdelete
    		changedelete = { text = '' },  -- Circular arrow for changed + deleted
  },
}
end}
}
