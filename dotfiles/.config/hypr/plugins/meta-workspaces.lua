local range = 4
local current_meta = "Desktop"

local meta_workspaces = {
  Desktop = {
    key = "D",
  },
  Telecom = {
    key = "T",
    on_created_empty = programs.telegram_client,
  },
  Music = {
    key = "M",
    on_created_empty = programs.mpd_client,
  },
  Games = {
    key = "G",
    on_created_empty = programs.steam,
  },
  Image = {
    key = "I",
    on_created_empty = programs.photopea,
  },
  Notes = {
    key = "N",
    on_created_empty = programs.notes,
  },
  Alarms = {
    key = "Pause",
    name = "⏰",
    on_created_empty = programs.clock
  },
  System = {
    key = "Slash",
    name = "/",
    on_created_empty = programs.vpn
  }
}

for _, meta in pairs(meta_workspaces) do
  meta.last_active = 1
  if not meta.name then
    meta.name = meta.key
  end
end

local function switch_meta_workspace(meta_name)
  local active_ws = hl.get_active_workspace()
  local meta = meta_workspaces[meta_name]
  current_meta = meta_name
  local is_in_meta = false
  
  if active_ws and active_ws.name then
    local prefix = meta.name .. ":"
    if string.sub(active_ws.name, 1, string.len(prefix)) == prefix then
      is_in_meta = true
    end
  end
  
  if is_in_meta then
    meta.last_active = 1
    local target_ws = meta.name .. ":1"
    if active_ws.name == target_ws then
      local windows = hl.get_workspace_windows("name:" .. target_ws)
      if windows and #windows > 0 then
        local leftmost = windows[1]
        for _, w in ipairs(windows) do
          if w.at.x < leftmost.at.x then
            leftmost = w
          end
        end
        hl.dispatch(hl.dsp.focus({ window = "address:" .. leftmost.address }))
      end
    else
      hl.dispatch(hl.dsp.focus({ workspace = "name:" .. target_ws }))
    end
  else
    local target_ws = meta.name .. ":" .. tostring(meta.last_active)
    hl.dispatch(hl.dsp.focus({ workspace = "name:" .. target_ws }))
  end
end

local function switch_sub_workspace(sub_idx)
  local meta = meta_workspaces[current_meta]
  meta.last_active = sub_idx
  local target_ws = meta.name .. ":" .. tostring(sub_idx)
  hl.dispatch(hl.dsp.focus({ workspace = "name:" .. target_ws }))
end

local function move_to_meta_workspace(meta_name)
  local meta = meta_workspaces[meta_name]
  current_meta = meta_name
  local target_ws = meta.name .. ":" .. tostring(meta.last_active)
  hl.dispatch(hl.dsp.window.move({ workspace = "name:" .. target_ws }))
end

local function move_to_sub_workspace(sub_idx)
  local meta = meta_workspaces[current_meta]
  meta.last_active = sub_idx
  local target_ws = meta.name .. ":" .. tostring(sub_idx)
  hl.dispatch(hl.dsp.window.move({ workspace = "name:" .. target_ws }))
end

for _, meta in pairs(meta_workspaces) do
  if meta.on_created_empty then
    local target_ws = meta.name .. ":1"
    hl.workspace_rule({
      workspace = "name:" .. target_ws,
      on_created_empty = meta.on_created_empty
    })
  end
end

for name, meta in pairs(meta_workspaces) do
  hl.bind("SUPER + " .. meta.key, function()
    switch_meta_workspace(name)
  end)
  hl.bind("SUPER + SHIFT + " .. meta.key, function()
    move_to_meta_workspace(name)
  end)
end

for i = 1, range do
  local key = tostring(i)
  hl.bind("SUPER + " .. key, function()
    switch_sub_workspace(i)
  end)
  hl.bind("SUPER + SHIFT + " .. key, function()
    move_to_sub_workspace(i)
  end)
end
