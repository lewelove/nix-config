dl.library( "all_albums", { label = "All Albums",
  filters = {
    "main_library",
    "vapor_memory",
    "signal_memory",
  },
  groupers = {
    "genre",
    "decade",
    "artists",
    "total_discs",
    "total_tracks",
    "year_added",
    "chroma",
  },
  orders = {
    "default",
    "az",
    "year",
    "duration",
    "cover_hash",
    "chroma",
    "entropy",
    "date_added",
    "last_edited",
  },
  match = function(a)
    return true
  end
})
