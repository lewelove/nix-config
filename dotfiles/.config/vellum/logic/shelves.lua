vl.shelf( "virtual", { label = "Virtual Albums",
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

local ambient50_list = vl.fs.read_lines("~/.config/vellum/shelves/Ambient50.txt")

vl.shelf( "ambient50", { label = "Ambient 50",
  match = function(a)
    return ambient50_list[a.id]
  end,
  sort = function(a)
    return ambient50_list[a.id]
  end
})

vl.shelf( "ambient_50", { label = "Ambient 50 by Date",
  match = function(a)
    local keys = a.keys or {}
    return contains_in_table(keys.shelves, "Ambient 50")
  end,
  sort = function(a)
    local date = a.date or ""
    local id = a.id or ""
    return { date, id }
  end
})

