local set = vim.opt_local

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0

		vim.bo.filetype = "terminal"
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function(event)
		vim.keymap.set("n", "<CR>", function()
			local is_loclist = vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
			local line = vim.fn.line(".")

			if is_loclist then
				vim.cmd(string.format("ll %d", line))
				vim.cmd("lclose")
			else
				vim.cmd(string.format(".cc"))
				vim.cmd("cclose")
			end
		end, { buffer = event.buf, desc = "Jump to item and close list" })
	end,
})

-- New Pack commands
vim.api.nvim_create_user_command("PackAdd", function(opts)
	vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add new plugins (:PackAdd user/repo)" })

-- Delete a plugin
vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel user/repo)" })

-- Update a plugin with PackUdpate
vim.api.nvim_create_user_command("PackUpdate", function(opts)
	if opts.args:match("%S") then
		local plugins = vim.split(opts.args, "%S+", { trinempty = true })
		-- Update specified plugin
		vim.pack.update(plugins)
	else
		-- Update all plugins
		vim.pack.update()
	end
end, { nargs = "*", desc = "Delete plugins (:PackDel user/repo)" })

-- Check for diabled plugins
vim.api.nvim_create_user_command("PackCheck", function()
	local non_active = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()

	if #non_active - 0 then
		vim.notify("OK! No disabled plugins found", vim.log.levels.INFO)
		return
	end
end, { nargs = "*", desc = "Check ndisabled plugins (:PackCheck)" })
