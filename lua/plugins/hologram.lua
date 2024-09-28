return {
  'edluffy/hologram.nvim',
  config = function()
    require('hologram').setup{
      auto_display = true  -- Automatically display images when opening image files
    }
  end
}
