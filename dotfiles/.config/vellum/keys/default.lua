-- album level keys

vl.compile.album.key({ albumartists = function(ctx, m)
  return m.metadata.album.albumartists
end })

vl.compile.album.key({ media = function(ctx, m)
  local key = m.metadata.album.media
  return key
end })

vl.compile.album.key({ collection = function(ctx, m)
  return m.metadata.album.collection
end })

vl.compile.album.key({ shelves = function(ctx, m)
  return m.metadata.album.shelves
end })

vl.compile.album.key({ my_year = function(ctx, m)
  return m.metadata.album.my_year
end })

vl.compile.album.key({ replaygain_album_gain = function(ctx, m)
  return m.metadata.album.replaygain_album_gain
end })

vl.compile.album.key({ cover_palette = function(ctx, m)
  if m.cover_palette then
    return vl.fn.type_check(m.cover_palette.album.cover_palette, "array")
  end
end })

vl.compile.album.key({ genre = function(ctx, m)
  local g = m.metadata.album.genre
  if g == nil or g == "" then
    return { "Unknown" }
  end
  return g
end })

vl.compile.album.key({ comment = function(ctx, m)
  local c = m.metadata.album.comment
  if c ~= nil and c ~= "" then
      return vl.fn.type_check(c, "string")
  end
  local country = m.metadata.album.country or ""
  local label = m.metadata.album.label or ""
  local cat = m.metadata.album.catalognumber or ""
  local year = m.metadata.album.date and string.sub(m.metadata.album.date, 1, 4) or ""
  local parts = {}
  if year ~= "" then table.insert(parts, year) end
  if country ~= "" then table.insert(parts, country) end
  if label ~= "" then table.insert(parts, label) end
  if cat ~= "" then table.insert(parts, cat) end
  return table.concat(parts, " ")
end })

vl.compile.album.key({ custom_albumartist = function(ctx, m)
  return m.metadata.album.custom_albumartist or m.metadata.album.artistartist or m.metadata.album.albumartist
end })

vl.compile.album.key({ cover_chroma = function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.chroma
end })

vl.compile.album.key({ cover_entropy = function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.entropy
end })

-- Track Level Keys

vl.compile.tracks.key({ ctdbid = function(ctx, m, i)
  return vl.fn.type_check(m.metadata.tracks[i].ctdbid, "string")
end })

vl.compile.tracks.key({ instrumental = function(ctx, m, i)
  return vl.fn.type_check(m.metadata.tracks[i].instrumental, "boolean")
end })

vl.compile.tracks.key({ replaygain_track_gain = function(ctx, m, i)
  return vl.fn.type_check(m.metadata.tracks[i].replaygain_track_gain, "string")
end })

vl.compile.tracks.key({ embedded = function(ctx, m, i)
  return ctx.tracks[i].embedded
end })
-- vl.compile.tracks.key({ musicbrainz_artistid = function(ctx, m, i) return vl.fn.type_check(m.metadata.tracks[i].musicbrainz_artistid, "array") end })
