vl.actions({ cover_palette = {
  run = "~/dev/vellum/actions/target/release/cover_palette",
  config = {
    type = "kmeansnv",
    sort = "gradient",
    args = "k=12,n=12,d=0.0",
    threshold = 0.001
  }
}})

vl.actions({ search_cover = {
  run = "~/dev/vellum/actions/search_cover/result/bin/search_cover"
}})

vl.actions({ get_lyrics = {
  run = "~/dev/vellum/actions/get_lyrics/result/bin/get_lyrics"
}})
