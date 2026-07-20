return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	enabled = false,
	config = function()
		local custom_colors = {
			palette = {
				sumiInk0 = "#0F0F14",
				waveBlue1 = "#1C2A3E",
				-- Add other overridden colors here
			},
			theme = {
				wave = {
					Normal = { fg = "#C8C093", bg = "#1F1F28" },
					Comment = { fg = "#727169", italic = true },
					-- Add other theme-specific overrides here
				},
			},
		}

		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = custom_colors, -- Use custom colors
			overrides = function(colors) -- add/modify highlights
				return {}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
	end,
}
