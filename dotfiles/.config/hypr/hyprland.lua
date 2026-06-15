-- lewelove hyprland config --

hl.on("hyprland.start", function () 
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

require("keybinds")
require("window-rules")

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
  },

})

hl.config ({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 0,
    resize_on_border = false,
    allow_tearing = false,
  },

  decoration = {
    rounding = 6,
    rounding_power = 6,
    shadow = {
      enabled = true,
      range = 20,
      render_power = 8,
      color = "rgba(00000050)",
      color_inactive = "rgba(00000010)",
    },
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },
})

-- Animations

hl.curve ( "steep", { type = "bezier", points = { {0, 1}, {0, 1} } })
hl.curve ( "easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve ( "easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })

hl.animation ({
  leaf = "workspaces",
  enabled = false,
  speed = 3,
  bezier = "steep",
  style = "slide top",
})

hl.animation ({
  leaf = "windows",
  enabled = true,
  speed = 4.8,
  bezier = "easeOutQuint",
  style = "popin 90%",
})

hl.animation ({
  leaf = "windowsIn",
  enabled = true,
  speed = 3,
  bezier = "easeOutQuint",
})

hl.animation ({
  leaf = "windowsOut",
  enabled = true,
  speed = 1.5,
  bezier = "easeOutQuint",
  style = "popin 90%",
})
