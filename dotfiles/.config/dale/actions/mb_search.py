#!/usr/bin/env python3
import sys
import json
import urllib.parse
import subprocess

def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        sys.exit(1)

    albums = data.get("albums", [])
    
    for album_lock in albums:
        album_meta = album_lock.get("album", {})
        
        album_title = album_meta.get("album", "")
        album_artist = album_meta.get("albumartist", "")

        if album_artist and album_title:
            query = f'artist:"{album_artist}" AND release:"{album_title}"'
        elif album_artist:
            query = f'artist:"{album_artist}"'
        elif album_title:
            query = f'release:"{album_title}"'
        else:
            continue

        query_encoded = urllib.parse.quote(query)
        url = f"https://musicbrainz.org/search?type=release&method=advanced&query={query_encoded}"

        subprocess.Popen(
            ["chromium-browser", f"--app={url}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )

if __name__ == "__main__":
    main()
