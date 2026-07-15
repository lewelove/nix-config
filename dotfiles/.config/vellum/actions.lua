local actions_dir = "~/dev/vellum/actions/"

vl.actions({ cover_palette = {
  run = actions_dir .. "cover_palette",
  config = {
    type = "kmeansnv",
    sort = "gradient",
    args = "k=12,n=12,d=0.0",
    threshold = 0.001,
    open_with = "nvl"
  }
}})

vl.actions({ search_cover = {
  run = actions_dir .. "search_cover"
}})

vl.actions({ get_lyrics = {
  run = actions_dir .. "get_lyrics"
}})
