require("lualine").setup({
	options = {
		component_separators = { left = " ", right = " " },
		section_separators = { left = " ", right = " " },
		theme = "cyberdream",
		globalstatus = true,
	},
	sections = {
		color = nil,
		lualine_a = { { "mode", icon = "" } },
		lualine_b = { { "branch", icon = "" } },
		lualine_c = {
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
			},
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", padding = { left = 1, right = 0 }, path = 0 },
			{
				function()
					local buffer_count = #vim.fn.getbufinfo({ buflisted = true })
					return "+" .. buffer_count - 1 .. " "
				end,
				cond = function()
					return #vim.fn.getbufinfo({ buflisted = true }) > 1
				end,
				color = { fg = "#a9a1e1" },
				padding = { left = 0, right = 1 },
			},
			{
				function()
					return require("nvim-navic").get_location()
				end,
				cond = function()
					return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
				end,
				color = { fg = "#6c6f93" },
			},
		},
		lualine_x = {
			{ "diff" },
		},
		lualine_y = {
			{ "progress" },
			{ "location", color = { fg = "#f7768e" } },
		},
		lualine_z = {
			{ "datetime", style = "  %X" },
		},
	},
	extensions = { "toggleterm", "mason", "neo-tree", "trouble" },
})
