-- lewelove hyprland config --

hl.on("hyprland.start", function () 
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

require("keybinds")

hl.config({

  input = {
    kb_layout = "us",
    sensitivity = -0.3,
    repeat_rate = 35,
    repeat_delay = 200,
  },

  cursor = {
    no_hardware_cursors = false,
  },

})

