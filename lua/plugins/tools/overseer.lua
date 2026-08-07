return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerRun",
		"OverseerToggle",
		"OverseerOpen",
		"OverseerRunCmd",
		"OverseerQuickAction",
	},
	keys = {
		{ "<leader>mm", "<cmd>OverseerRunCmd make<cr>", desc = "make" },
		{
			"<leader>mr",
			function()
				require("overseer").run_template({ name = "42: make re" })
			end,
			desc = "make re",
		},
		{
			"<leader>mc",
			function()
				require("overseer").run_template({ name = "42: make clean" })
			end,
			desc = "make clean",
		},
		{
			"<leader>mf",
			function()
				require("overseer").run_template({ name = "42: make fclean" })
			end,
			desc = "make fclean",
		},
		{
			"<leader>mn",
			function()
				require("overseer").run_template({ name = "42: norminette (file)" })
			end,
			desc = "norminette (file)",
		},
		{
			"<leader>mN",
			function()
				require("overseer").run_template({ name = "42: norminette (project)" })
			end,
			desc = "norminette (project)",
		},
		{
			"<leader>mb",
			function()
				require("overseer").run_template({ name = "42: cc (this file)" })
			end,
			desc = "cc -Wall -Wextra -Werror (this file)",
		},
		{
			"<leader>mx",
			function()
				local overseer = require("overseer")
				overseer.run_template({ name = "42: run" })
			end,
			desc = "run compiled binary",
		},
		{
			"<leader>mp",
			function()
				require("overseer").run_template({ name = "42: norm + build" })
			end,
			desc = "pipeline: norm + build",
		},
		{
			"<leader>mv",
			function()
				local overseer = require("overseer")
				overseer.run_template({ name = "42: valgrind" }, function(task)
					if task then
						overseer.run_action(task, "open hsplit")
					end
				end)
			end,
			desc = "valgrind (leak check)",
		},
		{ "<leader>mo", "<cmd>OverseerToggle<cr>", desc = "toggle task list" },
		{ "<leader>ml", "<cmd>OverseerRun<cr>", desc = "run task (menu)" },
	},
	opts = {
		component_aliases = {
			default = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		local function project_root()
			local start = vim.fn.expand("%:p:h")
			if start == "" then
				start = vim.fn.getcwd()
			end
			local found = vim.fs.find({ "Makefile", "makefile" }, { upward = true, path = start })[1]
			return found and vim.fs.dirname(found) or vim.fn.getcwd()
		end

		local function make_target(name, target)
			overseer.register_template({
				name = name,
				builder = function()
					return {
						cmd = { "make" },
						args = target ~= "" and { target } or {},
						cwd = project_root(),
						components = {
							"default",
						},
					}
				end,
				condition = { filetype = { "c", "cpp", "make", "sh" } },
			})
		end

		make_target("42: make", "")
		make_target("42: make re", "re")
		make_target("42: make clean", "clean")
		make_target("42: make fclean", "fclean")

		overseer.register_template({
			name = "42: norminette (file)",
			builder = function()
				return {
					cmd = { "norminette" },
					args = { vim.fn.expand("%:p") },
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})

		overseer.register_template({
			name = "42: norminette (project)",
			builder = function()
				return {
					cmd = { "norminette" },
					cwd = project_root(),
				}
			end,
		})

		overseer.register_template({
			name = "42: cc (this file)",
			builder = function()
				local src = vim.fn.expand("%:p")
				local out = vim.fn.expand("%:p:r") -- absolute path, extension stripped
				return {
					name = "42: cc " .. vim.fn.expand("%:t") .. " -> " .. vim.fn.expand("%:t:r"),
					cmd = { "cc" },
					args = { "-Wall", "-Wextra", "-Werror", src, "-o", out },
					cwd = vim.fn.expand("%:p:h"),
					components = {
						{ "on_complete_notify", statuses = { "SUCCESS", "FAILURE" } },
						"default",
					},
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})

		overseer.register_template({
			name = "42: run",
			builder = function()
				local dir = vim.fn.expand("%:p:h")
				local bin = vim.fn.expand("%:p:r")
				if vim.fn.filereadable(bin) == 0 and vim.fn.filereadable(dir .. "/a.out") == 1 then
					bin = dir .. "/a.out"
				end
				return {
					name = "42: run " .. vim.fn.fnamemodify(bin, ":t"),
					cmd = { bin },
					cwd = dir,
				}
			end,
		})

		overseer.register_template({
			name = "42: norm + build",
			builder = function()
				local root = project_root()
				return {
					name = "42: norm + build",
					strategy = {
						"orchestrator",
						tasks = {
							{
								cmd = { "norminette" },
								cwd = root,
							},
							{
								cmd = { "make" },
								cwd = root,
							},
						},
					},
				}
			end,
			condition = { filetype = { "c", "cpp", "make" } },
		})

		overseer.register_template({
			name = "42: valgrind",
			builder = function()
				local dir = vim.fn.expand("%:p:h")
				local bin = vim.fn.expand("%:p:r")
				if vim.fn.filereadable(bin) == 0 and vim.fn.filereadable(dir .. "/a.out") == 1 then
					bin = dir .. "/a.out"
				end
				return {
					name = "42: valgrind " .. vim.fn.fnamemodify(bin, ":t"),
					cmd = { "valgrind" },
					args = {
						"--leak-check=full",
						"--show-leak-kinds=all",
						"--track-origins=yes",
						bin,
					},
					cwd = dir,
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})
	end,
}
