-- Album Library History Keys

vl.compile.album.key({ date_added_foobar = function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_foobar
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })

vl.compile.album.key({ date_added_applemusic = function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_applemusic
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })

vl.compile.album.key({ date_added_youtube = function(ctx, m)
  if m.history then
    local key = m.history.album.date_added_youtube
    if key then
      return vl.fn.type_check(key, "datetime")
    end
  end
end })

-- Evaluates `album.info.date_added` globally
vl.compile.album.info.date_added(function(ctx, m)
  local earliest = nil

  if m.history and m.history.album then
    local h = m.history.album
    local candidates = {
      h.date_added_youtube,
      h.date_added_applemusic,
      h.date_added_foobar
    }
    
    for _, date_str in ipairs(candidates) do
      if date_str and date_str ~= "" then
        if earliest == nil or date_str < earliest then
          earliest = date_str
        end
      end
    end
  end

  if earliest then 
    return earliest 
  end

  -- Fallback to system.toml generic dates if no history targets matched
  if m.system and m.system.album and m.system.album.system then
    local sys = m.system.album.system
    if sys.date_added then return sys.date_added end
    if sys.date_generated then return sys.date_generated end
  end

  error("No valid 'date_added' or 'date_generated' could be found in history.toml or system.toml manifests.")
end)
