vl.library( "foobar", { label = "Foobar2000",
  strict = true,
  groupers = { "year_added_foobar" },
  orders = { "date_added_foobar" },
  match = function(a)
    local keys = a.keys or {}
    return keys.date_added_foobar ~= nil
  end
})

vl.grouper( "year_added_foobar", { label = "Year Added",
  strict = true,
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added_foobar
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return nil
  end
})

vl.order( "date_added_foobar", { label = "Date Added",
  strict = true,
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added_foobar or ""
  end
})

