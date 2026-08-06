local function sanitize_filename(name)
  if not name then return "" end
  return name:gsub('[<>:"/\\|?*]', '_')
end

local function find_lyrics_file(ctx, m, i)
  local track = m.metadata.tracks[i]
  if not track then return nil, "txt" end

  local disc = track.discnumber or 1
  local track_no = string.format("%02d", track.tracknumber or i)
  local title = sanitize_filename(track.title)
  local album_root = ctx.paths and ctx.paths.album_root or ""
  if album_root == "" then return nil, "txt" end

  local total_discs = ctx.total_discs or 1

  local names = {}
  if total_discs > 1 then
    table.insert(names, string.format("%d.%s - %s", disc, track_no, title))
    table.insert(names, string.format("%d.%s", disc, track_no))
  else
    table.insert(names, string.format("%s - %s", track_no, title))
    table.insert(names, track_no)
  end

  local folders = { album_root .. "/Lyrics", album_root .. "/lyrics" }
  local exts = { { ext = ".lrc", fmt = "lrc" }, { ext = ".txt", fmt = "txt" } }

  for _, folder in ipairs(folders) do
    for _, name in ipairs(names) do
      for _, item in ipairs(exts) do
        local file_path = folder .. "/" .. name .. item.ext
        if vl.fs.exists(file_path) then
          return file_path, item.fmt
        end
      end
    end
  end

  return nil, "txt"
end

vl.compile.track.lyrics({
  type = function(ctx, m, i)
    local _, fmt = find_lyrics_file(ctx, m, i)
    return fmt
  end,
  text = function(ctx, m, i)
    local file_path, _ = find_lyrics_file(ctx, m, i)
    if file_path then
      return vl.fs.read(file_path)
    end
    return nil
  end
})
