require('noice').setup({
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },
  views = {
    mini = { win_options = { winblend = 0 } },
  },
  routes = {
    {
      filter = {
        event = 'notify',
        any = {
          { find = 'Toggling hidden files: true' },
          { find = 'Toggling hidden files: false' },
          { find = 'Operation canceled' },
          { find = 'Nothing currently selected' },
        },
      },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', kind = { 'echo' } },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        kind = '',
        any = {
          { find = ' bytes written' },
          { find = ' changes; before #' },
          { find = ' changes; after #' },
          { find = '1 change; before #' },
          { find = '1 change; after #' },
          { find = ' lines yanked' },
          { find = ' lines moved' },
          { find = ' lines indented' },
          { find = ' fewer lines' },
          { find = ' more lines' },
          { find = '1 more line' },
          { find = '1 line less' },
          { find = 'Already at newest change' },
          { find = 'Already at oldest change' },
          { find = "E21: Cannot make changes, 'modifiable' is off" },
        },
      },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', kind = 'emsg', any = {} },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'lsp',
        any = {
          { find = 'formatting' },
          { find = 'Diagnosing' },
          { find = 'Diagnostics' },
          { find = 'diagnostics' },
          { find = 'code_action' },
          { find = 'cargo check' },
          { find = 'Processing full semantic tokens' },
        },
      },
      opts = { skip = true },
    },
  },
})
