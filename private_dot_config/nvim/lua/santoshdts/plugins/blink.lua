return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  -- dependencies = {
  -- },
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
      trigger = {
        show_in_snippet = false,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "label",            gap = 10 },
            { "kind_icon",        gap = 1 },
            { "kind" },
            { "label_description" },
          },

          gap = 1,
          treesitter = { "lsp" },
        },
      },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = true, window = { border = "single" } },
    sources = {
      -- min_keyword_length = function()
      -- 	return vim.bo.filetype == "markdown" and 0
      -- end,
      default = { "lazydev", "lsp", "snippets", "path", "buffer" },
      per_filetype = {
        -- markdown = { "obsidian", "lsp", "snippets", "path", "buffer" },
        markdown = {
          "lsp",
        },

      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        snippets = {
          min_keyword_length = 1,
          score_offset = 4,
        },
        lsp = {
          min_keyword_length = 0,
          score_offset = 3,
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
            end, items)
          end,
          fallbacks = {},
        },
        path = {
          min_keyword_length = 0,
          score_offset = 2,
        },
        buffer = {
          min_keyword_length = 1,
          score_offset = 1,
        },
      },
    },
    cmdline = {
      sources = {},
      keymap = { preset = "enter" },
      completion = { menu = { auto_show = true } },
    },
    appearance = {
      kind_icons = {
        Text = "󰉿",
        Method = "",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "",
        Variable = "󰆦",
        Property = "󰖷",
        Class = "",
        Interface = "",
        Struct = "󱡠",
        Module = "󰅩",
        Unit = "󰪚",
        Value = "",
        Enum = "",
        EnumMember = "",
        Keyword = "",
        Constant = "󰏿",
        Snippet = "",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
        Error = "󰏭",
        Warning = "",
        Information = "󰋼",
        Hint = "",
      },
    },
    keymap = {
      ["<D-c>"] = { "show" },
      ["<S-CR>"] = { "hide" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<PageDown>"] = { "scroll_documentation_down" },
      ["<PageUp>"] = { "scroll_documentation_up" },
    },
  },
  opts_extend = { "sources.default" },
}
