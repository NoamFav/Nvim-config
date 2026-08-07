return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			-- "*" applies to every server config below, so blink.cmp's
			-- capabilities don't have to be repeated in each one
			local caps = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = caps,
			})

			local ok, servers = pcall(require, "lsp.servers")
			if not ok then
				vim.notify("Failed to load lsp.servers: " .. tostring(servers), vim.log.levels.ERROR)
				return
			end
			servers.setup_server_configs()
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = function()
			local servers = require("lsp.servers").get_server_list()
			return {
				ensure_installed = servers,
				automatic_installation = true,
			}
		end,
		config = function(_, opts)
			local mlsp = require("mason-lspconfig")
			mlsp.setup(opts)

			-- scheduled + pcall'd: a server can still be mid-install here,
			-- enabling it too early just errors instead of waiting politely
			vim.schedule(function()
				for _, name in ipairs(opts.ensure_installed) do
					pcall(vim.lsp.enable, name)
				end
			end)
		end,
	},

	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		lazy = true,
		ft = { "cs" },
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			lightbulb = {
				enable = true,
				sign = false,
				virtual_text = true,
			},
			ui = {
				border = "rounded",
			},
		},
	},
}
