return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				relativenumber = true,
				backdrop = 80,
				title_pos = "center",
				preview = {
					default = "bat_native",
					layout = "vertical",
					vertical = "right:60%",
				},
			},
			fzf_colors = {
				true,
			},
			keymap = {
				fzf = {
					["ctrl-u"] = "preview-page-up",
					["ctrl-d"] = "preview-page-down",
					["ctrl-k"] = "up",
					["ctrl-j"] = "down",
					["ctrl-q"] = "abort",
					["esc"] = "abort",
				},
			},
			files = {
				fd_opts = "--type f --hidden --exclude node_modules --exclude .git --exclude .venv",
				previewer = "bat",
				cwd_prompt = false,
				formatters = "path.filename_first",
				file_icons = "devicons",
				path_shorten = true,
			},
			buffers = {
				sort_lastused = true,
				previewer = "bat",
				cwd_only = false,
				cwd = nil,
			},
			grep = {
				cmd = "rg --line-number --column --no-heading --color=always --smart-case",
				rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
				previewer = "bat",
			},
			live_grep = {
				cmd = "rg --line-number --column --no-heading --color=always --smart-case",
				rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
				previewer = "bat",
			},
			git = {
				files = {
					previewer = "bat",
				},
			},
			fzf_opts = {
				["--tiebreak"] = "index",
				["--layout"] = "reverse-list",
			},
			defaults = {
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
		})
		--
		-- Close the fzf window
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("FzfLuaEsc", { clear = true }),
			pattern = "fzf",
			callback = function(e)
				vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = e.buf, silent = true, nowait = true })
			end,
		})

		local keymap = vim.keymap.set

		keymap("n", "<leader>fb", fzf.buffers, { desc = "[F]ind existing [B]uffers" })
		keymap("n", "<leader>fn", fzf.git_files, { desc = "[F]ind [G]it files" })
		-- keymap("n", "<leader>fg", fzf.live_grep_glob, { desc = "[F]ind by blob [G]rep" })

		keymap("n", "<leader>fn", function()
			fzf.files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
		keymap("n", "<leader>fw", fzf.zoxide, { desc = "[F]ind Zoxode" })
		keymap("n", "<leader>fm", fzf.manpages, { desc = "[F]ind [M]anpages" })
		keymap("n", "<leader><leader>", fzf.files, { desc = "[F]ind [F]iles in cwd" })
		keymap("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp" })
		keymap("n", "<leader>fc", fzf.grep_cword, { desc = "[Find] [c]urrent [W]ord" })
		keymap("n", "<leader>ff", fzf.live_grep, { desc = "[F]ind by [G]rep" })
		keymap("n", "<leader>fd", fzf.diagnostics_document, { desc = "[F]ind [D]iagnostics" })
		keymap("n", "<leader>fo", fzf.oldfiles, { desc = '[F]ind [O]ld/Recent Files ("." for repeat)' })
		keymap("n", "<leader>fq", fzf.quickfix, { desc = "[F]ind [q]uick fix list" })
		keymap("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
		keymap("n", "<leader>fb", fzf.builtin, { desc = "[F]ind [B]uiltins" })
		keymap("n", "<leader>fg", fzf.git_branches, { desc = "[F]ind [G]it Branches" })
		keymap("n", "<leader>fa", fzf.highlights, { desc = "[F]ind [H]ighlighgroups" })

		keymap("n", "<leader>ft", function()
			fzf.grep({ cmd = "rg --column --line-number", search = "TODO", prompt = "Todos> " })
		end, { desc = "[F]ind [T]odos" })
		keymap("n", "<leader>fs", function()
			fzf.lsp_document_symbols({
				symbol_types = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Property" },
			})
		end, { desc = "[F]ind LSP document [S]ymbols" })
		-- keymap("n", "<leader><leader>", fzf.buffers, { desc = "Find existing buffers" })
		keymap("n", "<leader>s/", function()
			fzf.live_grep({ buffers_only = true, prompt = "Live Grep in Open Files> " })
		end, { desc = "[S]earch [/] in Open Files" })
	end,
}
