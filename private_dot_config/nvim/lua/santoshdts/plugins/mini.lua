return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Mini.ai: enhanced textobjects
      -- require("mini.ai").setup({
      --   n_lines = 500,
      --   custom_textobjects = nil,
      -- })

      -- Mini.surround: powerful surrounding
      require("mini.surround").setup({
        mappings = {
          add = "sa",     -- Add surrounding
          delete = "sd",  -- Delete surrounding
          replace = "sr", -- Replace surrounding
          find = "sf",    -- Find surrounding (to the right)
        },
      })

      -- Mini.comment: commenting utilities
      require("mini.comment").setup({
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
        },
      })

      -- Mini.pairs: automatic pairing
      require("mini.pairs").setup()

      -- Mini.statusline: lightweight and configurable statusline
      require("mini.statusline").setup({
        set_vim_settings = true, -- override `laststatus`, `showmode`
      })

      -- Optional: Disable default statusline for some filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "NvimTree", "alpha" },
        callback = function()
          vim.b.ministatusline_disable = true
        end,
      })
    end,
  },
}
