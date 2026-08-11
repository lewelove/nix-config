dale.library( "Experimental", {
  filters = { "default" },
  groupers = { "root_folder" },
  orders = { "default", "cover_mtime" },
  match = function(a)
    return true
  end
})

dale.filter( "exp_f", {
  match = function(a)
    return true
  end
})

dale.order( "cover_mtime", { label = "Cover Mtime",
  sort = function(a)
    local time = a.covers.main.file.mtime
    return time
  end
})

dale.grouper( "root_folder", { label = "First Order Folder",
  select = function(a)
    return d.fn.coalesce(a.id and a.id:match("^([^/]+)"), "Unknown")
  end
})
