local M = {}

--- Get highlight properties for a given highlight name
--- @param name string The highlight group name
--- @param fallback? table The fallback highlight properties
--- @return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or M.parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

--- Remove a buffer by its number without affecting window layout
--- @param buf? number The buffer number to delete
function M.delete_buffer(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end

  vim.api.nvim_command("bwipeout " .. buf)
end

--- Switch to the previous buffer
function M.switch_to_previous_buffer()
  local ok, _ = pcall(function()
    vim.cmd("buffer #")
  end)
  if not ok then
    vim.notify("No other buffer to switch to!", 3, { title = "Warning" })
  end
end

--- Get the number of open buffers
--- @return number
function M.get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufname(buf) ~= "" then
      count = count + 1
    end
  end
  return count
end

--- Parse a given integer color to a hex value.
--- @param int_color number
function M.parse_hex(int_color)
  return string.format("#%x", int_color)
end

-- Open a Random note in Obsidian
function M.open_random_note()
  local vault = vim.fn.expand("~/Dropbox/devops/00-Inbox")
  local cmd = vim.fn.executable("fd") == 1
      and { "fd", "--type", "f", "--extension", "md", ".", vault }
      or { "rg", "==files", "--glob", "*.md", vault }

  local result = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 or vim.tbl_isempty(result) then
    vim.notify("No Markdown files found in vault", vim.log.levels.WARN)
    return
  end

  math.randomseed(os.time())
  local choice = result[math.random(#result)]
  vim.cmd("edit" .. vim.fn.fnameescape(choice))
end

return M
