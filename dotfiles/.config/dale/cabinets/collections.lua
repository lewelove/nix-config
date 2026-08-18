dale.cabinet("collections", { label = "Collections",
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
  },
})

dale.shelf("virtual", { label = "Virtual Albums",
  reverse = true,
  match = function(a)
    return d.get(a, "info.virtual") == true
  end,
  sort = function(a)
    return d.get(a, "keys.date_added") or ""
  end,
})

local ambient50 = d.fs.read_lines("~/.config/dale/shelves/Ambient50.txt")

dale.shelf("ambient50", { label = "Ambient 50",
  match = function(a)
    local id = d.get(a, "id")
    return ambient50[id]
  end,
  sort = function(a)
    local id = d.get(a, "id")
    return ambient50[id]
  end,
})

dale.shelf("signalwave", { label = "Signalwave",
  match = function(a)
    local genre = d.get(a, "keys.genre")
    return contains(genre, "Signalwave")
  end,
})

dale.shelf("hauntology", { label = "Hauntology & Lost Futures",
  match = function(a)
    local artist = d.get(a, "albumartist")
    return artist == "The Caretaker"
        or artist == "Leyland Kirby"
  end,
  sort = function(a)
    return d.get(a, "album")
  end,
})
