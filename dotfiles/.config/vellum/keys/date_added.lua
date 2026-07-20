-- Album Library History Keys

vl.compile.album.key({ date_added_foobar = function(ctx, m)
  if m.history then
    key = m.history.album.date_added_foobar
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })

vl.compile.album.key({ date_added_applemusic = function(ctx, m)
  if m.history then
    key = m.history.album.date_added_applemusic
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })

vl.compile.album.key({ date_added_youtube = function(ctx, m)
  if m.history then
    key = m.history.album.date_added_youtube
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })
