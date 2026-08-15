return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- pulled from the active colorscheme -- colors_generated when wallpaper
		-- is active, or the real tokyonight-night when that's the fallback
		-- (see init.lua: colors_generated.lua is gitignored/machine-specific)
		local ok_colors, c = pcall(require, "colors_generated")
		if not ok_colors then
			c = require("tokyonight.colors").setup()
		end

		-- StatusLine/StatusLineNC/TabLine/TabLineFill all have a solid bg by default, which is
		-- what paints a full-width dark rectangle behind empty space -- clearing them is what
		-- makes the empty middle show through as transparent. Re-applied on ColorScheme since
		-- a colorscheme switch would otherwise reset these.
		local function clear_fills()
			for _, group in ipairs({ "StatusLine", "StatusLineNC", "TabLine", "TabLineFill", "WinBar", "WinBarNC" }) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
		end
		clear_fills()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_fills })

		-- lualine's own section_separators/component_separators go through a color-transition
		-- codepath meant for filled powerline blocks -- with everything here set to no
		-- background, that logic drops separators unpredictably (confirmed: it silently skips
		-- the one between sections a and b, keeps the one between b and c, for no visible
		-- reason tied to this config). Disabled entirely below; dividers are instead prepended
		-- literally via each component's own `fmt`, which is fully predictable.
		local function divider_fmt(icon)
			return function(str)
				if str == "" then
					return ""
				end
				return "│ " .. (icon and (icon .. " ") or "") .. str
			end
		end

		local mode_colors = {
			normal = c.blue,
			insert = c.green,
			visual = c.magenta,
			replace = c.red,
			command = c.yellow,
			terminal = c.teal,
			inactive = c.comment,
		}

		-- no filled shapes anywhere: "a" is bold colored text (not a pill), everything else is
		-- plain dim text. every section (including x/y/z, which lualine would otherwise mirror
		-- from c/b/a) is explicit so nothing accidentally inherits a color block.
		local function text_hl(color, bold)
			return { bg = "NONE", fg = color, gui = bold and "bold" or nil }
		end
		local neutral = text_hl(c.fg_dark)

		-- fixed accents for the few things that get color, chosen to not collide with any
		-- of the six mode colors above (so nothing here is ever mistaken for a mode change)
		local accents = {
			branch = c.orange,
			lsp = c.cyan,
			encoding = c.magenta2,
			location = c.purple,
			-- c.fg (pale lavender) was too close to the muted default to read as "colored" --
			-- needs an actual saturated hue like the others
			filename = c.blue1,
		}

		-- location (z) is a fixed accent rather than mode-colored; lualine reuses section z's
		-- highlight for the tabline's current tab too (buffers/tabs redirect their "active"
		-- color to section a/z when nothing else is defined for that section), so this one
		-- change colors both the statusline's line:col and the active tab at once
		local function mode_theme(color)
			return {
				a = text_hl(color, true),
				b = neutral,
				c = neutral,
				x = neutral,
				y = neutral,
				z = text_hl(accents.location, true),
			}
		end

		local theme = {
			normal = mode_theme(mode_colors.normal),
			insert = mode_theme(mode_colors.insert),
			visual = mode_theme(mode_colors.visual),
			replace = mode_theme(mode_colors.replace),
			command = mode_theme(mode_colors.command),
			terminal = mode_theme(mode_colors.terminal),
			-- z stays neutral here (not the location accent) so an unfocused window's line:col,
			-- and any tab other than the current one, both read as visually dimmed/inactive
			inactive = {
				a = text_hl(mode_colors.inactive, true),
				b = neutral,
				c = neutral,
				x = neutral,
				y = neutral,
				z = neutral,
			},
		}

		-- error > warn > info > hint, whichever is worst present; component hides itself
		-- entirely (via cond below) when there's nothing to show, so no stray divider lingers
		local function diagnostics_color()
			local d = vim.diagnostic.count(0)
			if (d[vim.diagnostic.severity.ERROR] or 0) > 0 then
				return text_hl(c.red, true)
			elseif (d[vim.diagnostic.severity.WARN] or 0) > 0 then
				return text_hl(c.yellow, true)
			elseif (d[vim.diagnostic.severity.INFO] or 0) > 0 then
				return text_hl(c.blue, true)
			end
			return text_hl(c.teal, true)
		end
		local function has_diagnostics()
			local d = vim.diagnostic.count(0)
			for _, n in pairs(d) do
				if n > 0 then
					return true
				end
			end
			return false
		end

		require("lualine").setup({
			options = {
				theme = theme,
				globalstatus = true,
				disabled_filetypes = { "snacks_dashboard" }, -- the dashboard is its own thing, doesn't need a statusline on top
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				always_divide_middle = true,
				icons_enabled = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						-- "NORMAL" takes up half the statusline, "N" doesn't. first item on the line,
						-- so no leading divider here -- just the nvim logo as a fixed anchor.
						fmt = function(str)
							return " " .. str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						-- icon = "" (not omitted) on purpose: the component falls back to its own
						-- default git-branch glyph whenever `icon` is unset, and that default gets
						-- prepended after fmt runs, landing before the divider instead of after it.
						-- suppressing it here and building the icon manually via divider_fmt keeps
						-- ordering consistent with everything else.
						icon = "",
						fmt = divider_fmt(""),
						color = { fg = accents.branch, gui = "bold" },
					},
					{ "diff", fmt = divider_fmt() },
				},
				lualine_c = {
					{
						"diagnostics",
						cond = has_diagnostics,
						color = diagnostics_color,
						fmt = divider_fmt(),
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
					{
						"filename",
						path = 1,
						-- per-file language icon and color instead of one fixed accent -- e.g. a
						-- Lua file renders in Lua's own blue, Python in Python's, etc. more
						-- interesting than a single static hue, and it's already fetching the icon
						-- from devicons here anyway, so the color comes along for free.
						fmt = function(str)
							if str == "" then
								return ""
							end
							local ok, devicons = pcall(require, "nvim-web-devicons")
							local icon = ok
								and devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
							return "│ " .. (icon and (icon .. " ") or "") .. str
						end,
						color = function()
							local ok, devicons = pcall(require, "nvim-web-devicons")
							if ok then
								local _, color = devicons.get_icon_color(
									vim.fn.expand("%:t"),
									vim.fn.expand("%:e"),
									{ default = true }
								)
								if color then
									return { fg = color, gui = "bold" }
								end
							end
							return { fg = accents.filename, gui = "bold" }
						end,
						symbols = { modified = " ", readonly = " " },
					},
				},
				lualine_x = {
					{ "lsp_status", fmt = divider_fmt(), color = { fg = accents.lsp, gui = "bold" } },
					{ "searchcount", fmt = divider_fmt() },
					{ "selectioncount", fmt = divider_fmt() },
				},
				lualine_y = { { "encoding", fmt = divider_fmt(""), color = { fg = accents.encoding } } },
				lualine_z = { { "location", fmt = divider_fmt("") } },
			},
			tabline = {
				-- dropped use_mode_colors (that's what painted the colored buffer/tab pills) to
				-- match the statusline's flat-text look; active vs inactive still reads via
				-- lualine's own a/inactive-a theme contrast (bold+bright vs dim), just no fill
				lualine_a = { { "buffers", symbols = { alternate_file = "" } } },
				lualine_z = { { "tabs" } },
			},
			extensions = { "quickfix" }, -- nvim-tree/fugitive extensions dropped, neither plugin is installed
		})
	end,
}
