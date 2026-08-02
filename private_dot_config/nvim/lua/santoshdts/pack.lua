local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.schedule(function()
				vim.cmd("TSUpdateSync")
			end)
		end
		if name == "mason.nvim" and kind == "install" then
			vim.schedule(function()
				require("mason").setup()
			end)
		end
	end,
})

vim.pack.add({
	gh("saghen/blink.lib"),
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
	gh("rafamadriz/friendly-snippets"),
	gh("akinsho/bufferline.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/tokyonight.nvim"),
	gh("scottmckendry/cyberdream.nvim"),
	gh("numToStr/Comment.nvim"),
	gh("stevearc/conform.nvim"),
	gh("stevearc/dressing.nvim"),
	gh("ibhagwan/fzf-lua"),
	gh("lewis6991/gitsigns.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("folke/lazydev.nvim"),
	gh("kdheepak/lazygit.nvim"),
	gh("mfussenegger/nvim-lint"),
	gh("nvim-lualine/lualine.nvim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	gh("echasnovski/mini.nvim"),
	gh("nvim-neo-tree/neo-tree.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("folke/noice.nvim"),
	gh("obsidian-nvim/obsidian.nvim"),
	gh("folke/snacks.nvim"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("christoomey/vim-tmux-navigator"),
	gh("folke/todo-comments.nvim"),
	gh("folke/trouble.nvim"),
	gh("folke/which-key.nvim"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
}, { load = true })

local function try(name)
	pcall(require, name)
end

try("santoshdts.plugins.blink")
try("santoshdts.plugins.bufferline")
try("santoshdts.plugins.tokyonight")
try("santoshdts.plugins.comment")
try("santoshdts.plugins.conform")
try("santoshdts.plugins.dressing")
try("santoshdts.plugins.fzf")
try("santoshdts.plugins.gitsigns")
try("santoshdts.plugins.harpoon")
try("santoshdts.plugins.lazydev")
try("santoshdts.plugins.lazygit")
try("santoshdts.plugins.linter")
try("santoshdts.plugins.lualine")
try("santoshdts.plugins.markdown")
try("santoshdts.plugins.mini")
try("santoshdts.plugins.neotree")
try("santoshdts.plugins.noice")
try("santoshdts.plugins.obsidian")
try("santoshdts.plugins.snacks")
try("santoshdts.plugins.textobjects")
try("santoshdts.plugins.tmux_navigator")
try("santoshdts.plugins.todo_comments")
try("santoshdts.plugins.treesitter")
try("santoshdts.plugins.trouble")
try("santoshdts.plugins.which_key")
try("santoshdts.plugins.mason")
try("santoshdts.core.lsp")
