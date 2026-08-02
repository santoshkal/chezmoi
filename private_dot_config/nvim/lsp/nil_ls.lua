local mason_path = vim.fn.stdpath("data") .. "/mason/bin/nil"
local nix_path = vim.fn.expand("~/.nix-profile/bin/nil")

local nil_cmd
if vim.fn.executable(nix_path) == 1 then
  nil_cmd = { nix_path }
elseif vim.fn.executable(mason_path) == 1 then
  nil_cmd = { mason_path }
else
  nil_cmd = { "nil" }
end

return {
  cmd = nil_cmd,
  filetypes = { "nix" },
  root_markers = { "flake.nix", "flake.lock", ".git" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}
