local M = {}

local ns = vim.api.nvim_create_namespace("norminette")
local enabled = false
local timer
local job

local function parse(output, bufnr)
	local diags = {}
	for raw in output:gmatch("[^\r\n]+") do
		local line = raw:gsub("\27%[[%d;]*m", "") -- strip ANSI colour codes
		local kind, code, lnum, col, msg = line:match("^(%a+):%s+(%S+)%s+%(line:%s*(%d+),%s+col:%s*(%d+)%):%s*(.+)$")
		if code then
			local l = math.max((tonumber(lnum) or 1) - 1, 0)
			local c = math.max((tonumber(col) or 1) - 1, 0)
			table.insert(diags, {
				bufnr = bufnr,
				lnum = l,
				end_lnum = l,
				col = c,
				end_col = c + 1,
				severity = (kind == "Notice") and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
				source = "norminette",
				code = code,
				message = (msg:gsub("^%s+", ""):gsub("%s+$", "")),
			})
		end
	end
	return diags
end

local function run(bufnr)
	bufnr = (bufnr and bufnr ~= 0) and bufnr or vim.api.nvim_get_current_buf()
	if not enabled or not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	local name = vim.api.nvim_buf_get_name(bufnr)
	if not name:match("%.[ch]$") then
		return
	end
	if vim.fn.executable("norminette") == 0 then
		return
	end

	if job then
		pcall(function()
			job:kill(9)
		end)
		job = nil
	end

	job = vim.system(
		{ "norminette", name },
		{ text = true, timeout = 5000, env = { NO_COLOR = "1" } },
		vim.schedule_wrap(function(res)
			job = nil
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			local out = (res.stdout or "") .. "\n" .. (res.stderr or "")
			vim.diagnostic.set(ns, bufnr, parse(out, bufnr))
		end)
	)
end

local function schedule(bufnr)
	if timer then
		timer:stop()
		pcall(function()
			timer:close()
		end)
	end
	local t = vim.uv.new_timer()
	timer = t
	t:start(400, 0, function()
		t:stop()
		pcall(function()
			t:close()
		end)
		if timer == t then
			timer = nil
		end
		vim.schedule(function()
			run(bufnr)
		end)
	end)
end

function M.setup()
	local grp = vim.api.nvim_create_augroup("NorminetteAsync", { clear = true })
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
		group = grp,
		pattern = { "*.c", "*.h" },
		callback = function(args)
			schedule(args.buf)
		end,
	})

	vim.api.nvim_create_user_command("Norminette", function()
		run(0)
	end, { desc = "Run norminette on the current C file" })

	vim.api.nvim_create_user_command("NorminetteClear", function()
		vim.diagnostic.reset(ns, 0)
	end, { desc = "Clear norminette diagnostics" })

	vim.api.nvim_create_user_command("NorminetteToggle", function()
		enabled = not enabled
		if not enabled then
			vim.diagnostic.reset(ns)
		else
			run(0)
		end
		vim.notify("norminette " .. (enabled and "enabled" or "disabled"))
	end, { desc = "Toggle norminette diagnostics on save" })
end

return M
