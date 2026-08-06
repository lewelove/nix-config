vl.library( "my_year", { label = "My Year",
  strict = true,
  groupers = { "my_year_grouper" },
  orders = { "default", "date_added" },
  match = function(a)
    local keys = a.keys or {}
    return keys.my_year ~= nil
  end
})

vl.grouper( "my_year_grouper", { label = "Year",
  strict = true,
  select = function(a)
    local keys = a.keys or {}
    return keys.my_year
  end
})

