local actions_dir = "~/dev/dale/actions/"

dale.action( "open_terminal", {
  config = { terminal = "alacritty" }
})

dale.action( "open_config_in_terminal", {
  config = { terminal = "alacritty", cmd = 'nvim -s <(printf " e")' }
})

dale.action( "theme", {
  run = actions_dir .. "get_theme",
  config = {
    type = "kmeansnv",
    sort = "gradient",
    args = "k=12,n=12,d=0.0",
    threshold = 0.001,
    open_with = "nvl"
  }
})

dale.action( "collect", {
  run = actions_dir .. "collect",
  config = {
    root = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Virtual Albums Stage/",
    formatting = {
      album = "{albumartist} - {album}",
      info = "Info"
    }
  }
})

dale.action( "embed", {
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

dale.action( "mbs", {
  run = actions_dir .. "musicbrainz_search"
})

dale.action( "search_cover", {
  run = actions_dir .. "search_cover"
})

dale.action( "lyrics", {
  run = actions_dir .. "get_lyrics"
})

dale.action( "rename", {
  run = actions_dir .. "rename"
})

dale.action( "discogs_fetch_master", {
  run = actions_dir .. "discogs_fetch_master"
})

dale.action( "cover_metrics", {
  run = actions_dir .. "calculate_cover_metrics"
})
