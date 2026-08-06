vl.library( "all_albums", { label = "All Albums",
  filters = { "main_library", "vapor_memory", "signal_memory" },
  match = function(a)
    return true
  end
})
