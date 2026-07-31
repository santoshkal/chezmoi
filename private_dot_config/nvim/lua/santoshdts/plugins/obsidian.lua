require("obsidian").setup({
	checkbox = { create_new = false },
	ui = { enabled = false },
	workspaces = {
		{ name = "DevOps", path = "~/Dropbox/notes", overrides = { notes_subdir = "00-Inbox" } },
		{ name = "work", path = "~/Dropbox/work", overrides = { notes_subdir = "00-Inbox" } },
	},
	notes_subdir = "00-Inbox",
	frontmatter = { enabled = true },
	note_id_func = function(title)
		if title ~= nil then
			return title
		else
			return os.date("%Y%m%d%H%M")
		end
	end,
	legacy_commands = false,
	templates = {
		folder = "templates",
		date_format = "%Y%m%d%H%M",
	},
	picker = {
		name = "fzf-lua",
		note_mappings = { new = "<C-x>", insert_link = "<C-l>" },
	},
})

vim.api.nvim_create_user_command("ObsidianRandom", function()
	require("santoshdts.core.utils").open_random_note()
end, {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(event)
		local bufpath = vim.api.nvim_buf_get_name(event.buf)
		if bufpath:match("Dropbox/devops") or bufpath:match("Dropbox/work") then
			vim.keymap.set("n", "<CR>", function()
				return require("obsidian").util.smart_action()
			end, { buffer = event.buf, expr = true, desc = "Obsidian: Follow link" })

			vim.keymap.set("n", "gd", function()
				return require("obsidian").util.gf_passthrough()
			end, { buffer = event.buf, noremap = false, expr = true, desc = "Obsidian: Go to definition" })
		end
	end,
})
