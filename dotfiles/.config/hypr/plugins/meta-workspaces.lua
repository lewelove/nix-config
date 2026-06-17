--- Meta Workspaces --------------------------------------------

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

}

-- Initialize dynamic state for tracking last active sub-workspace
for _, meta in pairs(meta_workspaces) do
  meta.last_active = 1
end

-- switching meta-workspaces retrieves and focuses the last active sub-workspace
local function switch_meta_workspace(meta_name)
  local active_ws = hl.get_active_workspace()
  local meta = meta_workspaces[meta_name]

  current_meta = meta_name

  -- Check if current workspace starts with this meta's key
  local is_in_meta = false
  if active_ws and active_ws.name then
    local prefix = meta.key .. ":"
    if string.sub(active_ws.name, 1, string.len(prefix)) == prefix then
      is_in_meta = true
    end
  end

  if is_in_meta then
    -- Reset back to index 1 if we're already on this meta
    meta.last_active = 1
    hl.dispatch(hl.dsp.focus({ workspace = "name:" .. meta.key .. ":1" }))
  else
    local target_ws = meta.key .. ":" .. tostring(meta.last_active)
    hl.dispatch(hl.dsp.focus({ workspace = "name:" .. target_ws }))
  end
end

-- switch sub-workspace (1 to range) using the current meta-workspace key
local function switch_sub_workspace(sub_idx)
  local meta = meta_workspaces[current_meta]
  meta.last_active = sub_idx
  local target_ws = meta.key .. ":" .. tostring(sub_idx)
  hl.dispatch(hl.dsp.focus({ workspace = "name:" .. target_ws }))
end

-- create workspace rules for default applications on sub-workspace 1
for _, meta in pairs(meta_workspaces) do
  if meta.on_created_empty then
    local target_ws = meta.key .. ":1"
    hl.workspace_rule({
      workspace = "name:" .. target_ws,
      on_created_empty = meta.on_created_empty
    })
  end
end

-- bind switching meta-workspaces
for name, meta in pairs(meta_workspaces) do
  hl.bind ("SUPER + " .. meta.key, function()
    switch_meta_workspace(name)
  end)
end

for i = 1, range do
  local key = tostring(i)
  hl.bind ("SUPER + " .. key, function()
    switch_sub_workspace(i)
  end)
end
