return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				yaml = { "yamlfmt" },
				nix = { "nixfmt" },
				typescript = { "prettier" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "jq" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "gofumpt", "goimports-reviser" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
