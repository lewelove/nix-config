function contains(val, target)
  if type(val) == "string" then
    return val:find(target, 1, true) ~= nil
  elseif type(val) == "table" then
    for _, item in ipairs(val) do
      if tostring(item):find(target, 1, true) then return true end
    end
  end
  return false
end

function clean_artist(artist)
  if not artist or artist == "" then return "" end
  local lower = artist:lower()
  if lower:sub(1, 4) == "the " then
    return artist:sub(5)
  end
  return artist
end

--- Checks if a value exists within a Lua table (array, key-value map, or nested tables).
--- @param tbl table|any The table to search through
--- @param target any The value or substring to look for
--- @param exact boolean|nil If true, uses exact equality (==); if false, performs substring search on strings (default: true)
--- @return boolean
function contains_in_table(tbl, target, exact)
  if type(tbl) ~= "table" or target == nil then
    return false
  end

  local is_exact = (exact == nil or exact == true)

  for _, val in pairs(tbl) do
    if is_exact then
      if val == target then
        return true
      end
    else
      if type(val) == "string" and type(target) == "string" then
        if val:find(target, 1, true) ~= nil then
          return true
        end
      elseif tostring(val) == tostring(target) then
        return true
      end
    end

    -- Recurse if the table contains nested sub-tables
    if type(val) == "table" and contains_in_table(val, target, exact) then
      return true
    end
  end

  return false
end
