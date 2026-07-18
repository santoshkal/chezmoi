-- Configure capabilities for all LSP servers
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = true,
				lineFoldingOnly = true,
			},
			semanticTokens = {
				multilineTokenSupport = true,
			},
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	},
})

-- Load LSP server configurations from ./lsp directory
local lsp_config_dir = vim.fn.stdpath("config") .. "/lsp"
local lsp_servers = {
	"yamlls",
	"bash-language-server",
	"ts_ls",
	"jsonls",
  "marksman",
	"gopls",
	"lua_ls",
	"pyright",
	"dockerls",
}

-- Apply configurations from individual LSP config files
for _, server in ipairs(lsp_servers) do
	local config_file = lsp_config_dir .. "/" .. server .. ".lua"
	if vim.fn.filereadable(config_file) == 1 then
		local ok, config = pcall(dofile, config_file)
		if ok and config then
			vim.lsp.config[server] = config
		end
	end
end

-- Enable LSP servers
vim.lsp.enable(lsp_servers)

vim.diagnostic.config({
	virtual_lines = true,
	-- virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("gi", vim.lsp.buf.implementation, "Goto Implementations")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>nr", vim.lsp.buf.rename, "Rename all references")
		map("<leader>cl", vim.lsp.codelens.run, "Run Codelens")
		map("gd", vim.lsp.buf.definition, "Goto Definition")
		map("<Leader>dp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Goto previous Diagnostic point")
		map("<Leader>dn", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Goto next Diagnostic point")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			-- TODO: NOT WORKING Using nvim-lsp for completionin nvim-cmp
			-- if client:supports_method("textDocument/completion") then
			-- 	-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- 	local chars = {}
			-- 	for i = 32, 126 do
			-- 		table.insert(chars, string.char(i))
			-- 	end
			-- 	-- client.server_capabilities.completionProvider.triggerCharacters = chars
			-- 	vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			-- end

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					---@diagnostic disable-next-line: missing-parameter
					local params = vim.lsp.util.make_range_params()
					---@diagnostic disable-next-line: inject-field
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
					for _, res in pairs(result or {}) do
						for _, action in pairs(res.result or {}) do
							if action.edit then
								vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
							end
						end
					end
				end,
			})
		end
	end,
})
