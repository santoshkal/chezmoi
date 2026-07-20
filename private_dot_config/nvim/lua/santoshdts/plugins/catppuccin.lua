return {
	"catppuccin/nvim",
	name = "catppuccin",
	enabled = true,
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			custom_highlights = function(colors)
				local u = require("catppuccin.utils.colors")
				return {
					CursorLine = {
						bg = u.vary_color(
							{ latte = u.lighten(colors.mantle, 0.40, colors.base) },
							u.darken(colors.surface0, 0.30, colors.base)
						),
					},
				}
			end,
			-- no_italic = true,
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			styles = {
				comments = { "italic" },
			},
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.10, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
        fzf = true,
				cmp = true,
				dap = {
					enabled = true,
					enable_ui = true, -- enable nvim-dap-ui
				},
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = false,
				},
				lsp_trouble = true,
				markdown = true,
				mason = true,
        blink_cmp = {
            style = 'bordered',
        },
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
					inlay_hints = {
						background = true,
					},
				},
        neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				-- telescope = {
				-- 	enabled = true,
				-- },
				treesitter = true,
				ts_rainbow2 = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
