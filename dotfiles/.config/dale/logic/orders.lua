dl.order( "default", { label = "Default",
  sort = function(a)
    local keys = a.keys or {}
    local raw_artist = keys.custom_albumartist or a.albumartist or ""
    return { clean_artist(raw_artist):lower(), a.date or "", (a.album or ""):lower() }
  end
})

dl.order( "az", { label = "Alphabetical",
  sort = function(a)
    return (a.album or ""):lower()
  end
})

dl.order( "year", { label = "Year",
  reverse = true,
  sort = function(a)
    return a.date or ""
  end
})

dl.order( "duration", { label = "Duration",
  reverse = true,
  sort = function(a)
    local info = a.info or {}
    return tonumber(info.duration_milliseconds) or 0
  end
})

dl.order( "cover_hash", { label = "Random",
  sort = function(a)
    if a.covers and a.covers.main and a.covers.main.file then
      return a.covers.main.file.address or ""
    end
    return ""
  end
})

dl.order( "chroma", { label = "Chroma",
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return tonumber(keys.cover_chroma) or 0
  end
})

dl.order( "entropy", { label = "Entropy",
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return tonumber(keys.cover_entropy) or 0
  end
})

dl.order( "date_added", { label = "Date Added",
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added or ""
  end
})

dl.order( "last_edited", { label = "Last Edited",
  reverse = true,
  sort = function(a)
    local max_mtime = 0

    if type(a.manifests) == "table" then
      for _, manifest in pairs(a.manifests) do
        if type(manifest) == "table" and type(manifest.file) == "table" then
          local mtime = tonumber(manifest.file.mtime) or 0
          if mtime > max_mtime then
            max_mtime = mtime
          end
        end
      end
    end

    if type(a.tracks) == "table" then
      for _, track in ipairs(a.tracks) do
        if type(track) == "table" and type(track.file) == "table" then
          local mtime = tonumber(track.file.mtime) or 0
          if mtime > max_mtime then
            max_mtime = mtime
          end
        end
      end
    end

    return max_mtime
  end
})

