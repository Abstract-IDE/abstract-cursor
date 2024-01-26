local M = {

	CursorLine = {
		enable = true,
		colors = {
			default = vim.api.nvim_get_hl(0, { name = "CursorLine" }),
		},
	},

	CursorLineNr = {
		enable = true,
		colors = {
			default = vim.api.nvim_get_hl(0, { name = "CursorLineNr" }),
		},
	},
	Visual = {
		enable = true,
		colors = {
			default = vim.api.nvim_get_hl(0, { name = "Visual" }),
		},
	},
}

return M
