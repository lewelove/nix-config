dl.library( "apple_music", { label = "Apple Music",
  groupers = {
    "year_added_applemusic",
    "genre",
    "decade",
  },
  orders = {
    "date_added_applemusic",
    "default",
    "az",
    "year",
  },
  match = function(a)
    local keys = a.keys or {}
    return keys.date_added_applemusic ~= nil
  end
})

dl.grouper( "year_added_applemusic", { label = "Year Added",
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added_applemusic
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return nil
  end
})

dl.order( "date_added_applemusic", { label = "Date Added",
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added_applemusic or ""
  end
})
