require('neo-tree').setup({
  popup_border_style = '',
  window = { position = 'float', border = 'rounded', width = 40 },
  event_handlers = {
    {
      event = 'file_open_requested',
      handler = function()
        require('neo-tree.command').execute({ action = 'close' })
      end,
    },
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.cmd('setlocal relativenumber')
      end,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    },
    window = {
      mappings = {
        ['-'] = 'close_window',
        ['o'] = 'noop',
        ['oc'] = 'noop',
        ['od'] = 'noop',
        ['og'] = 'noop',
        ['om'] = 'noop',
        ['on'] = 'noop',
        ['os'] = 'noop',
        ['ot'] = 'noop',
      },
    },
  },
})

vim.keymap.set('n', '-', ':Neotree toggle<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')
