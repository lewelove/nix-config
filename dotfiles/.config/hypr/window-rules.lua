-- hl.window_rule ({
--   name = "",
--   match = { class = "" },
--   float = true,
--   center = true,
--   size = { "monitor_w * 0.5",  "monitor_h * 0.75" },
-- })

hl.window_rule ({
  name = "nvim",
  match = { class = "nvim" },
  float = true,
  center = true,
  size = { "monitor_w * 0.5",  "monitor_h * 0.9" },
})

hl.window_rule ({
  name = "portal",
  match = { class = "xdg-desktop-portal-gtk" },
  float = true,
  center = true,
  size = { "monitor_w * 0.5",  "monitor_h * 0.75" },
})

hl.window_rule ({
  name = "fullscreen",
  match = { class = "^(imv|mpv|rmpc)$" },
  fullscreen = true,
})

hl.window_rule ({
  name = "thunar",
  match = { class = "^(thunar|Thunar)$" },
  float = true,
  center = true,
  size = { "monitor_w * 0.5",  "monitor_h * 0.75" },
})

hl.window_rule ({
  name = "btop",
  match = { class = "btop" },
  float = true,
  center = true,
  size = { "monitor_w * 0.75",  "monitor_h * 0.9" },
})

hl.window_rule ({
  name = "bitwarden",
  match = { class = "Bitwarden" },
  float = true,
  center = true,
  size = { "monitor_w * 0.5",  "monitor_h * 0.75" },
})

hl.window_rule ({
  name = "calculator",
  match = { class = "org.gnome.Calculator" },
  float = true,
  pin = true,
  size = { 360, 540 },
  move = { 1500, 110 },
})

hl.window_rule ({
  name = "chromium_dev_app",
  match = { class = "chromium-browser", initial_title = "DevToolsApp" },
  float = true,
  center = true,
  size = { "monitor_w * 0.5",  "monitor_h * 0.75" },
})

