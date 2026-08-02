local mr = require("mason-registry")

local ensure_installed = {
	"pyright",
	"gopls",
	"clangd",
	"lua-language-server",
	"rust-analyzer",
	"marksman",
	"yaml-language-server",
	"nixfmt",
	"shfmt",
	"ymlfmt",
	"jq",
	"dockerfile-language-server",
}

require("mason").setup({ ensure_installed = ensure_installed })

mr:on("package:install:success", function()
	vim.defer_fn(function()
		vim.api.nvim_exec_autocmds("FileType", { buffer = vim.api.nvim_get_current_buf() })
	end, 100)
end)

mr.refresh(function()
	for _, tool in ipairs(ensure_installed) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end)
