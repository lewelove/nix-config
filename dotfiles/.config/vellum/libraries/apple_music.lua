vl.library( "apple_music", { label = "Apple Music",
  strict = true,
  groupers = { "year_added_applemusic", "genre", "decade" },
  orders = { "date_added_applemusic", "default", "az", "year" },
  match = function(a)
    local keys = a.keys or {}
    return keys.date_added_applemusic ~= nil
  end
})

vl.grouper( "year_added_applemusic", { label = "Year Added",
  strict = true,
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added_applemusic
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return nil
  end
})

vl.order( "date_added_applemusic", { label = "Date Added",
  strict = true,
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added_applemusic or ""
  end
})
