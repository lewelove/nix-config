dale.compile.album.key( "verified", function(ctx, m)

  if not m.history then return nil end

  local meta_album = m.metadata and m.metadata.album or {}
  local hist_album = m.history.album or {}

  if hist_album.albumartist and meta_album.albumartist ~= hist_album.albumartist then
      error(string.format("Albumartist diverged! Metadata: '%s' | History: '%s'", 
            tostring(meta_album.albumartist), tostring(hist_album.albumartist)))
  end

  if hist_album.album and meta_album.album ~= hist_album.album then
      error(string.format("Album diverged! Metadata: '%s' | History: '%s'", 
            tostring(meta_album.album), tostring(hist_album.album)))
  end

  if hist_album.date and meta_album.date ~= hist_album.date then
      error(string.format("Date diverged! Metadata: '%s' | History: '%s'", 
            tostring(meta_album.date), tostring(hist_album.date)))
  end

  return nil

end)
