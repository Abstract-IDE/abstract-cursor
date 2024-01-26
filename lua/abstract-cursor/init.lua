local M = {}

local configs = require("abstract-cursor.configs")
local extend = vim.tbl_extend

local function set_highlight(group, mode, colors)
	vim.api.nvim_set_hl(0, group, colors[mode] and colors[mode] or colors["default"])
end

function M.setup(opts)
	if opts ~= nil then
		if opts.CursorLine ~= nil and opts.CursorLine.enable ~= nil then
			configs.CursorLine.enable = opts.CursorLine.enable
			if opts.CursorLine.colors ~= nil then
				configs.CursorLine.colors = extend("force", configs.CursorLine.colors, opts.CursorLine.colors)
			end
		end
		if opts.CursorLineNr ~= nil and opts.CursorLineNr.enable ~= nil then
			configs.CursorLineNr.enable = opts.CursorLineNr.enable
			if opts.CursorLineNr.colors ~= nil then
				configs.CursorLineNr.colors = extend("force", configs.CursorLineNr.colors, opts.CursorLineNr.colors)
			end
		end
		if opts.Visual ~= nil and opts.Visual.enable ~= nil then
			configs.Visual.enable = opts.Visual.enable
			if opts.Visual.colors ~= nil then
				configs.Visual.colors = extend("force", configs.Visual.colors, opts.Visual.colors)
			end
		end
	end

	vim.api.nvim_create_autocmd({ "ModeChanged", "InsertLeave" }, {
		desc = "change cursor color on mode change",
		group = vim.api.nvim_create_augroup("AbstractLineGroup", { clear = true }),
		callback = function()
			local mode = vim.api.nvim_get_mode().mode
			if configs.CursorLine.enable then
				set_highlight("CursorLine", mode, configs.CursorLine.colors)
			end
			if configs.CursorLineNr.enable then
				set_highlight("CursorLineNr", mode, configs.CursorLineNr.colors)
			end
			if configs.Visual.enable then
				set_highlight("Visual", mode, configs.Visual.colors)
			end
		end,
	})
end

return M
