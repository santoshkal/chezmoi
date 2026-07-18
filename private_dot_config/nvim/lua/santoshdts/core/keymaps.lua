-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Use 'keymap' for concise mapping
local keymap = vim.keymap

-- ────────────────
-- General Keymaps
-- ────────────────

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/Decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- ──────────────────────
-- Window Management
-- ──────────────────────

-- ──────────────────────
-- Obsidian
-- ──────────────────────
-- keymap.set("n", "<leader>oo", ":Obsidian<cr>", { desc = "[O]pen [O]bsidian " })
-- keymap.set("n", "<leader>on", ":ObsidianNewFromTemplate<cr>", { desc = "[O]bsidian [N]ewNote from Template" })
-- keymap.set("n", "<leader>os", ":ObsidianSearch<cr>", { desc = "[O]bsidian [S]earch" })
-- keymap.set("n", "<leader>ow", ":ObsidianQuickSwitch<cr>", { desc = "[O]bsidian [S]witch" })
-- keymap.set("n", "<leader>obl", ":ObsidianBacklinks<cr>", { desc = "[O]bsidian [B]ackLinks" })
-- keymap.set("n", "<leader>ot", ":ObsidianTemplate<cr``>", { desc = "[O]bsidian [T]emplates" })
-- keymap.set("n", "<leader>ol", ":ObsidianLink<cr>", { desc = "[O]bsidian [L]ink" })
-- keymap.set("n", "<leader>onl", ":ObsidianLinkNew<cr>", { desc = "[O]bsidian [L]inkNew" })
-- keymap.set("n", "<leader>ogl", ":ObsidianLinks<cr>", { desc = "[O]bsidian [G]etLinks" })
-- keymap.set("n", "<leader>oc", ":ObsidianTOC<cr>", { desc = "[O]bsidian [T]oC" })
--
-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- Equalize split sizes
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Close current split
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ──────────────────────
-- Tab Management
-- ──────────────────────

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- ───────────────────────────────
-- Visual Mode Line Movement
-- ───────────────────────────────

-- Move selected line(s) up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selection down
keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- Move selection up

-- ──────────────────────
-- Tmux Integration
-- ──────────────────────

-- Open new Tmux split or window from Neovim
keymap.set("n", "<C-p>", "<cmd>silent !tmux split-window -v -l 15<CR>")
keymap.set("n", "<C-n>", "<cmd>silent !tmux new-window<CR>")

-- ──────────────────────
-- Scrolling Enhancements
-- ──────────────────────

-- Center cursor after half-page scroll
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- ──────────────────────
-- Save All Files (Commented)
-- ──────────────────────

-- Save all files (disabled due to Tmux Ctrl+s conflict)
-- keymap.set("n", "<C-s>", "<cmd>w<cr><cmd>wa<cr>", { desc = "Save all" })

-- ──────────────────────
-- Yank Highlight
-- ──────────────────────

-- Highlight text on yank (copy)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- ──────────────────────
-- Notifications
-- ──────────────────────

-- Dismiss notify popup and clear hlsearch
vim.keymap.set("n", "<Esc>", function()
	require("notify").dismiss()
end, { desc = "dismiss notify popup and clear hlsearch" })

-- ──────────────────────
-- Quickfix & Location List
-- ──────────────────────

-- Ensure Enter works in quickfix and location list windows
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function(event)
		-- Jump to the item under cursor and close the quickfix/location list
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
