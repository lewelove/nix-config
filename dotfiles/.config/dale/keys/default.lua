dale.compile.album.key( "albumartists", function(ctx, m)
  return m.metadata.album.albumartists
end)

dale.compile.album.key( "media", function(ctx, m)
  return m.metadata.album.media
end)

dale.compile.album.key( "collection", function(ctx, m)
  return m.metadata.album.collection
end)

dale.compile.album.key( "shelves", function(ctx, m)
  return m.metadata.album.shelves
end)

dale.compile.album.key( "my_year", function(ctx, m)
  return m.metadata.album.my_year
end)

dale.compile.album.key( "replaygain_album_gain", function(ctx, m)
  return m.metadata.album.replaygain_album_gain
end)

dale.compile.album.key( "genre", function(ctx, m)
  return d.fn.coalesce(m.metadata.album.genre, { "Unknown" })
end)

dale.compile.album.key( "styles", function(ctx, m)
  local path = ctx.paths.album_root .. "/Info/discogs_master.json"
  local discogs = d.fs.read_json(path)
  return discogs and discogs.styles
end)

dale.compile.album.key( "comment", function(ctx, m)
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
          return d.fn.type_check(c, "string")
      end
  end
end)

dale.compile.album.key( "custom_albumartist", function(ctx, m)
  return d.fn.coalesce(m.metadata.album.custom_albumartist, m.metadata.album.artistartist, m.metadata.album.albumartist)
end)

dale.compile.album.key( "cover_chroma", function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.chroma
end)

dale.compile.album.key( "cover_entropy", function(ctx, m)
  return ctx.cover_metrics and ctx.cover_metrics.entropy
end)

dale.compile.tracks.key( "ctdbid", function(ctx, m, i)
  return d.fn.type_check(m.metadata.tracks[i].ctdbid, "string")
end)

dale.compile.tracks.key( "instrumental", function(ctx, m, i)
  return d.fn.type_check(m.metadata.tracks[i].instrumental, "boolean")
end)

dale.compile.tracks.key( "replaygain_track_gain", function(ctx, m, i)
  return d.fn.type_check(m.metadata.tracks[i].replaygain_track_gain, "string")
end)

dale.compile.tracks.key( "embedded", function(ctx, m, i)
  return ctx.tracks[i].embedded
end)
