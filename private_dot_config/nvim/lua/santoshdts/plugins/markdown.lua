return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        file_types = {
          "markdown",
          "vimwiki",
        },
        preset = "obsidian",
        render_modes = true,
        max_file_size = 10.0,
        debounce = 200,
        completions = {
          lsp = {
            enabled = true,
          },
          blink = {
            enabled = true,
          },
        },
        yaml = {
          enabled = false,
        },
        -- heading = {
        --   enabled = true,
        --   sign = true,
        --   position = "overlay",
        --   icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        --   signs = { "󰫎 " },
        --   width = "full",
        --   left_pad = 0,
        --   right_pad = 0,
        --   min_width = 0,
        --   border = false,
        --   border_prefix = false,
        --   above = "▄",
        --   below = "▀",
        -- },
      })
    end,
  },
}
