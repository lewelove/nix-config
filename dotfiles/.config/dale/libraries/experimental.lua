dl.library( "Experimental", {
  filters = { "default" },
  groupers = { "root_folder" },
  orders = { "default", "cover_mtime" },
  match = function(a)
    return true
  end
})

dl.filter( "exp_f", {
  match = function(a)
    return true
  end
})

dl.order( "cover_mtime", { label = "Cover Mtime",
  sort = function(a)
    local time = a.covers.main.file.mtime
    return time
  end
})

dl.grouper( "root_folder", { label = "First Order Folder",
  select = function(a)
    if a.id then
      local root = a.id:match("^([^/]+)")
      if root and root ~= "" then
        return root
      end
    end
    return "Unknown"
  end
})

