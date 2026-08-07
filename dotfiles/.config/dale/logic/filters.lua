dl.filter( "default", { label = "Default",
  match = function(a)
    return true
  end
})

dl.filter( "main_library", { label = "Main Library",
  match = function(a)
    local keys = a.keys or {}
    local info = a.info or {}
    if contains(keys.collection, "Vapor Memory") then return false end
    if contains(keys.genre, "Signalwave") or contains(keys.genre, "Vaporwave") then return false end
    if info["virtual"] == true then return false end
    return true
  end
})

dl.filter( "vapor_memory", { label = "Vapor Memory",
  match = function(a)
    local keys = a.keys or {}
    return contains(keys.collection, "Vapor Memory") or contains(keys.genre, "Vaporwave")
  end
})

dl.filter( "signal_memory", { label = "Signal Memory",
  match = function(a)
    local keys = a.keys or {}
    return contains(keys.genre, "Signalwave")
  end
})

dl.filter( "ambient_50", { label = "Ambient 50",
  match = function(a)
    local keys = a.keys or {}
    return contains_in_table(keys.shelves, "Ambient 50")
  end
})
