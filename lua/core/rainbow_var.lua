-- Give every unique identifier name a stable colour ("rainbow variables"),
-- so the same variable reads the same everywhere instead of being coloured
-- purely by its syntax-node kind.
--
-- This reimplements the idea behind david-kunz/markid directly against the
-- core `vim.treesitter` query API instead of using that plugin: markid only
-- hooks into nvim-treesitter's old `nvim-treesitter.configs` module system,
-- which the `main` branch (see plugins/editor/treesitter.lua) removed.

local M = {}

local ns = vim.api.nvim_create_namespace("rainbow_var")

local palette = {
	"#e06c75",
	"#e5989b",
	"#d19a66",
	"#e5c07b",
	"#98c379",
	"#56b6c2",
	"#61afef",
	"#7aa2f7",
	"#c678dd",
	"#bb9af7",
}

-- Per-language capture queries: plain `(identifier)` covers most grammars,
-- but e.g. JS/TS object keys are a different node type.
local queries = {
	default = "(identifier) @markid",
	javascript = [[
		(identifier) @markid
		(property_identifier) @markid
		(shorthand_property_identifier_pattern) @markid
	]],
}
queries.typescript = queries.javascript
queries.tsx = queries.javascript

local function set_highlights()
	for i, color in ipairs(palette) do
		vim.api.nvim_set_hl(0, "RainbowVar" .. i, { fg = color })
	end
end

-- djb2, good enough for a stable name -> colour bucket.
local function hash(name)
	local h = 5381
	for i = 1, #name do
		h = (h * 33 + name:byte(i)) % 2147483647
	end
	return h
end

local function highlight(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return
	end

	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	parser:for_each_tree(function(tree, lang_tree)
		local lang = lang_tree:lang()
		local query_str = queries[lang] or queries.default
		local ok_query, query = pcall(vim.treesitter.query.parse, lang, query_str)
		if not ok_query then
			return
		end
		for _, node in query:iter_captures(tree:root(), bufnr, 0, -1) do
			local name = vim.treesitter.get_node_text(node, bufnr)
			if name and name ~= "" then
				local group = "RainbowVar" .. ((hash(name) % #palette) + 1)
				local srow, scol, erow, ecol = node:range()
				pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, srow, scol, {
					end_row = erow,
					end_col = ecol,
					hl_group = group,
					priority = 110, -- above treesitter's default of 100
				})
			end
		end
	end)
end

-- Debounce: re-highlighting walks the whole tree, so don't do it on every keystroke.
local timers = {}
local function schedule_highlight(bufnr)
	if timers[bufnr] then
		timers[bufnr]:stop()
	else
		timers[bufnr] = vim.uv.new_timer()
	end
	timers[bufnr]:start(
		150,
		0,
		vim.schedule_wrap(function()
			highlight(bufnr)
		end)
	)
end

local function attach(bufnr)
	local group = vim.api.nvim_create_augroup("rainbow_var_buf_" .. bufnr, { clear = true })
	schedule_highlight(bufnr)
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
		group = group,
		buffer = bufnr,
		callback = function()
			schedule_highlight(bufnr)
		end,
	})
	vim.api.nvim_create_autocmd("BufWipeout", {
		group = group,
		buffer = bufnr,
		callback = function()
			if timers[bufnr] then
				timers[bufnr]:stop()
				timers[bufnr]:close()
				timers[bufnr] = nil
			end
		end,
	})
end

function M.setup()
	set_highlights()
	vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		callback = function(args)
			attach(args.buf)
		end,
	})
end

return M
