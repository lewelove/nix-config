dale.library( "my_year", { label = "My Year",
  groupers = {
    "my_year_grouper",
  },
  orders = {
    "default",
    "date_added",
  },
  match = function(a)
    local keys = a.keys or {}
    return keys.my_year ~= nil
  end
})

dale.grouper( "my_year_grouper", { label = "Year",
  select = function(a)
    local keys = a.keys or {}
    return keys.my_year
  end
})
