dale.library( "foobar", { label = "Foobar2000",
  groupers = { "year_added_foobar" },
  orders = { "date_added_foobar" },
  match = function(a)
    local keys = a.keys or {}
    return keys.date_added_foobar ~= nil
  end
})

dale.grouper( "year_added_foobar", { label = "Year Added",
  select = function(a)
    local keys = a.keys or {}
    local d = keys.date_added_foobar
    if d and #d >= 4 then
      return d:sub(1, 4)
    end
    return nil
  end
})

dale.order( "date_added_foobar", { label = "Date Added",
  reverse = true,
  sort = function(a)
    local keys = a.keys or {}
    return keys.date_added_foobar or ""
  end
})
