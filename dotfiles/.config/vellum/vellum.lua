-- Lewelove Vellum Config --

require("keys.default")
require("keys.date_added")
require("keys.musicbrainz")
require("keys.verified")
require("covers")
require("actions")
require("interfaces.default")

vl.config({
  storage = {
    library = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Library Historyfied!/",
    environment = "~/.secrets/vellum.env",
  },
  manifest = {
    audio_files = { ".flac" },
    keys = {
      albumartist = { level = "album", newline = true },
      album = { level = "album" },
      date = { level = "album" },
      genre = { level = "album", type = "list", newline = true },
      styles = { level = "album", type = "list" },
      original_date = { level = "album", newline = true },
      country = { level = "album", newline = true },
      label = { level = "album" },
      catalognumber = { level = "album" },
      release_date = { level = "album" },
      discogs_url = { level = "album", newline = true, manifests = "url" },
      musicbrainz_url = { level = "album", manifests = "url" },
      ctdbid_url = { level = "album", manifests = "url" },
      tracknumber = { level = "track" },
      title = { level = "track" },
    }
  },
  compiler = {
    date_added = { "date_added_youtube", "date_added_applemusic", "date_added_foobar" },
    manifests = { "id.toml", "cover_palette.toml", "history.toml" },
  },
})
