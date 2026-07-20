return {
  {
    'vimwiki/vimwiki',
    enabled = false,
    init = function()
      vim.g.vimwiki_path = '~/Documents/notes'
      vim.g.vimwiki_syntax = 'markdown'
      vim.g.vimwiki_ext = 'md'
    end,
  }
}
