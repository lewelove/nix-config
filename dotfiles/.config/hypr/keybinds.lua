--- System -----------------------------------------------------

-- kill hyprland and escape to tty
hl.bind("CONTROL + ALT + Escape", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + E", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Tab", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- cycle focus through windows
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))

-- move/resize windows with lmb/rmb and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- powermenu
hl.bind("CONTROL + ALT + Delete", hl.dsp.exec_cmd("powermenu.sh"))


--- Control ----------------------------------------------------

-- audio devices
hl.bind("SUPER + F1", hl.dsp.exec_cmd("pactl set-default-sink EDIFIER-R1380DB-EQ-SPL90-20260609"))
hl.bind("SUPER + F2", hl.dsp.exec_cmd("pactl set-default-sink AIYIMA-DAC-A5-PRO-SWAP"))
hl.bind("SUPER + F3", hl.dsp.exec_cmd("pactl set-default-sink REDMI-BUDS-6-ACTIVE-EQ"))

-- audio volume
hl.bind("KP_Add", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { repeating = true })
hl.bind("KP_Subtract", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"), { repeating = true })

--- Programs ---------------------------------------------------

local terminal = "alacritty"
local browser = "zen-beta"
local file_manager = "thunar"

local calculator = "gnome-calculator"
local notes = "nvl -c 'cd ~/Notes' -c 'startinsert'"

local password_manager = "flatpak run com.bitwarden.desktop"
local telegram_client = "AyuGram"
local mpd_client = "chromium-browser --app=http://localhost:5173/"

local menu = "fuzzel"
local bookmarks = "fuzzel-bookmarks.sh"

local steam = "steam-isp"
local photopea = "chromium-browser --app=https://photopea.com"

local lab_ssh = "ssh lab"

--- Programs Keys ----------------------------------------------

hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + KP_Multiply", hl.dsp.exec_cmd(calculator))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(password_manager))
hl.bind("SUPER + Grave", hl.dsp.exec_cmd(bookmarks))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " -e " .. lab_ssh))

-- mpd client
hl.bind("CONTROL + Space", hl.dsp.exec_cmd("rmpc togglepause"))
hl.bind("CONTROL + Pause", hl.dsp.exec_cmd("rmpc single oneshot"))
hl.bind("CONTROL + SHIFT + Pause", hl.dsp.exec_cmd("rmpc single off"))

-- screenshots
local screenshot = "~/.config/hypr/scripts/screenshot.sh"
hl.bind("PRINT", hl.dsp.exec_cmd(screenshot .. " output"))
hl.bind("CONTROL + PRINT", hl.dsp.exec_cmd(screenshot .. " window"))
hl.bind("CONTROL + SHIFT + PRINT", hl.dsp.exec_cmd(screenshot .. " region"))

-- pick color
hl.bind("CONTROL + Menu", hl.dsp.exec_cmd("hyprpicker -a | wl-copy"))

-- llm paste and exec commands
hl.bind("SUPER + V", hl.dsp.exec_cmd("wrap-paste.sh"))
hl.bind("SUPER + bracketleft", hl.dsp.exec_cmd("fuzzel-llm-system-prompts.sh"))
hl.bind("SUPER + bracketright", hl.dsp.exec_cmd("fuzzel-llm-instructions.sh"))

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
    on_created_empty = telegram_client,
  },

  Music = {
    key = "M",
    offset = 8,
    last_active = 9,
    on_created_empty = mpd_client,
  },

  Games = {
    key = "G",
    offset = 12,
    last_active = 13,
    on_created_empty = steam,
  },

  Image = {
    key = "I",
    offset = 16,
    last_active = 17,
    on_created_empty = photopea,
  },

  Notes = {
    key = "N",
    offset = 20,
    last_active = 21,
    on_created_empty = notes,
  },

}

-- switching meta-workspaces retrieves and focuses the last active sub-workspace
local function switch_meta_workspace(meta_name)
  if current_meta == meta_name then return end
  
  current_meta = meta_name
  local target_ws = meta_workspaces[current_meta].last_active
  hl.dispatch(hl.dsp.focus({ workspace = tostring(target_ws) }))
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
  hl.bind("SUPER + " .. meta.key, function()
    switch_meta_workspace(name)
  end, { description = "Switch to " .. name .. " meta-workspace" })
end

for i = 1, 4 do
  local key = i
  
  hl.bind("SUPER + " .. key, function()
    switch_sub_workspace(i)
  end, { description = "Switch to sub-workspace " .. i })
end
