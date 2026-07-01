-- The 42 "CI/CD" layer: an async task runner wired for the piscine loop.
-- norminette → make → run, plus single-file compilation with the mandatory
-- flags. Everything streams into a bottom task list and the quickfix window.

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
				-- Open the task's terminal in a split so output is visible and the
				-- program can read stdin (piscine binaries often do).
				overseer.run_template({ name = "42: run" }, function(task)
					if task then
						overseer.run_action(task, "open hsplit")
					end
				end)
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
		{ "<leader>mo", "<cmd>OverseerToggle<cr>", desc = "toggle task list" },
		{ "<leader>ml", "<cmd>OverseerRun<cr>", desc = "run task (menu)" },
	},
	opts = {
		strategy = "terminal",
		task_list = {
			direction = "bottom",
			min_height = 10,
			max_height = 20,
			default_detail = 1,
			bindings = {
				["q"] = "Close",
				["<CR>"] = "RunAction",
			},
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- Nearest directory that owns a Makefile, else cwd.
		local function project_root()
			local start = vim.fn.expand("%:p:h")
			if start == "" then
				start = vim.fn.getcwd()
			end
			local found = vim.fs.find({ "Makefile", "makefile" }, { upward = true, path = start })[1]
			return found and vim.fs.dirname(found) or vim.fn.getcwd()
		end

		-- A make target as an overseer template, output routed to quickfix.
		local function make_target(name, target)
			overseer.register_template({
				name = name,
				builder = function()
					return {
						cmd = { "make" },
						args = target ~= "" and { target } or {},
						cwd = project_root(),
						components = {
							{ "on_output_quickfix", open = false },
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

		-- norminette on the current file
		overseer.register_template({
			name = "42: norminette (file)",
			builder = function()
				return {
					cmd = { "norminette" },
					args = { vim.fn.expand("%:p") },
					components = { { "on_output_quickfix", open = true }, "default" },
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})

		-- norminette on the whole project
		overseer.register_template({
			name = "42: norminette (project)",
			builder = function()
				return {
					cmd = { "norminette" },
					cwd = project_root(),
					components = { { "on_output_quickfix", open = true }, "default" },
				}
			end,
		})

		-- Quick single-file compile with the mandatory flags.
		-- Output binary is named after the source and dropped right next to it:
		--   ft_strlen.c -> ft_strlen   (run it with <leader>mx)
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
						{ "on_output_quickfix", open = true }, -- open on compile errors
						{ "on_complete_notify", statuses = { "SUCCESS", "FAILURE" } },
						"default",
					},
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})

		-- Run the binary produced above (source stem), falling back to ./a.out
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

		-- The piscine "CI" gate: norminette, then make, in sequence.
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
								components = { { "on_output_quickfix", open = true }, "default" },
							},
							{
								cmd = { "make" },
								cwd = root,
								components = { { "on_output_quickfix", open = false }, "default" },
							},
						},
					},
				}
			end,
			condition = { filetype = { "c", "cpp", "make" } },
		})
	end,
}
