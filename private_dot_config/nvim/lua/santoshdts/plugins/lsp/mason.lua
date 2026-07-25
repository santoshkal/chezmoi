return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	-- Mason must be initialized before formatters and linters load so that its
	-- bin directory is available on Neovim's PATH.
	lazy = false,
	cmd = "Mason",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	build = ":MasonUpdate",
	opts_extend = { "ensure_installed" },
	opts = {
		PATH = "prepend",
		ensure_installed = {
			"pyright",
			"gopls",
			"yamlfmt",
			"isort",
			"black",
			"stylua",
			"clangd",
			"lua-language-server",
			"rust-analyzer",
			"marksman",
			"yaml-language-server",
			"jq",
			"bash-language-server",
			"shfmt",
			"dockerfile-language-server",
			-- Formatters and linters configured elsewhere in this config.
			"prettier",
			"nixfmt",
			"ruff",
			"yamllint",
			-- LSP executables referenced from ./lsp.
			"typescript-language-server",
			"json-lsp",
		},
	},

	config = function(_, opts)
		require("mason").setup(opts)
		local mr = require("mason-registry")
		mr:on("package:install:success", function()
			vim.defer_fn(function()
				-- trigger FileType event to possibly load this newly installed LSP server
				require("lazy.core.handler.event").trigger({
					event = "FileType",
					buf = vim.api.nvim_get_current_buf(),
				})
			end, 100)
		end)

		mr.refresh(function()
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end)
	end,
}
