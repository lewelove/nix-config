local actions_dir = "~/dev/vellum/actions/"

vl.actions({ open_terminal = {
  config = { terminal = "alacritty" }
}})

vl.actions({ open_config_in_terminal = {
  config = { terminal = "alacritty", cmd = 'nvim -s <(printf " e")' }
}})

vl.actions({ get_theme = {
  run = actions_dir .. "get_theme",
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
    root = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Virtual Albums Stage/",
    formatting = {
      album = "{albumartist} - {album}",
      info = "Info"
    }
  }
}})

vl.actions({ embed = {
  run = actions_dir .. "embed",
  config = {
    sync_tags = {
      "ALBUM",
      "ALBUMARTIST",
      "DATE",
      "GENRE",
      "COMMENT",
      "TITLE",
      "ARTIST",
      "musicbrainz_releasetrackid",
      "REPLAYGAIN_TRACK_GAIN",
      "REPLAYGAIN_ALBUM_GAIN",
    }
  }
}})

vl.actions({ search_cover = {
  run = actions_dir .. "search_cover"
}})

vl.actions({ get_lyrics = {
  run = actions_dir .. "get_lyrics"
}})

vl.actions({ rename = {
  run = actions_dir .. "rename",
}})
