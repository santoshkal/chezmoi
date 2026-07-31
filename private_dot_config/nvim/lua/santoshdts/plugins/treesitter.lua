require('nvim-treesitter').setup()

require('nvim-treesitter.install').install({
  'csv',
  'dockerfile',
  'gitignore',
  'cue',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'javascript',
  'json',
  'lua',
  'markdown',
  'proto',
  'python',
  'rego',
  'sql',
  'nix',
  'yaml',
})

require('treesitter-context').setup({ enable = true, mode = 'topline', line_numbers = true })
