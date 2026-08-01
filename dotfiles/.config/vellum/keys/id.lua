-- MusicBrainz URL generation from database keys

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

-- Discogs URL generation from database keys

vl.compile.album.key({ discogs_release_url = function(ctx, m)
    if not m.id then return nil end
    local url = "https://discogs.com/release/"
    local key = vl.fn.type_check(m.id.album.discogs_releaseid, "string")
    return key and (url .. key)
end })

vl.compile.album.key({ discogs_master_url = function(ctx, m)
    if not m.id then return nil end
    local url = "https://discogs.com/master/"
    local key = vl.fn.type_check(m.id.album.discogs_masterid, "string")
    return key and (url .. key)
end })

-- MusicBrainz database track key for future embed

vl.compile.track.key({ musicbrainz_releasetrackid = function(ctx, m, i)
    if not m.id or not m.id.tracks or not m.id.tracks[i] then return nil end
    local key = vl.fn.type_check(m.id.tracks[i].musicbrainz_releasetrackid, "string")
    return key
end })
