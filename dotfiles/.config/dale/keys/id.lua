local function url_key(name, path, prefix)
  dale.compile.album.key(name, function(ctx, m)
    local raw = d.get(m, path)
    local id = d.fn.type_check(raw, "string")
    if id then return prefix .. id end
  end)
end

url_key(
  "musicbrainz_releasegroup_url",
  "id.album.musicbrainz_releasegroupid",
  "https://musicbrainz.org/release-group/"
)

url_key(
  "musicbrainz_release_url",
  "id.album.musicbrainz_albumid",
  "https://musicbrainz.org/release/"
)

url_key(
  "musicbrainz_albumartist_url",
  "id.album.musicbrainz_albumartistid",
  "https://musicbrainz.org/artist/"
)

url_key(
  "discogs_release_url",
  "id.album.discogs_releaseid",
  "https://discogs.com/release/"
)

url_key(
  "discogs_master_url",
  "id.album.discogs_masterid",
  "https://discogs.com/master/"
)

dale.compile.album.key("musicbrainz_release_url", function(ctx, m, i)
  local root = d.get(ctx, "paths.album_root")
  local json = d.fs.read_json(root .. "/Info/musicbrainz_release.json")
  local base = "https://musicbrainz.org/release/"
  local id = d.get(json, "id")
  return id and base .. id
end)

dale.compile.track.key("musicbrainz_releasetrackid", function(ctx, m, i)
  local root = d.get(ctx, "paths.album_root")
  local json = d.fs.read_json(root .. "/Info/musicbrainz_release.json")

  -- local title = d.get(m, "metadata", "tracks", i, "title")
  -- local mb_title = d.get(json, "media", 1, "tracks", i, "title")
  -- if mb_title and title ~= mb_title then
  --   error(string.format(
  --     "\nTrack %d title mismatch: \nmetadata = '%s' \nmusicbrainz = '%s'",
  --     i, title, mb_title
  --   ))
  -- end

  return d.get(json, "media", 1, "tracks", i, "id")
end)

-- dale.compile.track.key("musicbrainz_releasetrackid", function(ctx, m, i)
--   local raw = d.get(m, "id.tracks", i, "musicbrainz_releasetrackid")
--   return d.fn.type_check(raw, "string")
-- end)
