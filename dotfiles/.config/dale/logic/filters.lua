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
