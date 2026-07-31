vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.deprecate = function() end
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.winborder = "rounded"
-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = true
opt.textwidth = 150
opt.signcolumn = "yes"

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.hlsearch = false
opt.incsearch = true

opt.inccommand = "split"
opt.termguicolors = true
opt.background = "dark"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.conceallevel = 1
