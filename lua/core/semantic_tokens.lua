-- Cross-language LSP semantic-token styling.
--
-- Any language server that emits standard semantic tokens (clangd, rust-analyzer,
-- gopls, lua_ls, ts_ls, pyright, …) gets a consistent, pretty treatment here.
--
-- Two techniques:
--   * TYPE groups (@lsp.type.*)      -> linked/recoloured to a matching
--                                       treesitter group (they ARE the token's
--                                       primary colour).
--   * MODIFIER groups (@lsp.mod.* /  -> style only (italic/bold/underline/
--     @lsp.typemod.*.<mod>)             strikethrough). Neovim layers these on
--                                       top of the base type colour, so the
--                                       language's palette is preserved and we
--                                       just add emphasis.
--
-- Parameters are deliberately untouched: hlargs owns those (see lang/c.lua).

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
	-------------------------------------------------------------------------
	-- Universal type roles — colour them like the equivalent treesitter group
	-------------------------------------------------------------------------
	link("@lsp.type.property", "@variable.member") -- struct/obj fields (C, Go, Rust, TS…)
	link("@lsp.type.namespace", "@module") -- packages / modules / namespaces
	link("@lsp.type.enumMember", "@constant") -- enum variants
	link("@lsp.type.decorator", "@attribute") -- @decorators / #[attrs]
	based_on("@lsp.type.macro", "@constant.macro", { bold = true }) -- C / Rust macros

	-------------------------------------------------------------------------
	-- Universal modifier roles — STYLE ONLY, layered over the base colour
	-------------------------------------------------------------------------
	set(0, "@lsp.typemod.variable.readonly", { italic = true }) -- const / final / readonly
	set(0, "@lsp.typemod.property.readonly", { italic = true })
	set(0, "@lsp.typemod.function.defaultLibrary", { italic = true }) -- stdlib fns (printf, print, fmt.*)
	set(0, "@lsp.typemod.variable.defaultLibrary", { italic = true }) -- stdlib vars/consts
	based_on("@lsp.mod.deprecated", "@comment", { strikethrough = true }) -- deprecated → greyed + struck

	-------------------------------------------------------------------------
	-- Rust (rust-analyzer has the richest token set) — make it sing
	-------------------------------------------------------------------------
	based_on("@lsp.type.lifetime", "@comment", { italic = true }) -- 'a lifetimes
	link("@lsp.type.selfKeyword", "@variable.builtin") -- self
	link("@lsp.type.builtinType", "@type.builtin") -- i32, usize, bool…
	link("@lsp.type.typeAlias", "@type")
	link("@lsp.type.formatSpecifier", "@punctuation.special") -- {} inside format!()
	link("@lsp.type.derive", "@attribute") -- #[derive(...)]
	set(0, "@lsp.typemod.variable.mutable", { underline = true }) -- `mut` bindings underlined
end

function M.setup()
	apply()
	-- Re-apply after any colourscheme switch (highlights get reset)
	vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
end

return M
