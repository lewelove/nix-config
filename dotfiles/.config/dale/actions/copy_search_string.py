#!/usr/bin/env python3
import sys
import json
import subprocess

def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        sys.exit(1)

    albums = data.get("albums", [])
    lock = albums[0].get("lock")
    
    meta = lock.get("album", {})
    
    album_title = meta.get("album", "")
    album_artist = meta.get("albumartist", "")

    if album_artist and album_title:
        query = f'{album_artist} - {album_title}'
        # print(f'{query}')

    p = subprocess.Popen(
       ["wl-copy"],
       stdin=subprocess.PIPE,
    )

    p.communicate(query.encode())

if __name__ == "__main__":
    main()
