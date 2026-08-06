vl.grouper( "genre", { label = "Genre",
  select = function(a)
    local keys = a.keys or {}
    return keys.genre or "Unknown"
  end
})

vl.grouper( "artists", { label = "Artists",
  index = true,
  select = function(a)
    local keys = a.keys or {}
    if keys.albumartists and #keys.albumartists > 0 then
      return keys.albumartists
    end
    return a.albumartist or "Unknown"
  end
})

vl.grouper( "decade", { label = "Decade",
  select = function(a)
    if a.date and #a.date >= 3 then
      return a.date:sub(1, 3) .. "0s"
    end
    return "Unknown"
  end
})

vl.grouper( "total_tracks", { label = "Total Tracks",
  select = function(a)
    local info = a.info or {}
    return tostring(info.total_tracks or 0)
  end
})

vl.grouper( "total_discs", { label = "Total Discs",
  select = function(a)
    local info = a.info or {}
    return tostring(info.total_discs or 1)
  end
})

vl.grouper( "year_added", { label = "Year Added",
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return "Unknown"
  end
})

vl.grouper( "chroma", { label = "Chroma",
  select = function(a)
    local keys = a.keys or {}
    local val = tonumber(keys.cover_chroma) or 0
    if val < 0.17 then return "0"
    elseif val < 15 then return "15"
    elseif val < 30 then return "30"
    elseif val < 45 then return "45"
    elseif val < 60 then return "60"
    elseif val < 80 then return "80"
    else return "80+" end
  end
})
