--- System -----------------------------------------------------

-- kill hyprland and escape to tty
hl.bind (
  "CONTROL + ALT + Escape",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'") )

-- close window safely
local safe_kill = require("scripts.safe-kill")
hl.bind (
  "SUPER + Q",
  safe_kill )

-- close window
hl.bind (
  "SUPER + SHIFT + Q",
  hl.dsp.window.close() )

-- toggle floating
hl.bind (
  "SUPER + E",
  hl.dsp.window.float({ action = "toggle" }) )

-- toggle fullscreen
hl.bind (
  "SUPER + Tab",
  hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }) )

-- cycle focus through windows
hl.bind (
  "SUPER + left",
  hl.dsp.focus({ direction = "left" }) )

hl.bind (
  "SUPER + right",
  hl.dsp.focus({ direction = "right" }) )

-- move/resize windows with lmb/rmb and dragging
hl.bind (
  "SUPER + mouse:272",
  hl.dsp.window.drag(),
  { mouse = true } )
hl.bind (
  "SUPER + mouse:273",
  hl.dsp.window.resize(),
  { mouse = true } )

-- powermenu
hl.bind (
  "CONTROL + ALT + Delete",
  hl.dsp.exec_cmd("powermenu.sh") )

--- Control ----------------------------------------------------

-- audio devices
hl.bind (
  "SUPER + F1",
  hl.dsp.exec_cmd("pactl set-default-sink EDIFIER-R1380DB-EQ-SPL90-20260609") )

hl.bind (
  "SUPER + F2",
  hl.dsp.exec_cmd("pactl set-default-sink AIYIMA-DAC-A5-PRO-SWAP") )

hl.bind (
  "SUPER + F3",
  hl.dsp.exec_cmd("pactl set-default-sink REDMI-BUDS-6-ACTIVE-EQ") )

-- audio volume
hl.bind (
  "KP_Add",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"),
  { repeating = true } )

hl.bind (
  "KP_Subtract",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),
  { repeating = true } )

--- Programs ---------------------------------------------------

hl.bind (
  "SUPER + Return",
  hl.dsp.exec_cmd(programs.terminal) )

hl.bind (
  "SUPER + R",
  hl.dsp.exec_cmd(programs.menu) )

hl.bind (
  "SUPER + SHIFT + E",
  hl.dsp.exec_cmd(programs.file_manager) )

hl.bind (
  "SUPER + SHIFT + B",
  hl.dsp.exec_cmd(programs.browser) )

hl.bind (
  "SUPER + KP_Multiply",
  hl.dsp.exec_cmd(programs.calculator) )

hl.bind (
  "SUPER + SHIFT + P",
  hl.dsp.exec_cmd(programs.password_manager) )

hl.bind (
  "SUPER + Grave",
  hl.dsp.exec_cmd(programs.bookmarks) )

hl.bind (
  "SUPER + SHIFT + Return",
  hl.dsp.exec_cmd(programs.terminal .. " -e " .. programs.lab_ssh) )

-- mpd client
hl.bind (
  "CONTROL + Space",
  hl.dsp.exec_cmd("rmpc togglepause") )

hl.bind (
  "CONTROL + Pause",
  hl.dsp.exec_cmd("rmpc single oneshot") )

hl.bind (
  "CONTROL + SHIFT + Pause",
  hl.dsp.exec_cmd("rmpc single off") )

-- screenshots
local screenshot = require("scripts.screenshot")

hl.bind (
  "PRINT",
  function() screenshot("output") end )

hl.bind (
  "CONTROL + PRINT",
  function() screenshot("window") end )

hl.bind (
  "CONTROL + SHIFT + PRINT",
  function() screenshot("region") end )

-- pick color
hl.bind (
  "CONTROL + Menu",
  hl.dsp.exec_cmd("hyprpicker -a | wl-copy") )

-- paste utils
hl.bind (
  "SUPER + V",
  hl.dsp.exec_cmd("wrap-paste.sh") )

hl.bind (
  "SUPER + P",
  hl.dsp.exec_cmd("fuzzel-paste.sh") )

-- llm exec commands
hl.bind (
  "SUPER + bracketleft",
  hl.dsp.exec_cmd("fuzzel-llm-system-prompts.sh") )

hl.bind (
  "SUPER + bracketright",
  hl.dsp.exec_cmd("fuzzel-llm-instructions.sh") )

