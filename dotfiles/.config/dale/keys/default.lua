dl.compile.album.key( "albumartists", function(ctx, m)
  return m.metadata.album.albumartists
end)

dl.compile.album.key( "media", function(ctx, m)
  return m.metadata.album.media
end)

dl.compile.album.key( "collection", function(ctx, m)
  return m.metadata.album.collection
end)

dl.compile.album.key( "shelves", function(ctx, m)
  return m.metadata.album.shelves
end)

dl.compile.album.key( "my_year", function(ctx, m)
  return m.metadata.album.my_year
end)

dl.compile.album.key( "replaygain_album_gain", function(ctx, m)
  return m.metadata.album.replaygain_album_gain
end)

dl.compile.album.key( "genre", function(ctx, m)
  local g = m.metadata.album.genre
  if g == nil or g == "" then
    return { "Unknown" }
  end
  return g
end)

dl.compile.album.key( "comment", function(ctx, m)
  local country = m.metadata.album.country or ""
  local label = m.metadata.album.label or ""
  local cat = m.metadata.album.catalognumber or ""

  if country ~= "" or label ~= "" or cat ~= "" then
      local year = m.metadata.album.release_date and string.sub(m.metadata.album.release_date, 1, 4) or ""
      local parts = {}
      if year ~= "" then table.insert(parts, year) end
      if country ~= "" then table.insert(parts, country) end
      if label ~= "" then table.insert(parts, label) end
      if cat ~= "" then table.insert(parts, cat) end
      return table.concat(parts, " ")
  else
      local c = m.metadata.album.comment
      if c ~= nil and c ~= "" then
          return dl.fn.type_check(c, "string")
      end
  end
end)

dl.compile.album.key( "custom_albumartist", function(ctx, m)
  return m.metadata.album.custom_albumartist or m.metadata.album.artistartist or m.metadata.album.albumartist
end)

dl.compile.album.key( "cover_chroma", function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.chroma
end)

dl.compile.album.key( "cover_entropy", function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.entropy
end)

dl.compile.tracks.key( "ctdbid", function(ctx, m, i)
  return dl.fn.type_check(m.metadata.tracks[i].ctdbid, "string")
end)

dl.compile.tracks.key( "instrumental", function(ctx, m, i)
  return dl.fn.type_check(m.metadata.tracks[i].instrumental, "boolean")
end)

dl.compile.tracks.key( "replaygain_track_gain", function(ctx, m, i)
  return dl.fn.type_check(m.metadata.tracks[i].replaygain_track_gain, "string")
end)

dl.compile.tracks.key( "embedded", function(ctx, m, i)
  return ctx.tracks[i].embedded
end)
