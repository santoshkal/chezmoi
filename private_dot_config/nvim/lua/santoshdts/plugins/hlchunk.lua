return {
	"shellRaining/hlchunk.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				use_treesitter = true,
				delay = 0,
			},
			indent = {
				enable = true,
			},
			line_num = {
				enable = true,
			},
			blank = {
				enable = true,
			},
			context = {
				enable = false,
			},
		})
	end,
}
