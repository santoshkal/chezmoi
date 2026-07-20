return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "jq" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "gofumpt", "goimports-reviser" },
			},
			-- on_attach = function(client, bufnr)
			-- 	if client.supports_method("textDocument/formatting") then
			-- 		vim.api.nvim_clear_autoicmds({
			-- 			group = augroup,
			-- 			bufnr = bufnr,
			-- 		})
			-- 		vim.api.nvim_createautocnd("BufWritePre", {
			-- 			group = augroup,
			-- 			bufnr = bufnr,
			-- 			callback = function()
			-- 				vim.lsp.buf.format({ bufnr = bufnr })
			-- 			end,
			-- 		})
			-- 	end
			-- end,
			format_on_save = function(bufnr)
				-- Disable autoformat on certain filetypes
				local ignore_filetypes = { "sql", "java" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable autoformat for files in a certain path
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				-- ...additional logic...
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
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
