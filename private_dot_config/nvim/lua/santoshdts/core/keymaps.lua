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

-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- Equalize split sizes
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Close current split
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ──────────────────────
-- Buffer Management
-- ──────────────────────
vim.keymap.set("n", "<Tab>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })
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

-- Obsidian Keymaps
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open on App" })
vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Obsidian Search" })
vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "New Note" })
vim.keymap.set("n", "<leader>oN", "<cmd>Obsidian new_from_template<CR>", { desc = "New Note (Template)" })
vim.keymap.set("n", "<leader>o<space>", "<cmd>Obsidian quick_switch<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<CR>", { desc = "Tags" })
vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian template<CR>", { desc = "Template" })
vim.keymap.set("v", "<leader>oL", "<cmd>Obsidian link<CR>", { desc = "Link" })
vim.keymap.set("n", "<leader>oi", "<cmd>Obsidian links<CR>", { desc = "Links" })
vim.keymap.set("n", "<S-CR>", "<cmd>Obsidian follow_link vsplit<CR>", { desc = "[F]ollow Link in Verticle Split" })
vim.keymap.set("v", "<leader>oe", "<cmd>Obsidian link_new<CR>", { desc = "Extract and Link New Note" })
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian workspace DevOps<CR>", { desc = "Switch to [D]evOps Workspace" })
vim.keymap.set("n", "<leader>ow", "<cmd>Obsidian workspace work<CR>", { desc = "Switch to [W]prk Workspace" })
vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian workspace<CR>", { desc = "[L]ist Workspaces" })
vim.keymap.set("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Rename" })

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
-- Notifications
-- ──────────────────────

-- Dismiss notify popup and clear hlsearch
vim.keymap.set("n", "<Esc>", function()
	require("notify").dismiss()
end, { desc = "dismiss notify popup and clear hlsearch" })

-- ──────────────────────
-- Built-in Plugins
-- ──────────────────────

-- Toggle builtin undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle builtin Undotree" })

-- ──────────────────────
-- Terminal
-- ──────────────────────

-- Easily hit escape in terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- Open a terminal at the bottom of the screen with a fixed height
vim.keymap.set("n", ",st", function()
	vim.cmd("new")
	vim.cmd("wincmd J")
	vim.api.nvim_win_set_height(0, 6)
	vim.wo.winfixheight = true
	vim.cmd("term")
end, { desc = "Open terminal at bottom" })

-- ──────────────────────
-- Window Navigation
-- ──────────────────────

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
