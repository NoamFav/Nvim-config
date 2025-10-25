local function transparent(group)
	vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
end

-- Global float transparency
transparent("NormalFloat")
transparent("FloatBorder")
transparent("Pmenu")

-- Telescope transparency
transparent("TelescopeNormal")
transparent("TelescopeBorder")
transparent("TelescopePromptNormal")
transparent("TelescopePromptBorder")
transparent("TelescopeResultsNormal")
transparent("TelescopePreviewNormal")
transparent("TelescopePreviewBorder")
transparent("TelescopePromptTitle")
transparent("TelescopeResultsTitle")
transparent("TelescopePreviewTitle")
