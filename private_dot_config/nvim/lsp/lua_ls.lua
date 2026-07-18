return {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/lua-language-server",
  },
  filetypes = {
    "lua",
  },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
    ".luacheckrc",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        -- path = vim.split(package.path, ";"),
      },
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          -- [vim.fn.stdpath("config") .. "/lua"] = true,
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
