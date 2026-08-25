local root_dir = d.fs.normalize("~/dev/dale")

local function rust_bin(name)
  return d.fs.normalize(d.fs.joinpath(root_dir, "target/release", name))
end

local function py_bin(name)
  return d.fs.normalize(d.fs.joinpath(root_dir, "actions", name))
end

dale.action("open_terminal", {
  label = "Open Terminal",
  description = "Open terminal inside album directory",
  run = function(ctx)
    for _, entry in ipairs(ctx.albums) do
      d.system({ "alacritty" }, { cwd = entry.path, detach = true })
    end
  end
})

dale.action("open_config_in_terminal", {
  label = "Open Config in Terminal",
  description = "Open terminal inside Dale configuration directory",
  run = function(ctx)
    local config_dir = d.fs.normalize("~/.config/dale")
    d.system({ "alacritty", "-e", "sh", "-c", 'nvim -s <(printf " e")' }, { cwd = config_dir, detach = true })
  end
})

dale.action("theme", {
  label = "Generate Theme",
  description = "Extract dominant colors from album cover",
  run = function(ctx)
    local is_force = ctx.options:find("%-f") or ctx.options:find("%-%-force")
    for _, entry in ipairs(ctx.albums) do
      local args = {
        rust_bin("theme"),
        "--path", entry.path,
        "--algo", "kmeansnv",
        "--sort", "gradient",
        "--args", "k=12,n=12,d=0.0",
        "--threshold", "0.001",
        "--open-with", "nvl"
      }
      if is_force then
        table.insert(args, "--force")
      end
      d.system(args, { stdio = "inherit" })
    end
  end
})

dale.action("collect", {
  label = "Collect Metadata",
  description = "Fetch and scaffold album from Discogs or MusicBrainz URL",
  run = function(ctx)
    local url = d.str.trim(ctx.options)
    if url == "" then
      error("collect: URL argument is required in options")
    end

    local args = {
      rust_bin("collect"),
      "--url", url,
      "--root", d.fs.normalize("/run/media/lewelove/1000xhome/backup-everything/FB2K/Virtual Albums Stage/"),
      "--format-album", "{albumartist} - {album}",
      "--format-info", "Info"
    }

    d.system(args, { stdio = "inherit" })
  end
})

dale.action("embed", {
  label = "Embed Tags",
  description = "Embed metadata from album.lock.json into audio files",
  run = function(ctx)
    local is_auto = ctx.options:find("%-y") or ctx.options:find("%-%-auto")
    local keys = "album,albumartist,date,genre,comment,title,artist,musicbrainz_releasetrackid,replaygain_track_gain,replaygain_album_gain"

    for _, entry in ipairs(ctx.albums) do
      local args = {
        py_bin("embed"),
        "--path", entry.path,
        "--auto-cover",
        "--auto-convert-tracknumber",
        "--keys", keys
      }
      if is_auto then
        table.insert(args, "-y")
      end
      d.system(args, { stdio = ctx.isatty and "inherit" or "pipe" })
    end
  end
})

dale.action("rename", {
  label = "Rename Files",
  description = "Standardize track filenames according to metadata",
  run = function(ctx)
    local is_auto = ctx.options:find("%-y") or ctx.options:find("%-%-auto")
    for _, entry in ipairs(ctx.albums) do
      local args = { py_bin("rename"), "--path", entry.path }
      if is_auto then
        table.insert(args, "-y")
      end
      d.system(args, { stdio = ctx.isatty and "inherit" or "pipe" })
    end
  end
})

dale.action("lyrics", {
  label = "Fetch Lyrics",
  description = "Fetch track lyrics from Genius",
  run = function(ctx)
    local token = os.getenv("GENIUS_ACCESS_TOKEN")
    for _, entry in ipairs(ctx.albums) do
      local args = { py_bin("lyrics"), "--path", entry.path }
      if token then
        table.insert(args, "--token")
        table.insert(args, token)
      end
      d.system(args, { stdio = "inherit" })
    end
  end
})

dale.action("search_cover", {
  label = "Search Cover",
  description = "Search high-res artwork on MusicHoarders",
  run = function(ctx)
    for _, entry in ipairs(ctx.albums) do
      local artist = d.get(entry, "lock.album.albumartist") or d.get(entry, "lock.album.artist")
      local album = d.get(entry, "lock.album.album")
      local args = { py_bin("search_cover") }
      if artist and album then
        table.insert(args, "--artist")
        table.insert(args, artist)
        table.insert(args, "--album")
        table.insert(args, album)
      else
        table.insert(args, "--path")
        table.insert(args, entry.path)
      end
      d.system(args, { detach = true })
    end
  end
})

dale.action("cover_metrics", {
  label = "Cover Metrics",
  description = "Calculate chroma and entropy for album cover",
  run = function(ctx)
    local is_force = ctx.options:find("%-f") or ctx.options:find("%-%-force")
    for _, entry in ipairs(ctx.albums) do
      local args = { rust_bin("calculate_cover_metrics"), "--path", entry.path }
      if is_force then
        table.insert(args, "--force")
      end
      d.system(args, { stdio = "inherit" })
    end
  end
})

dale.action("mbs", {
  label = "MusicBrainz Search",
  description = "Search release groups on MusicBrainz",
  run = function(ctx)
    local launcher = (jit and jit.os == "OSX") and "open" or "xdg-open"

    local function search_mb(artist, title)
      local query
      if artist == "" then
        query = string.format('releasegroup:"%s"', title)
      elseif title == "" then
        query = string.format('artist:"%s"', artist)
      else
        query = string.format('artist:"%s" AND releasegroup:"%s"', artist, title)
      end

      local encoded = ""
      for c in query:gmatch(".") do
        if c:match("[%w_.~-]") then
          encoded = encoded .. c
        else
          encoded = encoded .. string.format("%%%02X", string.byte(c))
        end
      end

      local url = string.format(
        "https://musicbrainz.org/search?type=release_group&method=advanced&query=%s",
        encoded
      )
      d.system({ launcher, url }, { detach = true })
    end

    if #ctx.albums > 0 then
      for _, entry in ipairs(ctx.albums) do
        local artist = d.get(entry, "lock.album.albumartist") or d.get(entry, "lock.album.artist") or ""
        local title = d.get(entry, "lock.album.album") or ""
        if artist ~= "" or title ~= "" then
          search_mb(artist, title)
        end
      end
    elseif ctx.options and ctx.options ~= "" then
      local parts = d.str.split(ctx.options, " - ", true)
      if #parts >= 2 then
        search_mb(d.str.trim(parts[1]), d.str.trim(parts[2]))
      else
        search_mb("", d.str.trim(ctx.options))
      end
    end
  end
})

dale.action("css", {
  label = "Copy Search String",
  description = "Copy 'Artist - Album' search string to clipboard",
  run = function(ctx)
    local target = ctx.albums and ctx.albums[1]
    if not target then return end

    local artist = d.get(target, "lock.album.albumartist") or d.get(target, "lock.album.artist") or ""
    local title = d.get(target, "lock.album.album") or ""

    if artist ~= "" and title ~= "" then
      local query = string.format("%s - %s", artist, title)
      local clip_cmd = { "wl-copy" }
      d.system(clip_cmd, { stdin = query })
    end
  end
})
