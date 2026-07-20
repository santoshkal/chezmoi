return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".git", "README.md" },
  single_file_support = true,
}
