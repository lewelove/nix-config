-- album level keys

vl.compiler.keys.album({
  albumartists = { type = "array" },
  media = { type = "string" },
  date_added_foobar = { type = "datetime" },
  date_added_applemusic = { type = "datetime" },
  date_added_youtube = { type = "datetime" },
  custom_id = { type = "string" },
  custom_string = { type = "string" },
  old_comment = { type = "string" },
  collection = { type = "array" },
  shelves = { type = "array" },
  my_year = { type = "array" },
  replaygain_album_gain = { type = "string" },
  replaygain_album_peak = { type = "string" },
  musicbrainz_albumid = { type = "string" },
  musicbrainz_albumartistid = { type = "string" },
  musicbrainz_releasegroupid = { type = "string" },
  cover_palette = { type = "array" },
})

vl.compiler.keys.album({
  custom_albumartist = { 
    type = "string",
    output = function(v, ctx) 
        return v or ctx.album.artistartist or ctx.album.albumartist
    end
  },
})

vl.compiler.keys.album({
  cover_chroma = { 
    type = "float", 
    output = function(v, ctx) 
      return ctx.cover_metrics and ctx.cover_metrics.chroma
    end 
  },
})

vl.compiler.keys.album({
  cover_entropy = { 
    type = "integer", 
    output = function(v, ctx) 
      return ctx.cover_metrics and ctx.cover_metrics.entropy
    end 
  }
})

-- track level keys

vl.compiler.keys.tracks({
  lyrics = { type = "string" },
  accuripid = { type = "string" },
  ctdbid = { type = "string" },
  discid = { type = "string" },
  instrumental = { type = "boolean" },
  replaygain_track_gain = { type = "string" },
  replaygain_track_peak = { type = "string" },
  musicbrainz_trackid = { type = "string" },
  musicbrainz_releasetrackid = { type = "string" },
  musicbrainz_artistid = { type = "array" }
})
