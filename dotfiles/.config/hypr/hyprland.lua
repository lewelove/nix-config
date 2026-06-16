-- lewelove hyprland config --

_G.programs = require("tables.programs")

hl.on("hyprland.start", function () 
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

require("visuals")
require("window-rules")

require("keybinds")

require("plugins.meta-workspaces")

-- IO

hl.config ({

  input = {
    kb_layout = "us",
    sensitivity = -0.3,
    repeat_rate = 35,
    repeat_delay = 200,
  },

  cursor = {
    no_hardware_cursors = false,
    inactive_timeout = 3,
  },

})
