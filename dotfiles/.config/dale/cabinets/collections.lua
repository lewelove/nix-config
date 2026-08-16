dale.cabinet( "collections", { label = "Collections",
  shelves = {
    "hauntology",
    "ambient50",
    "virtual",
    "signalwave",
  },
  orders = {
    "az",
    "year",
    "date_added",
  }
})

dale.shelf( "virtual", { label = "Virtual Albums",
  match = function(a)
    local info = a.info or {}
    return info["virtual"] == true
  end,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added or ""
  end,
  reverse = true,
})

local ambient50_list = d.fs.read_lines("~/.config/dale/shelves/Ambient50.txt")

dale.shelf( "ambient50", { label = "Ambient 50",
  match = function(a)
    return ambient50_list[a.id]
  end,
  sort = function(a)
    return ambient50_list[a.id]
  end,
})

dale.shelf( "signalwave", { label = "Signalwave",
  match = function(a)
    local keys = a.keys or {}
    return contains(keys.genre, "Signalwave")
  end,
})

dale.shelf( "hauntology", { label = "Hauntology & Lost Futures",
  match = function(a)
    local artist = a.albumartist
    return artist == "The Caretaker"
        or artist == "Leyland Kirby"
        -- or artist == "V/Vm"
  end,
  sort = function(a)
    return a.album
  end
})
