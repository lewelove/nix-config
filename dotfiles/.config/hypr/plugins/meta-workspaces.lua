--- Meta Workspaces --------------------------------------------

local current_meta = "Desktop"

local meta_workspaces = {

  -- Name = {
  --   key = "",
  --   offset = ,
  --   last_active = ,
  --   on_created_empty = ,
  -- },

  Desktop = {
    key = "D",
    offset = 0,
    last_active = 1,
  },

  Telecom = {
    key = "T",
    offset = 4,
    last_active = 5,
    on_created_empty = programs.telegram_client,
  },

  Music = {
    key = "M",
    offset = 8,
    last_active = 9,
    on_created_empty = programs.mpd_client,
  },

  Games = {
    key = "G",
    offset = 12,
    last_active = 13,
    on_created_empty = programs.steam,
  },

  Image = {
    key = "I",
    offset = 16,
    last_active = 17,
    on_created_empty = programs.photopea,
  },

  Notes = {
    key = "N",
    offset = 20,
    last_active = 21,
    on_created_empty = programs.notes,
  },

}

-- switching meta-workspaces retrieves and focuses the last active sub-workspace
local function switch_meta_workspace(meta_name)
  local active_ws = hl.get_active_workspace()
  local meta = meta_workspaces[meta_name]
  local start_ws = meta.offset + 1
  local end_ws = meta.offset + 4

  current_meta = meta_name

  if active_ws and active_ws.id >= start_ws and active_ws.id <= end_ws then
    meta.last_active = start_ws
    hl.dispatch(hl.dsp.focus({ workspace = tostring(start_ws) }))
  else
    local target_ws = meta.last_active
    hl.dispatch(hl.dsp.focus({ workspace = tostring(target_ws) }))
  end
end

-- switch sub-workspace (1-4) using the current meta-workspace offset
local function switch_sub_workspace(sub_idx)
  local target_ws = meta_workspaces[current_meta].offset + sub_idx
  meta_workspaces[current_meta].last_active = target_ws
  hl.dispatch(hl.dsp.focus({ workspace = tostring(target_ws) }))
end

-- create workspace rules for default applications on sub-workspace 1
for _, meta in pairs(meta_workspaces) do
  if meta.on_created_empty then
    local target_ws = meta.offset + 1
    hl.workspace_rule({
      workspace = tostring(target_ws),
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

for i = 1, 4 do
  local key = i
  
  hl.bind ("SUPER + " .. key, function()
    switch_sub_workspace(i)
  end)
end
