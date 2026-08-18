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

dale.compile.track.key("musicbrainz_releasetrackid", function(ctx, m, i)
  local raw = d.get(m, "id.tracks", i, "musicbrainz_releasetrackid")
  return d.fn.type_check(raw, "string")
end)
