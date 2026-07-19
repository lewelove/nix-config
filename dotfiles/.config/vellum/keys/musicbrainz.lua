-- MusicBrainz Database Keys

vl.compile.album.key({ musicbrainz_releasegroup_url = function(ctx, m)
    if not m.id then return nil end
    local url = "https://musicbrainz.org/release-group/"
    local key = vl.fn.type_check(m.id.album.musicbrainz_releasegroupid, "string")
    return key and (url .. key)
end })

vl.compile.album.key({ musicbrainz_release_url = function(ctx, m)
    if not m.id then return nil end
    local url = "https://musicbrainz.org/release/"
    local key = vl.fn.type_check(m.id.album.musicbrainz_albumid, "string")
    return key and (url .. key)
end })

vl.compile.album.key({ musicbrainz_albumartist_url = function(ctx, m)
    if not m.id then return nil end
    local url = "https://musicbrainz.org/artist/"
    local key = vl.fn.type_check(m.id.album.musicbrainz_albumartistid, "string")
    return key and (url .. key)
end })
