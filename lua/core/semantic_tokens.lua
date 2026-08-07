-- most colorschemes only bother styling treesitter's @variable/@type/etc groups
-- and leave LSP's @lsp.type.* ones to fall back on nothing, this fixes that
local M = {}

local set = vim.api.nvim_set_hl

-- Copy a treesitter group's colours, then merge in a style bump.
local function based_on(group, base, extra)
	local base_hl = vim.api.nvim_get_hl(0, { name = base, link = false })
	set(0, group, vim.tbl_extend("force", base_hl, extra or {}))
end

local function link(group, target)
	set(0, group, { link = target })
end

local function apply()
	link("@lsp.type.property", "@variable.member")
	link("@lsp.type.namespace", "@module")
	link("@lsp.type.enumMember", "@constant")
	link("@lsp.type.decorator", "@attribute")

	based_on("@lsp.type.macro", "@constant.macro", { bold = true })
	set(0, "@lsp.typemod.variable.readonly", { italic = true })
	set(0, "@lsp.typemod.property.readonly", { italic = true })
	set(0, "@lsp.typemod.function.defaultLibrary", { italic = true })
	set(0, "@lsp.typemod.variable.defaultLibrary", { italic = true })
	based_on("@lsp.mod.deprecated", "@comment", { strikethrough = true })

	based_on("@lsp.type.lifetime", "@comment", { italic = true })
	link("@lsp.type.selfKeyword", "@variable.builtin")
	link("@lsp.type.builtinType", "@type.builtin")
	link("@lsp.type.typeAlias", "@type")
	link("@lsp.type.formatSpecifier", "@punctuation.special")
	link("@lsp.type.derive", "@attribute")
	set(0, "@lsp.typemod.variable.mutable", { underline = true })

	based_on("@lsp.type.interface", "@type", { italic = true })
	link("@lsp.typemod.type.defaultLibrary", "@type.builtin")
	-- gopls tags imported stdlib functions as defaultLibrary same as true builtins,
	-- close enough that they should look the same
	link("@lsp.typemod.function.defaultLibrary.go", "@function.builtin")
	set(0, "@lsp.typemod.variable.readonly.go", { italic = true })
	set(0, "@lsp.typemod.type.pointer", { italic = true })
end

function M.setup()
	apply()
	-- colors reset on every colorscheme switch, so this has to rerun each time
	vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
end

return M
