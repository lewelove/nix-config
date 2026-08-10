-- lewelove's DALE Config --

require("helpers")

require("keys.default")
require("keys.date_added")
require("keys.id")
require("keys.verified")
require("keys.lyrics")

require("logic.filters")
require("logic.orders")
require("logic.groupers")

require("libraries.default")
require("libraries.apple_music")
require("libraries.foobar")
require("libraries.my_year")

require("libraries.experimental")

require("cabinets.collections")

require("interfaces.default")

require("actions")

dl.config({
  storage = {
    music_directory = "/run/media/lewelove/1000xhome/backup-everything/FB2K/Library Historyfied!/",
    environment = "~/.secrets/dale.env",
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
    manifests = { "id.toml", "history.toml" },
  },
})

dl.cache.cover({ filter = "catmullrom", size = 200 })
dl.cache.cover({ filter = "catmullrom", size = 627 })
dl.cache.cover({ filter = "catmullrom", size = 1040 })

