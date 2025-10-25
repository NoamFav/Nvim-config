return {
	-- Core LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local caps = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = caps,
				on_attach = function(_, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				end,
			})

			local ok, servers = pcall(require, "lsp.servers")
			if not ok then
				vim.notify("Failed to load lsp.servers: " .. tostring(servers), vim.log.levels.ERROR)
				return
			end
			servers.setup_server_configs()
		end,
	},

	-- Mason
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

	-- Mason LSP Config
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

			vim.schedule(function()
				for _, name in ipairs(opts.ensure_installed) do
					pcall(vim.lsp.enable, name)
				end
			end)
		end,
	},

	-- OmniSharp Extended
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		lazy = true,
		ft = { "cs" },
	},

	-- LSP UI Enhancement
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
