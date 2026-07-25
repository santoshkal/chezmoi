return {
	"mfussenegger/nvim-lint",
	enabled = false,
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		require("lint").linters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			python = { "isort", "black" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
			lua = { "stylua" },
			json = { "jq" },
			nix = { "nixfmt" },

			-- go = { "revive" }, -- revive is also another great option
			-- ruby = { "standardrb" },
			-- sql = { "sqruff" },
			yaml = { "yamllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function try_lint_available()
			require("lint").try_lint(nil, {
				-- Mason installs tools asynchronously on first startup. Do not surface an
				-- ENOENT notification while a configured linter is not installed yet.
				filter = function(linter)
					return vim.fn.executable(linter.cmd) == 1
				end,
			})
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = try_lint_available,
		})

		vim.keymap.set("n", "<leader>l", try_lint_available, { desc = "Trigger linting for current file" })
	end,
}
