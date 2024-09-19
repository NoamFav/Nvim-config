return {
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local highlight = {
          "ColorColumn",
          "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
    exclude = {
        filetypes = { "dashboard", "NvimTree", "alpha" }  -- Add filetypes where you don't want indent guides
    },
}
    end
  }
}
