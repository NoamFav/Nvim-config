  -- File Explorer
return {
    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            -- Plugin setup
            require'nvim-tree'.setup {
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
                sync_root_with_cwd = true,
                git = {
                    enable = true,    -- Enable git integration
                    ignore = false,   -- Show git-ignored files
                },
                renderer = {
                    icons = {
                        glyphs = {
                            default = '',
                            symlink = '',
                            git = {
                                unstaged = "✗",
                                staged = "✓",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "★",
                                deleted = "",
                                ignored = "◌"
                            },
                            folder = {
                                arrow_open = "",
                                arrow_closed = "",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                        },
                    },
                }
            }

            -- Function to toggle focus on NvimTree
            function ToggleNvimTreeFocus()
              local view = require'nvim-tree.view'
              if view.is_visible() then
                if vim.api.nvim_get_current_win() == view.get_winnr() then
                  vim.cmd('wincmd p')  -- Move focus away from NvimTree
                else
                  vim.cmd('wincmd w')  -- Move focus to NvimTree
                end
              else
                vim.cmd('NvimTreeToggle')  -- Open NvimTree if it's not open
              end
            end

            -- Set key mapping within the plugin config to ensure scope is contained
            vim.api.nvim_set_keymap('n', '<C-,>', ':lua ToggleNvimTreeFocus()<CR>', { noremap = true, silent = true })
        end
    }
}
