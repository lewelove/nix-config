local function find_lyrics_file(ctx, m, i)
  local track = m.metadata.tracks[i]
  if not track then return nil, "txt" end

  local disc = track.discnumber or 1
  local track_no = track.tracknumber or i
  local album_root = ctx.paths and ctx.paths.album_root or ""
  if album_root == "" then return nil, "txt" end

  local total_discs = ctx.total_discs or 1
  local folders = { album_root .. "/Lyrics", album_root .. "/lyrics" }

  -- Leading digit patterns (ignores all title text after the track number)
  local patterns = {}
  if total_discs > 1 then
    -- Multi-disc patterns: "1.19 - ...", "01.19 - ...", "1-19 - ...", "119 - ..."
    table.insert(patterns, string.format("^0*%d%%.0*%d[%%s%%._%%-]", disc, track_no))
    table.insert(patterns, string.format("^0*%d%%-0*%d[%%s%%._%%-]", disc, track_no))
    table.insert(patterns, string.format("^%d%02d[%%s%%._%%-]", disc, track_no))
  end
  -- Track number prefix pattern: "19 - ...", "019 - ...", "19.txt", "19_..."
  table.insert(patterns, string.format("^0*%d[%%s%%._%%-]", track_no))

  for _, folder in ipairs(folders) do
    if dl.fs.exists(folder) then
      local p = io.popen('ls -1 "' .. folder .. '" 2>/dev/null')
      if p then
        for filename in p:lines() do
          for _, pat in ipairs(patterns) do
            if filename:find(pat) then
              p:close()
              local ext = filename:match("%.([^.]+)$")
              local fmt = (ext == "lrc") and "lrc" or "txt"
              local full_path = folder .. "/" .. filename
              return full_path, fmt
            end
          end
        end
        p:close()
      end
    end
  end

  return nil, "txt"
end

dl.compile.track.lyrics({
  type = function(ctx, m, i)
    local _, fmt = find_lyrics_file(ctx, m, i)
    return fmt
  end,
  text = function(ctx, m, i)
    local file_path, _ = find_lyrics_file(ctx, m, i)
    if file_path then
      return dl.fs.read(file_path)
    end
    return nil
  end
})
