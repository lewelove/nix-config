-- Vellum sevrer and interface spawn
hl.workspace_rule ({
  workspace = "name:M:4",
  layout = "dwindle",
  on_created_empty = "alacritty -e vellum interface & alacritty -e vellum server",
})

