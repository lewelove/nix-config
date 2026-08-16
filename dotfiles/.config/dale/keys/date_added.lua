dale.compile.album.key( "date_added_foobar", function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_foobar
    if key then
      return d.fn.type_check(key, "datetime")
    end
  end
end)

dale.compile.album.key( "date_added_applemusic", function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_applemusic
    if key then
      return d.fn.type_check(key, "datetime")
    end
  end
end)

dale.compile.album.key( "date_added_youtube", function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_youtube
    if key then
      return d.fn.type_check(key, "datetime")
    end
  end
end)

dale.compile.album.key( "date_added_dale", function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_dale
    if key then
      return d.fn.type_check(key, "datetime")
    end
  end
end)

dale.compile.album.key( "date_added", function(ctx, m)
  local earliest = nil

  if m.history and m.history.album then
    local h = m.history.album
    local candidate_keys = {
      "date_added_youtube",
      "date_added_applemusic",
      "date_added_foobar",
      "date_added_dale",
      "date_added_applemusic_unknown",
      "date_added_dale_unknown",
    }
    
    for _, key in ipairs(candidate_keys) do
      local date_str = h[key]
      if date_str and date_str ~= "" then
        if earliest == nil or date_str < earliest then
          earliest = date_str
        end
      end
    end
  end

  return d.fn.present(earliest)
end)
