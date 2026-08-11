dale.grouper( "genre", { label = "Genre",
  select = function(a)
    local keys = a.keys or {}
    return keys.genre or "Unknown"
  end,
})

dale.grouper( "artists", { label = "Artists",
  index = true,
  select = function(a)
    local keys = a.keys or {}
    return d.fn.coalesce(keys.albumartists, a.albumartist, "Unknown")
  end,
  sort = function(val, a)
    return clean_artist(val):lower()
  end
})

dale.grouper( "decade", { label = "Decade",
  select = function(a)
    if a.date and #a.date >= 3 then
      return a.date:sub(1, 3) .. "0s"
    end
    return "Unknown"
  end
})

dale.grouper( "total_tracks", { label = "Total Tracks",
  select = function(a)
    local info = a.info or {}
    return tostring(info.total_tracks or 0)
  end
})

dale.grouper( "total_discs", { label = "Total Discs",
  select = function(a)
    local info = a.info or {}
    return tostring(info.total_discs or 1)
  end
})

dale.grouper( "year_added", { label = "Year Added",
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return "Unknown"
  end
})

dale.grouper( "chroma", { label = "Chroma",
  select = function(a)
    local keys = a.keys or {}
    local val = tonumber(keys.cover_chroma) or 0
    if val < 0.17 then return "Monochrome"
    elseif val < 21 then return "Bleak"
    elseif val < 45 then return "Standard"
    elseif val < 60 then return "Vivid"
    else return "Saturated" end
  end,
  sort = function(val, a)
    local keys = a.keys or {}
    return tonumber(keys.cover_chroma) or 0
  end,
  reverse = true
})
