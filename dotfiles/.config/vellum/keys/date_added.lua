-- Album Library History Keys

vl.compile.album.key({ date_added_foobar = function(ctx, m)
  return vl.fn.type_check(m.metadata.album.date_added_foobar, "datetime")
end })

vl.compile.album.key({ date_added_applemusic = function(ctx, m)
  return vl.fn.type_check(m.metadata.album.date_added_applemusic, "datetime")
end })

vl.compile.album.key({ date_added_youtube = function(ctx, m)
  return vl.fn.type_check(m.metadata.album.date_added_youtube, "datetime")
end })

