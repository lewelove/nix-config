local actions_dir = "~/dev/dale/actions/"

dl.action( "open_terminal", {
  config = { terminal = "alacritty" }
})

dl.action( "open_config_in_terminal", {
  config = { terminal = "alacritty", cmd = 'nvim -s <(printf " e")' }
})

dl.action( "theme", {
  run = actions_dir .. "get_theme",
  config = {
    type = "kmeansnv",
    sort = "gradient",
    args = "k=12,n=12,d=0.0",
    threshold = 0.001,
    open_with = "nvl"
  }
})

dl.action( "collect", {
  run = actions_dir .. "collect",
  config = {
    root = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Virtual Albums Stage/",
    formatting = {
      album = "{albumartist} - {album}",
      info = "Info"
    }
  }
})

dl.action( "embed", {
  run = actions_dir .. "embed",
  config = {
    keys_to_embed = {
      "album",
      "albumartist",
      "date",
      "genre",
      "comment",
      "title",
      "artist",
      "musicbrainz_releasetrackid",
      "replaygain_track_gain",
      "replaygain_album_gain",
    },
    auto_delete = true,
    auto_convert_tracknumber = true,
    auto_cover_embed = true,
  }
})

dl.action( "search_cover", {
  run = actions_dir .. "search_cover"
})

dl.action( "lyrics", {
  run = actions_dir .. "get_lyrics"
})

dl.action( "rename", {
  run = actions_dir .. "rename"
})
