require('mini.surround').setup({
  mappings = { add = 'sa', delete = 'sd', replace = 'sr', find = 'sf' },
})

require('mini.comment').setup({
  mappings = { comment = 'gc', comment_line = 'gcc', comment_visual = 'gc' },
})

require('mini.pairs').setup()

require('mini.statusline').setup({ set_vim_settings = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'NvimTree', 'alpha' },
  callback = function()
    vim.b.ministatusline_disable = true
  end,
})
