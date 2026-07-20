return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "scottmckendry/cyberdream.nvim" },
	event = "VeryLazy",
	opts = function()
		local copilot_colors = {
			[""] = { fg = "#6c6f93" }, -- Default color
			["Normal"] = { fg = "#6c6f93" }, -- Normal color
			["Warning"] = { fg = "#ff6c6b" }, -- Warning color
			["InProgress"] = { fg = "#ecbe7b" }, -- InProgress color
		}

		-- comment these lines for non-transparent lualine theme
		-- local cyberdream = require("lualine.themes.cyberdream")
		-- cyberdream.normal.c.bg = "None"
		return {
			options = {
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
				-- theme = cyberdream,
				-- Set below color theme with non-transparent bg lualine
				theme = "cyberdream",
				-- theme = "auto",

				globalstatus = true,
				-- disabled_filetypes = { statusline = { "dashboard", "alpha", "fzf" } },
			},
			sections = {
				color = nil,
				lualine_a = { { "mode", icon = "" } },
				lualine_b = { { "branch", icon = "" } },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰝶 ",
						},
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
						color = { fg = "#a9a1e1" }, -- Replace with appropriate color
						padding = { left = 0, right = 1 },
					},
					{
						function()
							return require("nvim-navic").get_location()
						end,
						cond = function()
							return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
						end,
						color = { fg = "#6c6f93" }, -- Replace with appropriate color
					},
				},
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#98be65" }, -- Replace with appropriate color
					},
					{
						function()
							local icon = " "
							local status = require("copilot.api").status.data
							return icon .. (status.message or "")
						end,
						cond = function()
							local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
							return ok and #clients > 0
						end,
						color = function()
							if not package.loaded["copilot"] then
								return
							end
							local status = require("copilot.api").status.data
							return copilot_colors[status.status] or copilot_colors[""]
						end,
					},
					{ "diff" },
				},
				lualine_y = {
					{
						"progress",
					},
					{
						"location",
						color = { fg = "#f7768e" }, -- Replace with appropriate color
					},
				},
				lualine_z = {
					{
						"datetime",
						style = "  %X",
					},
				},
			},

			extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
		}
	end,
}
