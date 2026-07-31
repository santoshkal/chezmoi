require('bufferline').setup({
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diag)
      local icons = {
        Error = '󰅚 ',
        Warn = ' ',
      }
      local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
        .. (diag.warning and icons.Warn .. diag.warning or '')
      return vim.trim(ret)
    end,
    mode = 'tabs',
    separator_style = 'slant',
  },
})

vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
  callback = function()
    vim.schedule(function()
      pcall(vim.cmd, 'BufferlineSync')
    end)
  end,
})
