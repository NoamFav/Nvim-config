-- C / C++ readability layer.
--   * clangd_extensions — inlay hints + AST view
--   * hlargs           — function parameters get a distinct colour everywhere
--   * semantic tuning  — clangd's semantic tokens styled so const / macros /
--                        libc calls / struct members read at a glance
-- clangd itself is configured natively in lua/lsp/servers.lua.

-- Re-style clangd semantic-token roles. Built off well-coloured treesitter
-- groups (so it survives colourscheme switches + transparency) with an extra
-- style bump. Parameters are intentionally left to hlargs, which owns them.
local function tune_semantic_tokens()
	local function based_on(group, base, extra)
		local base_hl = vim.api.nvim_get_hl(0, { name = base, link = false })
		vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", base_hl, extra or {}))
	end

	-- const-qualified variables: read like constants, slanted
	based_on("@lsp.typemod.variable.readonly", "@constant", { italic = true })
	-- #define macros: macro colour, bold so they pop
	based_on("@lsp.type.macro", "@constant.macro", { bold = true })
	-- libc / stdlib functions (printf, malloc, …): builtin-function colour
	based_on("@lsp.typemod.function.defaultLibrary", "@function.builtin", { italic = true })
	-- struct / union members: keep them consistent with treesitter members
	vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
end

return {
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp", "objc", "objcpp" },
		opts = {
			inlay_hints = {
				inline = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = "<- ",
				other_hints_prefix = "=> ",
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					statement = ";",
					specifier = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
		config = function(_, opts)
			require("clangd_extensions").setup(opts)

			-- Turn on inlay hints for C-family buffers
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					if ft == "c" or ft == "cpp" or ft == "objc" or ft == "objcpp" then
						pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
					end
				end,
			})

			-- Apply semantic-token styling now, and re-apply after any colourscheme change
			tune_semantic_tokens()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = tune_semantic_tokens,
			})
		end,
	},

	{
		"m-demare/hlargs.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			-- hlargs' priority (10000) already beats LSP semantic tokens, so
			-- parameters keep this colour consistently, LSP-attached or not.
			color = "#e0af68", -- tokyonight-ish amber; distinct from vars/globals
			excluded_filetypes = { "sh", "bash", "make", "markdown" },
		},
	},
}
