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

vl.actions({ collect = {
  run = actions_dir .. "collect",
  config = {
    root = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Library Historyfied!/Virtual Albums/",
    formatting = {
      album = "{albumartist} - {album}",
      info = "Info"
    }
  }
}})

vl.actions({ search_cover = {
  run = actions_dir .. "search_cover"
}})

vl.actions({ get_lyrics = {
  run = actions_dir .. "get_lyrics"
}})
