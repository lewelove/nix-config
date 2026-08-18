dale.grouper("genre", { label = "Genre",
  select = function(a) return d.get(a, "keys.genre") or "Unknown" end,
})

dale.grouper("styles", { label = "Styles",
  select = function(a)
    local styles = d.get(a, "keys.styles")
    if not styles or (type(styles) == "table" and #styles == 0) then return "Unknown" end
    return styles
  end,
})

dale.grouper("artists", { label = "Artists",
  index = true,
  select = function(a)
    local albumartists = d.get(a, "keys.albumartists")
    local albumartist = d.get(a, "albumartist")
    return d.fn.coalesce(albumartists, albumartist, "Unknown")
  end,
  sort = function(val, a)
    local cleaned = clean_artist(val)
    return cleaned:lower()
  end,
})

dale.grouper("decade", { label = "Decade",
  select = function(a)
    local date = d.get(a, "date")
    if date and #date >= 3 then return date:sub(1, 3) .. "0s" end
    return "Unknown"
  end,
})

dale.grouper("year", { label = "Year",
  select = function(a)
    local date = d.get(a, "date")
    if date and #date >= 4 then return date:sub(1, 4) end
    return "Unknown"
  end,
})

dale.grouper("total_tracks", { label = "Total Tracks",
  select = function(a)
    local tracks = d.get(a, "info.total_tracks") or 0
    return tostring(tracks)
  end,
})

dale.grouper("total_discs", { label = "Total Discs",
  select = function(a)
    local discs = d.get(a, "info.total_discs") or 1
    return tostring(discs)
  end,
})

dale.grouper("year_added", { label = "Year Added",
  select = function(a)
    local date = d.get(a, "keys.date_added")
    if date and #date >= 4 then return date:sub(1, 4) end
    return "Unknown"
  end,
})

dale.grouper("chroma", { label = "Chroma",
  reverse = true,
  select = function(a)
    local raw = d.get(a, "keys.cover_chroma")
    local val = tonumber(raw) or 0
    if val < 0.17 then return "Monochrome"
    elseif val < 21 then return "Bleak"
    elseif val < 45 then return "Standard"
    elseif val < 60 then return "Vivid"
    else return "Saturated" end
  end,
  sort = function(val, a)
    local raw = d.get(a, "keys.cover_chroma")
    return tonumber(raw) or 0
  end,
})
