dl.cabinet( "collections", { label = "Collections",
  shelves = {
    "virtual",
    "ambient50",
  },
  orders = {
    "az",
    "year",
    "date_added",
  }
})

dl.shelf( "virtual", { label = "Virtual Albums",
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added or ""
  end,
  reverse = true,
  match = function(a)
    local info = a.info or {}
    return info["virtual"] == true
  end
})

local ambient50_list = dl.fs.read_lines("~/.config/dale/shelves/Ambient50.txt")

dl.shelf( "ambient50", { label = "Ambient 50",
  match = function(a)
    return ambient50_list[a.id]
  end,
  sort = function(a)
    return ambient50_list[a.id]
  end
})
