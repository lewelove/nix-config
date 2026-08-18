dale.library("Experimental", {
  filters = { "default" },
  groupers = { "root_folder" },
  orders = { "default", "cover_mtime" },
  match = function(a) return true end,
})

dale.filter("exp_f", {
  match = function(a) return true end,
})

dale.order("cover_mtime", { label = "Cover Mtime",
  sort = function(a) return d.get(a, "covers.main.file.mtime") end,
})

dale.grouper("root_folder", { label = "First Order Folder",
  select = function(a)
    local id = d.get(a, "id")
    local folder = id and id:match("^([^/]+)")
    return d.fn.coalesce(folder, "Unknown")
  end,
})
