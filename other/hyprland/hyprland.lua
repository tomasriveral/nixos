local browser = "kitty --class \"custom-browserprofiles\" --name \"Select browser profile\" --hold custom-browserprofiles"
local editor = "nvim"
local file = "dolphin"
local mod = "SUPER"
local notes = "kitty --class \"custom-obsidianvaults\" --name \"Select Obsidian vault\" --hold custom-obsidianvaults"
local term = "kitty"

local function close_or_move_special()
    local window = hl.get_active_window()

    if not window then
        return
    end

    local class = window.class or window.initial_class

    if class == "Steam" or class == "custom-pomodoro" then
        hl.dispatch(hl.dsp.window.move({ workspace = "special" }))
    else
        hl.dispatch(hl.dsp.window.close({ window = window }))
    end
end
local function close_other_windows()
    local active = hl.get_active_window()
    local workspace = hl.get_active_workspace()

    if not active or not workspace then
        return
    end

    for _, window in pairs(hl.get_windows()) do
        if window.workspace
            and window.workspace.id == workspace.id
            and window.address ~= active.address
        then
            hl.dispatch(hl.dsp.window.close({ window = window }))
        end
    end
end

local wallpapers = {
    [1] = "WALLPAPER1/PATH/PLACEHOLDER",
    [2] = "WALLPAPER2/PATH/PLACEHOLDER",
    [3] = "WALLPAPER3/PATH/PLACEHOLDER",
    [4] = "WALLPAPER4/PATH/PLACEHOLDER",
    [5] = "WALLPAPER5/PATH/PLACEHOLDER",
    [6] = "WALLPAPER1/PATH/PLACEHOLDER",
    [7] = "WALLPAPER2/PATH/PLACEHOLDER",
    [8] = "WALLPAPER3/PATH/PLACEHOLDER",
    [9] = "WALLPAPER4/PATH/PLACEHOLDER",
    [10] = "WALLPAPER5/PATH/PLACEHOLDER",
}

hl.on("workspace.active", function(workspace)
    local wallpaper = wallpapers[workspace.id]

    if wallpaper then
        hl.exec_cmd("awww img -t none " .. wallpaper)
    end
end)

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 6,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 6,
    bezier = "winIn",
    style = "slide",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 5,
    bezier = "winOut",
    style = "slide",
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 5,
    bezier = "wind",
    style = "slide",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 1,
    bezier = "liner",
})
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 30,
    bezier = "liner",
    style = "loop",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "wind",
})

hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + G", hl.dsp.group.toggle())
hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + CTRL + D", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + CTRL + A", hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + CTRL + Down", hl.dsp.focus({ workspace = "empty" }))
hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .." + CTRL + ALT + Left", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mod .. " + Backspace", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
hl.bind(mod .. " + SHIFT + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + CTRL + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + CTRL + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu| cliphist decode | wl-copy"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("hyprkeys -bkr | rofi -dmenu"))
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special(""))
hl.bind(mod .. " + ALT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mod .. " + A", hl.dsp.layout("move -col"))
hl.bind(mod .. " + D", hl.dsp.layout("move +col"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(file))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + N", hl.dsp.exec_cmd(notes))
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("caelestia shell drawers toggle launcher"))
hl.bind(mod .. " + Q", close_or_move_special)
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("caelestia shell lock lock"))
hl.bind("F11", hl.dsp.exec_cmd("caelestia screenshot"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("caelestia shell picker open"))
hl.bind(mod .. " + CTRL + 6", close_other_windows)
hl.bind("CTRL + ALT + 7", hl.dsp.exec_cmd("custom-performance"))
hl.bind("CTRL + ALT + 1", hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar"))
hl.bind(mod .. " + CTRL + 4", hl.dsp.exec_cmd("caelestia shell notifs toggleDnd"))
hl.bind(mod .. " + CTRL + 3", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("CTRL + SHIFT + ALT + 0", hl.dsp.exec_cmd("kitty --hold --class \"custom-changeAudioOutput\" --name \"Select audio output\" zsh -c \"custom-changeAudioOutput\""))
hl.bind(mod .. " + CTRL + 5", hl.dsp.exec_cmd("gnome-characters"))
hl.bind("CTRL + ALT + 8", hl.dsp.exec_cmd("hyprpicker | tee >(wl-copy) | cliphist store"))
hl.bind("CTRL + ALT + 0", hl.dsp.exec_cmd("custom-tomato"))
hl.bind("CTRL + ALT + 2", hl.dsp.exec_cmd("custom-bottom"))
hl.bind("CTRL + ALT + 9", hl.dsp.exec_cmd("anki"))

hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
-- TODO: manual review on line 93 — resizeactive: expected 'X Y' or 'X% Y%', got "-30"
-- hl.bind("SUPER + SHIFT + Left", hl.dsp.resizeactive(-30, 0), { repeating = true })
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
-- TODO: manual review on line 95 — resizeactive: expected 'X Y' or 'X% Y%', got "m 0 30"
-- hl.bind("SUPER + SHIFT + Down", hl.dsp.resizeactive("m 0 30"), { repeating = true })

hl.bind("F2", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -10%"), { locked = true, repeating = true })
hl.bind("F3", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +10%"), { locked = true, repeating = true })
hl.bind("F7", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("F8", hl.dsp.exec_cmd("brightnessctl s +10%"), { locked = true, repeating = true })

hl.bind("F1", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("F5", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("F4", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("F6", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())
hl.bind(mod .. " + Z", hl.dsp.window.drag())
hl.bind(mod .. " + X", hl.dsp.window.resize())

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPAPLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move",
})

hl.gesture({
    fingers = 2,
    direction = "pinch",
    action = "cursor_zoom",
    mode = "live",
})

--hl.layer_rule({
--    match = { namespace = "ignore_alpha 0" },
    -- TODO: manual review — unmapped layer rule: "blur on"
    -- TODO: manual review — unmapped layer rule: "blur on"
    -- TODO: manual review — unmapped layer rule: "blur on"
    -- TODO: manual review — unmapped layer rule: "blur on"
--})

--hl.layer_rule({
--    match = { namespace = "match:namespace logout_dialog" },
    -- TODO: manual review — unmapped layer rule: "blur on"
--)

hl.monitor({
    output = "eDP-1",
    mode = "highres@highrr",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "highres2highrr",
    position = "auto-left",
    scale = "1",
})

-- TODO: manual review — plugin section 'dynamic-cursors'. The new Lua API exposes plugins via hl.plugin.<name>(...) — wire up per the plugin's docs.
--[[
  rotate { ... }
  shake { ... }
  enabled = true
  mode = rotate
  threshold = 2
]]

-- TODO: manual review — plugin section 'overview'. The new Lua API exposes plugins via hl.plugin.<name>(...) — wire up per the plugin's docs.
--[[
  disableBlur = true
  disableGestures = true
  showEmptyWorkspace = true
  workspaceActiveBorder = rgb(ab7746)
]]

hl.window_rule({
    match = {
        class = "^(firefox)$",
    },
    opacity = "0.90 0.90",
})

hl.window_rule({
    match = {
        class = "^(Brave-browser)$",
    },
    opacity = "0.90 0.90",
})

hl.window_rule({
    match = {
        class = "^(code-oss)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(Code)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(code-url-handler)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(code-insiders-url-handler)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(kitty)$",
    },
    opacity = "0.75 0.75",
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(org.kde.ark)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(nwg-look)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(qt5ct)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(qt6ct)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(kvantummanager)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
    },
    opacity = "0.80 0.70",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(blueman-manager)$",
    },
    opacity = "0.80 0.70",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(nm-applet)$",
    },
    opacity = "0.80 0.70",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(nm-connection-editor)$",
    },
    opacity = "0.80 0.70",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(org.kde.polkit-kde-authentication-agent-1)$",
    },
    opacity = "0.80 0.70",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(polkit-gnome-authentication-agent-1)$",
    },
    opacity = "0.80 0.70",
})

hl.window_rule({
    match = {
        class = "^(org.freedesktop.impl.portal.desktop.gtk)$",
    },
    opacity = "0.80 0.70",
})

hl.window_rule({
    match = {
        class = "^(org.freedesktop.impl.portal.desktop.hyprland)$",
    },
    opacity = "0.80 0.70",
})

hl.window_rule({
    match = {
        class = "^([Ss]team)$",
    },
    opacity = "0.70 0.70",
})

hl.window_rule({
    match = {
        class = "^(steamwebhelper)$",
    },
    opacity = "0.70 0.70",
})

hl.window_rule({
    match = {
        class = "^(Spotify)$",
    },
    opacity = "0.70 0.70",
})

hl.window_rule({
    match = {
        initial_title = "^(Spotify Free)$",
    },
    opacity = "0.70 0.70",
})

hl.window_rule({
    match = {
        class = "^(com.github.rafostar.Clapper)$",
    },
    opacity = "0.90 0.90",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(com.github.tchx84.Flatseal)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(hu.kramo.Cartridges)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(com.obsproject.Studio)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(gnome-boxes)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(discord)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(WebCord)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(ArmCord)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(app.drey.Warp)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(net.davidotek.pupgui2)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(yad)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(Signal)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(io.github.alainm23.planify)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(io.gitlab.theevilskeleton.Upscaler)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(com.github.unrud.VideoDownloader)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(io.gitlab.adhami3310.Impression)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(io.missioncenter.MissionCenter)$",
    },
    opacity = "0.80 0.80",
    float = true,
})

hl.window_rule({
    match = {
        class = "^(io.github.flattool.Warehouse)$",
    },
    opacity = "0.80 0.80",
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$",
        title = "^(Progress Dialog — Dolphin)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(org.kde.dolphin)$",
        title = "^(Copying — Dolphin)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(firefox)$",
        title = "^(Picture-in-Picture)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(firefox)$",
        title = "^(Library)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(kitty)$",
        title = "^(top)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(kitty)$",
        title = "^(btop)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(kitty)$",
        title = "^(htop)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(vlc)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(eog)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(custom-browserprofiles)$",
    },
    float = true,
    size = "400 225",
})

