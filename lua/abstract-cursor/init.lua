local M = {}

local function set_highlight(group, mode, colors)
	vim.api.nvim_set_hl(0, group, colors[mode] and colors[mode] or colors["default"])
end

function M.setup(opts)
	local configs = vim.tbl_deep_extend("force", require("abstract-cursor.configs"), opts or {})

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
