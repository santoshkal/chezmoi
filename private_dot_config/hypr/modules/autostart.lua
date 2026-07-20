-- [3] MY PROGRAMS
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local M       = {}
M.terminal    = "ghostty"
M.fileManager = "nemo"
M.launcher    = "rofi -show drun -show-icons"
M.runner      = "rofi -show run"
M.browser     = "google-chrome-stable"
M.scratchpad  = "gedit"

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("dunst")
end)

return M