hl.window_rule({
    match = {
        class = "^(custom-changeAudioOutput)$",
    },
    float = true,
    size = "1050 200",
})

hl.window_rule({
    match = {
        class = "^(custom-obsidianvaults)$",
    },
    float = true,
    size = "400 175",
})

hl.window_rule({
    match = {
        initial_class = "^(custom-pomodoro)$",
    },
    float = true,
    size = "600 600",
})

hl.window_rule({
    match = {
        initial_class = "^(custom-bottom)$",
    },
    float = true,
    size = "1500 800",
})

hl.workspace_rule({
    workspace = "1",
    layout = "master",
})

hl.workspace_rule({
    workspace = "2",
    layout = "scrolling",
})

hl.workspace_rule({
    workspace = "special",
    layout = "scrolling",
})

-- TODO: manual review — top-level key 'splash = true' has no enclosing section
hl.config({
    animations = {
        enabled = true,
    },
    decoration = {
        blur = {
            enabled = true,
            ignore_opacity = true,
            new_optimizations = true,
            passes = 2,
            size = 4,
            special = true,
        },
        dim_special = 0.300000,
        rounding = 18,
    },
    dwindle = {
        preserve_split = true,
    },
    general = {
        border_size = 4,
        col = {
            active_border = { colors = { "rgba(ca6702ff)", "rgba(ecd3a0ff)" }, angle = 45 },
            inactive_border = { colors = { "rgba(f1dca7d9)", "rgba(ffe1a8d9)" }, angle = 45 },
        },
        gaps_in = 5,
        gaps_out = 15,
        layout = "dwindle",
        resize_on_border = true,
    },
    group = {
        col = {
            border_active = { colors = { "rgba(ca6702ff)", "rgba(ecd3a0ff)" }, angle = 45 },
            border_inactive = { colors = { "rgba(f1dca7d9)", "rgba(ffe1a8d9)" }, angle = 45 },
            border_locked_active = { colors = { "rgba(ca6702ff)", "rgba(ecd3a0ff)" }, angle = 45 },
            border_locked_inactive = { colors = { "rgba(f1dca7d9)", "rgba(ffe1a8d9)" }, angle = 45 },
        },
    },
    input = {
        kb_layout = "ch",
        follow_mouse = 1,
        force_no_accel = 1,
        sensitivity = 0,
    },
    misc = {
        force_default_wallpaper = 0,
        vrr = 0,
    },
    scrolling = {
        column_width = 0.450000,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("/nix/store/8kih8alkk4qzgjchg5501r1c3a8a71aw-dbus-1.16.2/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
    hl.exec_cmd("qtbatticon")
    hl.exec_cmd("source /run/agenix/ntfy && nixpkgs-notifier listen")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-wlr.service")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("udiskie --no-automount --smart-tray")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("rm -rf ~/.cache/cliphist/ && wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store")
    hl.exec_cmd("custom-batterynotify")
    hl.exec_cmd("custom-batterywarning")
    hl.exec_cmd("awww img WALLPAPER/PATH/PLACEHOLDER")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sleep 1 && custom-wallpaper")
    hl.exec_cmd("custom-checkKdrive && custom-mountkdrive")
    hl.exec_cmd("custom-gitnotify")
    hl.exec_cmd("sleep 4 & caelestia-shell")
    hl.exec_cmd("sleep 20 && ngcp pull --automatic")
end)
-- host specific config
require("host")
