return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- a giant file with full LSP + treesitter running is how you get a frozen editor
		bigfile = { enabled = true, auto_disable_lsp = true, auto_disable_treesitter = true },
		explorer = { enabled = true },
		animate = { enabled = true },
		indent = { enabled = true },
		scroll = { enabled = true },
		dashboard = {
			enabled = true,
			-- left pane: keymaps. right pane: recent files, projects, git status.
			pane_gap = 8,
			width = 70,
			-- header padded (asymmetrically) to the combined width of both panes so it visually
			-- centers above both -- snacks re-centers an overflowing pane-1 line using half of
			-- (line_width - single_pane_width) as a LEFT shift, so straight symmetric padding
			-- lands off-center; this compensates for that shift.
			preset = {
				header = table.concat({
					"                                                                                                                                                    ",
					"                                                                                                                                                  ",
					"                                                                                    ████ ██████           █████      ██                     ",
					"                                                                                   ███████████             █████                             ",
					"                                                                                   █████████ ███████████████████ ███   ███████████   ",
					"                                                                                  █████████  ███    █████████████ █████ ██████████████   ",
					"                                                                                 █████████ ██████████ █████████ █████ █████ ████ █████   ",
					"                                                                               ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
					"                                                                              ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
					"                                                                                                                                                    ",
				}, "\n"),
				-- default keys list plus harpoon (mirrors the real bindings in plugins/editor/harpoon.lua)
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					-- no "Harpoon Add File" here: the dashboard buffer isn't a real file, so
					-- there's nothing for harpoon.mark.add_file() to mark from this context
					{
						icon = "󰛢 ",
						key = "h",
						desc = "Harpoon Menu",
						action = function()
							require("harpoon.ui").toggle_quick_menu()
						end,
					},
					{
						icon = " ",
						key = "o",
						desc = "Overseer Task Action",
						action = ":OverseerTaskAction",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				-- blank filler: pane rows are shared by absolute index across panes, and every
				-- header line is padded to the full 148-wide span, so all 10 header rows (+2
				-- trailing padding rows from the header's own `padding=2`) overflow pane 1's
				-- width -- anything landing on those same rows inherits that extra-wide offset
				-- (this is why, without the filler, "Recent Files" below would render shifted
				-- right while "Projects" doesn't -- it starts later, past the header block)
				{ pane = 2, text = "\n\n\n\n\n\n\n\n\n\n\n" },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = vim.fn.isdirectory(".git") == 1, -- skip it outside a repo, git status would just error
					cmd = "git status --short --branch",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 2,
				},
				-- reimplements section="startup", but padded wide enough to overflow pane 1
				-- (same trick as the header) so it re-centers across both panes instead of
				-- just within the left one -- the built-in version is only ~40 chars wide,
				-- well under one pane's width, so it never overflows on its own
				function(self)
					local ok, lazy_stats = pcall(require, "lazy.stats")
					local stats = ok and lazy_stats.stats() or { loaded = 0, count = 0, startuptime = 0 }
					local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
					local icon = "⚡ "
					local label = icon
						.. "Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					local pane_width = self.opts.width
					local total_width = pane_width * 2 + self.opts.pane_gap
					local label_w = vim.api.nvim_strwidth(label)
					local lib_shift = math.floor((total_width - pane_width) / 2)
					local leading = math.floor((total_width - label_w) / 2) + lib_shift
					local trailing = math.max(0, total_width - label_w - leading)
					return {
						text = {
							{ (" "):rep(leading) },
							{ icon .. "Neovim loaded ", hl = "footer" },
							{ tostring(stats.loaded) .. "/" .. tostring(stats.count), hl = "special" },
							{ " plugins in ", hl = "footer" },
							{ tostring(ms) .. "ms", hl = "special" },
							{ (" "):rep(trailing) },
						},
					}
				end,
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		image = {
			enabled = true,
			relative = "cursor",
			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
			force = true,
			border = "rounded",
			focusable = false,
			math = {
				enabled = true,
				typst = {
					tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
				},
			},
			latex = {
				font_size = "Large",
				packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
				tpl = [[
                    \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
                    \usepackage{${packages}}
                    \begin{document}
                    ${header}
                    { \${font_size} \selectfont
                      \color[HTML]{${color}}
                    ${content}}
                    \end{document}]],
			},
			backdrop = false,
			row = 1,
			col = 1,
		},
		-- assets/third_party show up in every project and are never what I'm looking for
		picker = {
			enabled = true,
			sources = {
				files = { exclude = { "assets", "third_party" } },
				smart = { exclude = { "assets", "third_party" } },
				grep = { exclude = { "assets", "third_party" } },
			},
		},
		rename = { enabled = true },
		toggle = { enabled = true },
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"gai",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "C[a]lls Incoming",
		},
		{
			"gao",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "C[a]lls Outgoing",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Other
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},

		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
}
