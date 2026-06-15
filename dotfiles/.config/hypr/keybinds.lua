-- ### System #####################################################
-- 
-- $mainMod = SUPER
-- 
-- bind = $mainMod, Q, exec, ~/.config/hypr/scripts/safe-kill.sh
-- bind = $mainMod SHIFT, Q, killactive
-- bind = $mainMod, Tab, fullscreen, 0
-- 
-- # toggle floating
-- bind = $mainMod, E, togglefloating
-- 
-- # cycle focus through windows
-- bind = $mainMod, Right, cyclenext
-- bind = $mainMod, Left, cyclenext, prev
-- 
-- move/resize windows with lmb/rmb and dragging
-- bindm = $mainMod, mouse:272, movewindow
-- bindm = $mainMod, mouse:273, resizewindow
-- 
-- bind = , Scroll_Lock, exec, qs -p ~/.config/quickshell/hypr-ref/shell.qml ipc call screensaver activate
-- bind = CONTROL ALT, Delete, exec, powermenu.sh


--- System -----------------------------------------------------

-- hl.bind("SUPER + ", hl.dsp.exec_cmd(""))
-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
-- hl.bind("SUPER + ", hl.dsp.window())

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


--- Programs ---------------------------------------------------

local terminal = "alacritty"
local file_manager = "thunar"
local menu = "fuzzel"
local calculator = "gnome-calculator"
local notes = "nvl -c 'cd ~/Notes' -c 'startinsert'"
local mpd_client = "chromium-browser --app=http://localhost:5173/"
local browser = "zen-beta"
local password_manager = "bitwarden"

-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
hl.bind("SUPER + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + KP_Multiply", hl.dsp.exec_cmd(calculator))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(password_manager))

-- bookmarks
hl.bind("SUPER + grave", hl.dsp.exec_cmd("fuzzel-bookmarks.sh"))

-- mpd client
hl.workspace_rule({ workspace = "special:mpd", on_created_empty = mpd_client })
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("mpd"))

-- notes
hl.workspace_rule({ workspace = "special:notes", on_created_empty = notes })
hl.bind("SUPER + N", hl.dsp.workspace.toggle_special("notes"))

-- hl.workspace_rule({ workspace = "special:", on_created_empty =  })
-- hl.bind("SUPER + ", hl.dsp.workspace.toggle_special())

-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
-- hl.bind("SUPER + ", hl.dsp.exec_cmd())
-- hl.bind("SUPER + ", hl.dsp.exec_cmd())

--- Workspace Navigation ---------------------------------------

-- switch and move workspaces with SUPER + i
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
