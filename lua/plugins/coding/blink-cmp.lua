local trigger_text = ";"

return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		enabled = true,

		dependencies = {
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-dictionary",
		},

		opts = function(_, opts)
			opts.enabled = function()
				local filetype = vim.bo[0].filetype
				if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
					return false
				end
				return true
			end

			opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
				default = { "lsp", "path", "snippets", "buffer", "emoji", "dictionary" },
				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						min_keyword_length = 2,
						score_offset = 90,
					},

					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 25,
						fallbacks = { "snippets", "buffer" },
						min_keyword_length = 2,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},

					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 4,
						score_offset = 15,
					},

					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 15,
						min_keyword_length = 2,
						module = "blink.cmp.sources.snippets",
						score_offset = 85,
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end,

						transform_items = function(_, items)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
							if trigger_pos then
								for _, item in ipairs(items) do
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = col },
										},
									}
								end
							end
							vim.schedule(function()
								require("blink.cmp").reload("snippets")
							end)
							return items
						end,
					},

					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 93,
						min_keyword_length = 2,
						opts = { insert = true },
					},

					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						score_offset = 20,
						enabled = true,
						max_items = 8,
						min_keyword_length = 3,
						opts = {
							dictionary_directories = { vim.fn.expand("~/.config/dictionaries") },
							dictionary_files = {
								vim.fn.expand("~/.config/spell/en.utf-8.add"),
								vim.fn.expand("~/.config/spell/es.utf-8.add"),
							},
						},
					},
				},
			})

			opts.cmdline = {
				sources = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
			}

			opts.completion = {
				menu = {
					border = "single",
				},

				documentation = {
					auto_show = true,
					window = {
						border = "single",
					},
				},

				ghost_text = {
					enabled = true,
				},

				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						end,
						auto_insert = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
					},
				},
			}

			opts.snippets = {
				preset = "luasnip",

				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					---@diagnostic disable-next-line: undefined-field
					require("luasnip").jump(direction)
				end,
			}

			opts.keymap = {
				preset = "default",
				["<Up>"] = { "snippet_forward", "fallback" },
				["<Down>"] = { "snippet_backward", "fallback" },

				["<Tab>"] = { "select_prev", "fallback" },
				["<S-Tab>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<S-k>"] = { "scroll_documentation_up", "fallback" },
				["<S-j>"] = { "scroll_documentation_down", "fallback" },

				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<C-g>"] = { "cancel", "fallback" },
				["<Esc>"] = { "cancel", "fallback" },
			}

			return opts
		end,
	},
}
