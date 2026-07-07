-- Lewelove Vellum Config --

require("keys")

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
    manifests = { "mbid.toml", "cover_palette.toml" },
    file_subset_match = {
      "album", "albumartist", "date", "genre",
      "comment", "title", "artist", "tracknumber",
      "musicbrainz_albumartistid", "musicbrainz_albumid",
      "musicbrainz_releasegroupid", "musicbrainz_artistid",
      "musicbrainz_releasetrackid", "musicbrainz_trackid"
    },
  },
  actions = {
    ["get-lyrics"] = "~/dev/vellum/actions/get_lyrics/result/bin/get_lyrics",
    ["search-cover"] = "~/dev/vellum/actions/search_cover/result/bin/search_cover",
    ["cover-palette"] = "~/dev/vellum/actions/cover_palette/target/release/cover_palette",
  },
  interfaces = {
    default = {
      directory = "~/dev/vellum/interfaces/web-app",
      config = "./interface.toml",
    }
  }
})

vl.compiler.covers("thumbnail", {
  interpolation = "lanczos",
  size = 200,
})

vl.compiler.covers("modal", {
  interpolation = "mitchell",
  size = 627,
})
