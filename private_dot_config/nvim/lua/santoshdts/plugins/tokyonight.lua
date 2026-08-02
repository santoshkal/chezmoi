local tokyonight = require("tokyonight")
local transparent = true

tokyonight.setup({
	style = "moon",
	transparent = transparent,
	styles = {
		sidebars = transparent and "transparent" or "dark",
		floats = transparent and "transparent" or "dark",
		comments = { italic = true, fg = "#237a91" },
	},
})

vim.cmd([[colorscheme tokyonight]])
