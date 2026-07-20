return {
	"folke/tokyonight.nvim",
	priority = 1000,
	enabled = false,
	config = function()
		local transparent = true -- set to true if you would like to enable transparency

		require("tokyonight").setup({
			style = "moon",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
				comments = { italic = true, fg = "#237a91" },
				-- functions = { fg = "#909ff5" },
			},
			-- on_highlights = function(highlights)
			-- 	highlights["@identifier"].fg = "#364abf"
			-- end,
		})

		vim.cmd([[colorscheme tokyonight]])
	end,
}
