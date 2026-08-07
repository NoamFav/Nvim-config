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
				require("overseer").run_template({ name = "make re" })
			end,
			desc = "make re",
		},
		{
			"<leader>mc",
			function()
				require("overseer").run_template({ name = "make clean" })
			end,
			desc = "make clean",
		},
		{
			"<leader>mf",
			function()
				require("overseer").run_template({ name = "make fclean" })
			end,
			desc = "make fclean",
		},
		{
			"<leader>mn",
			function()
				require("overseer").run_template({ name = "norminette (file)" })
			end,
			desc = "norminette (file)",
		},
		{
			"<leader>mN",
			function()
				require("overseer").run_template({ name = "norminette (project)" })
			end,
			desc = "norminette (project)",
		},
		{
			"<leader>mb",
			function()
				require("overseer").run_template({ name = "cc (this file)" })
			end,
			desc = "cc -Wall -Wextra -Werror (this file)",
		},
		{
			"<leader>mx",
			function()
				local overseer = require("overseer")
				overseer.run_template({ name = "run" })
			end,
			-- "run" is registered once per language below, each scoped to its own
			-- filetype condition, so this key just runs whichever one matches
			desc = "run (c/go/rust/python)",
		},
		{
			"<leader>mp",
			function()
				require("overseer").run_template({ name = "norm + build" })
			end,
			desc = "pipeline: norm + build",
		},
		{
			"<leader>mv",
			function()
				local overseer = require("overseer")
				overseer.run_template({ name = "valgrind" }, function(task)
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
			-- dispose closes the output once you've actually looked at it,
			-- not the second it finishes — otherwise a fast success flashes and vanishes
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

		-- walks up from wherever the current file actually is, so this still
		-- finds the right project root from three directories deep in a 42 project
		local function find_root(markers)
			local start = vim.fn.expand("%:p:h")
			if start == "" then
				start = vim.fn.getcwd()
			end
			local found = vim.fs.find(markers, { upward = true, path = start })[1]
			return found and vim.fs.dirname(found) or vim.fn.getcwd()
		end

		local function project_root()
			return find_root({ "Makefile", "makefile" })
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

		make_target("make", "")
		make_target("make re", "re")
		make_target("make clean", "clean")
		make_target("make fclean", "fclean")

		overseer.register_template({
			name = "norminette (file)",
			builder = function()
				return {
					cmd = { "norminette" },
					args = { vim.fn.expand("%:p") },
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})

		overseer.register_template({
			name = "norminette (project)",
			builder = function()
				return {
					cmd = { "norminette" },
					cwd = project_root(),
				}
			end,
		})

		-- for when I just want to know if this one file compiles, not the whole project
		overseer.register_template({
			name = "cc (this file)",
			builder = function()
				local src = vim.fn.expand("%:p")
				local out = vim.fn.expand("%:p:r") -- absolute path, extension stripped
				return {
					name = "cc " .. vim.fn.expand("%:t") .. " -> " .. vim.fn.expand("%:t:r"),
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
			name = "run",
			builder = function()
				local dir = vim.fn.expand("%:p:h")
				local bin = vim.fn.expand("%:p:r")
				if vim.fn.filereadable(bin) == 0 and vim.fn.filereadable(dir .. "/a.out") == 1 then
					bin = dir .. "/a.out"
				end
				return {
					name = "run " .. vim.fn.fnamemodify(bin, ":t"),
					cmd = { bin },
					cwd = dir,
				}
			end,
			-- had no condition at all before, which meant it matched in every
			-- filetype and would've collided with the go/rust/python "run"
			-- templates below now that those exist
			condition = { filetype = { "c", "cpp" } },
		})

		-- norm first: no point burning a build cycle on code that's about to
		-- get rejected for indentation anyway
		overseer.register_template({
			name = "norm + build",
			builder = function()
				local root = project_root()
				return {
					name = "norm + build",
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
			name = "valgrind",
			builder = function()
				local dir = vim.fn.expand("%:p:h")
				local bin = vim.fn.expand("%:p:r")
				if vim.fn.filereadable(bin) == 0 and vim.fn.filereadable(dir .. "/a.out") == 1 then
					bin = dir .. "/a.out"
				end
				return {
					name = "valgrind " .. vim.fn.fnamemodify(bin, ":t"),
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

		-- go, only surfaces in menu form (<leader>ml) except "run" which
		-- shares its name with the c/rust/python ones above/below on <leader>mx
		overseer.register_template({
			name = "go build",
			builder = function()
				return {
					cmd = { "go" },
					args = { "build", "./..." },
					cwd = find_root({ "go.mod", "go.work" }),
				}
			end,
			condition = { filetype = { "go" } },
		})

		overseer.register_template({
			name = "run",
			builder = function()
				return {
					cmd = { "go" },
					args = { "run", "." },
					cwd = find_root({ "go.mod", "go.work" }),
				}
			end,
			condition = { filetype = { "go" } },
		})

		overseer.register_template({
			name = "go test",
			builder = function()
				return {
					cmd = { "go" },
					args = { "test", "./..." },
					cwd = find_root({ "go.mod", "go.work" }),
				}
			end,
			condition = { filetype = { "go" } },
		})

		-- rust, same deal as go above
		overseer.register_template({
			name = "cargo build",
			builder = function()
				return {
					cmd = { "cargo" },
					args = { "build" },
					cwd = find_root({ "Cargo.toml" }),
				}
			end,
			condition = { filetype = { "rust" } },
		})

		overseer.register_template({
			name = "run",
			builder = function()
				return {
					cmd = { "cargo" },
					args = { "run" },
					cwd = find_root({ "Cargo.toml" }),
				}
			end,
			condition = { filetype = { "rust" } },
		})

		overseer.register_template({
			name = "cargo test",
			builder = function()
				return {
					cmd = { "cargo" },
					args = { "test" },
					cwd = find_root({ "Cargo.toml" }),
				}
			end,
			condition = { filetype = { "rust" } },
		})

		-- python, no build step and no test template — didn't want to
		-- assume pytest is what every project here actually uses
		local function python_interpreter()
			local root = find_root({ "pyproject.toml", "setup.py", "requirements.txt", ".git" })
			for _, venv in ipairs({ ".venv", "venv" }) do
				local candidate = root .. "/" .. venv .. "/bin/python"
				if vim.fn.executable(candidate) == 1 then
					return candidate
				end
			end
			return "python3"
		end

		overseer.register_template({
			name = "run",
			builder = function()
				return {
					cmd = { python_interpreter() },
					args = { vim.fn.expand("%:p") },
					cwd = vim.fn.expand("%:p:h"),
				}
			end,
			condition = { filetype = { "python" } },
		})
	end,
}
