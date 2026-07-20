return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { enable = true, mode = "topline", line_numbers = true },
    },
  },

  config = function()
    require("nvim-treesitter").setup()

    -- Install and manage parsers
    require("nvim-treesitter.install").install({
      "csv",
      "dockerfile",
      "gitignore",
      "cue",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "javascript",
      "json",
      "lua",
      "markdown",
      "proto",
      "python",
      "rego",
      "sql",
      "yaml",
    })
  end,
}
