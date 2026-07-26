-- [3] MY PROGRAMS
---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local M = {}
M.terminal = "uwsm app -- ghostty"
M.fileManager = "uwsm app -- nemo"
M.launcher = "uwsm app -- rofi -show drun -show-icons"
M.runner = "uwsm app -- rofi -show run"
M.browser = "uwsm app -- chromium-browser"
M.mail = "uwsm app -- thunderbird"
M.scratchpad = "uwsm app -- gedit"

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- hyprpaper")
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

return M
