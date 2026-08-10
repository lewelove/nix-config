dl.cabinet( "collections", { label = "Collections",
  shelves = {
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

dl.shelf( "virtual", { label = "Virtual Albums",
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

local ambient50_list = dl.fs.read_lines("~/.config/dale/shelves/Ambient50.txt")

dl.shelf( "ambient50", { label = "Ambient 50",
  match = function(a)
    return ambient50_list[a.id]
  end,
  sort = function(a)
    return ambient50_list[a.id]
  end,
})

dl.shelf( "signalwave", { label = "Signalwave",
  match = function(a)
    local keys = a.keys or {}
    return contains(keys.genre, "Signalwave")
  end,
})
