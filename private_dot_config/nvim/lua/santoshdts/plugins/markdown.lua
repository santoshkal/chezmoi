require('render-markdown').setup({
  file_types = { 'markdown', 'vimwiki' },
  preset = 'obsidian',
  render_modes = true,
  max_file_size = 10.0,
  debounce = 200,
  completions = { lsp = { enabled = true }, blink = { enabled = true } },
  yaml = { enabled = false },
})
