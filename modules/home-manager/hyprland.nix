{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: let
  wallpaper = ../../assets/wallpaper1.jpg;
in {
  #refer to https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = pkgs-unstable.hyprland;
  #hint Electron apps to use on wayland;
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland.plugins = [
    #pkgs-unstable.hyprlandPlugins.hyprspace # currently broken
    #pkgs-unstable.hyprlandPlugins.hypr-dynamic-cursors # currently broken
  ];
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$term" = "kitty";
    "$editor" = "nvim";
    "$notes" = "kitty --class \"custom-obsidianvaults\" --name \"Select Obsidian vault\" --hold custom-obsidianvaults";
    "$file" = "dolphin";
    "$browser" = "kitty --class \"custom-librewolfprofiles\" --name \"Select LibreWolf profile\" --hold custom-librewolfprofiles";
    # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
    # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█
    animations = {
      enabled = true;
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        "borderangle, 1, 30, liner, loop"
        "fade, 1, 10, default"
        "workspaces, 1, 5, wind"
      ];
    };

    # █▀▀ █▄░█ █░█
    # ██▄ █░▀█ ▀▄▀

    # See https://wiki.hyprland.org/Configuring/Environment-variables/
    env = [
      "PATH, $PATH:$scrPath"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPAPLATFORMTHEME,qt6ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "MOZ_ENABLE_WAYLAND,1"
      "GDK_SCALE,1"
    ];

    # █ █▄░█ █▀█ █░█ ▀█▀
    # █ █░▀█ █▀▀ █▄█ ░█░

    input = {
      kb_layout = ["ch"];
      follow_mouse = 1;
      sensitivity = 0;
      force_no_accel = 1;
    };

    # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
    # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█
    # caelestia shell drawers toggle dashboard
    # caelestia shell drawers toggle utilities

    bind = [
      #hyprland/utility keybindings
      "$mod, W, togglefloating"
      "$mod, G, togglegroup"
      "Alt, Return, fullscreen"
      "$mod, Left, movefocus, l"
      "$mod, Right, movefocus, r"
      "$mod, Up, movefocus, u"
      "$mod, Down, movefocus, d"
      "Alt, Tab, movefocus, d"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      "$mod+Ctrl, Right, workspace, r+1"
      "$mod+Ctrl, Left, workspace, r-1"
      "$mod+Ctrl, Doown, workspace, empty"
      "$mod+Shift, 1, movetoworkspace, 1"
      "$mod+Shift, 2, movetoworkspace, 2"
      "$mod+Shift, 3, movetoworkspace, 3"
      "$mod+Shift, 4, movetoworkspace, 4"
      "$mod+Shift, 5, movetoworkspace, 5"
      "$mod+Shift, 6, movetoworkspace, 6"
      "$mod+Shift, 7, movetoworkspace, 7"
      "$mod+Shift, 8, movetoworkspace, 8"
      "$mod+Shift, 9, movetoworkspace, 9"
      "$mod+Shift, 0, movetoworkspace, 10"
      "$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
      "$mod+Ctrl+Alt, Left, movetoworkspace, r-1"
      #"$mod, Backspace, exec, wlogout -b 4 -T 600 -B 600"
      "$mod, Backspace, exec, caelestia shell drawers toggle session"
      "$mod+Shift+Ctrl, Left, movewindow, l"
      "$mod+Shift+Ctrl, Right, movewindow, r"
      "$mod+Shift+Ctrl, Up, movewindow, u"
      "$mod+Shift+Ctrl, Down, movewindow, d"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      "$mod, V, exec, cliphist list | rofi -dmenu| cliphist decode | wl-copy" # copy paste
      "$mod, B, exec, hyprkeys -bkr | rofi -dmenu"
      #"$mod, A, tagwindow, noborder" # used to not apply image border
      "$mod, S, togglespecialworkspace,"
      "Alt+$mod, S, movetoworkspace, special"
      # for the scrolling layout
      "$mod, A, layoutmsg, move -col"
      "$mod, D, layoutmsg, move +col"
      #apps keybindings
      "$mod, T, exec, $term"
      "$mod, E, exec, $file"
      "$mod, F, exec, $browser"
      "$mod, N, exec, $notes"
      #"$mod+Shift, A, exec, rofi -show drun"
      "$mod+Shift, A, exec, caelestia shell drawers toggle launcher"
      "$mod, Q, exec, custom-dontkillsteam"
      #"Ctrl+Alt, W, exec, pkill waybar || waybar"
      "Ctrl+Alt, W, exec, caelestia shell drawers toggle sidebar"
      #"$mod, L, exec, swaylock -eFLK -i ${wallpaper}"
      "$mod, L, exec, caelestia shell lock lock"
      #"$mod, F11, exec, hyprshot -m  window"
      ", F11, exec, caelestia screenshot"
      #"$mod_SHIFT, S, exec, hyprshot -m region --clipboard only"
      # "$mod_SHIFT, S, exec, qs ipc call screenshot toggle"
      "$mod_SHIFT, S, exec, caelestia shell picker open"
      # framework 16 rgb macropad
      "Ctrl+$mod, 6, exec, custom-killall" # pos 1 1 killall apps except focused one
      #"Ctrl+Alt, 7, exec, custom-performance" # pos 2 1 start performance mode
      "Ctrl+Alt, 7, exec, caelestia shell gameMode toggle"
      # reloads the autostart programs # pos 3 1
      # we passed to caelestia-shell and stoped using that
      /*
        "Ctrl+$mod, 4, exec, sleep 1 && kitty -o font_size=16 -e sh -c 'custom-weather'"
      "Ctrl+$mod, 4, exec, sleep 1 && kitty -o font_size=11 -e sh -c 'custom-cowsay'"
      "Ctrl+$mod, 4, exec, kitty -e 'custom-launch'"
      "Ctrl+$mod, 4, exec, sleep 1 && kitty -o font_size=5 -e btm --theme gruvbox --disable-click --disable_advanced_kill --enable_cache_memory -g -R -T "
      "Ctrl+$mod, 4, exec, sleep 1 && kitty -o font_size=1 -e sh -c 'cmatrix -br'"
      #"Ctrl+Alt, 1, exec, swaync-client -t" # pos 4 1 notification center
      "Ctrl+Alt, 1, exec, qs ipc call notifications toggle"
      */
      "Ctrl+Alt, 1, exec, caelestia shell drawers toggle sidebar"
      "Ctrl+$mod, 4, exec, caelestia shell notifs toggleDnd"
      "Ctrl+$mod, 3, exec, pavucontrol" # pos 1 2 audiocontrol
      "Ctrl+$mod, 5, exec, gnome-characters" # pos 2 2 special chars
      "Ctrl+Alt, 8, exec, hyprpicker | tee >(wl-copy) | cliphist store" # pos 3 2 colorpicker
      "Ctrl+Alt, 0, exec, custom-tomato" # pos 1 3 pomodoro app
      "Ctrl+Alt, 2, exec, custom-bottom" # pos 2 3 btm (like htop but cleaner)
      "Ctrl+Alt, 9, exec, anki"
      # if hyprexpo plugin enabled bind = $mainMod, Space, hyprexpo:expo, toggle
      # maybe exec sudo framework-tools-tui

      #plugins keybindings
      #"$mod, SPACE, overview:toggle, "
    ];
    binde = [
      "$mod+Shift, Right, resizeactive, 30 0"
      "$mod+Shift, Left, resizeactive, -30, 0"
      "$mod+Shift, Up, resizeactive, 0 -30"
      "$mod+Shift, Down, resizeactive,m 0 30"
    ];
    bindl = [
      ", F1, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle" #toggle audio mute
      ", F5, exec, playerctl play-pause" # media F4-F6
      ", F4, exec, playerctl previous"
      ", F6, exec, playerctl next"
    ];
    bindel = [
      ", F2, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%" # decrease volume
      ", F3, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%" # increase volume
      ", F7, exec, brightnessctl s 10%-" # decrease brightness
      ", F8, exec, brightnessctl s +10%" # increase brightness
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod, Z, movewindow"
      "$mod, X, resizewindow"
    ];
    # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
    # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
    exec-once = [
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
      "dbus-update-activation-environment --systemd --all" # for XDPH
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
      "systemctl --user start xdg-desktop-portal-wlr.service"
      "blueman-applet" # systray app for Bluetooth
      "udiskie --no-automount --smart-tray" # front-end that allows to manage removable media
      "nm-applet --indicator" # systray app for Network/wifi
      "wl-paste --type text --watch cliphist store" # clipboard store text data
      "wl-paste --type image --watch cliphist store" # clipboard store image data
      "custom-batterynotify"
      "custom-batterywarning"
      "birdtray" # thunderbird tray app
      #wallpapers/b
      "swww img ${wallpaper}"
      "swww-daemon"
      "sleep 1 && custom-wallpaper"
      "custom-mountkdrive"
      #"waybar"
      "custom-gitnotify"
      #"custom-obsidianbackup" # backups the obsidian notes to kdrive and to a timed hidden dir (~/.Notes.backup/)
      #"QS-notifycache" # builds the cache that will be used for the notification history
      "sleep 4 & caelestia-shell" #works better if it sleeps a bit before
      /*
         We stopped using that ######################### maybe we should desactivate those scripts
      # login autostart
      #######################
      "[workspace 1 silent]  sleep 1 && kitty -o font_size=16 -e sh -c 'custom-weather'"
      "[workspace 1 silent] sleep 1 && kitty -o font_size=11 -e sh -c 'custom-cowsay'"
      "[workspace 1 silent] kitty -e 'custom-launch'"
      "[workspace 1 silent] sleep 1 && kitty -o font_size=5 -e btm --theme gruvbox --disable-click --disable_advanced_kill --enable_cache_memory -g -R -T "
      "[workspace 1 silent] sleep 1 && kitty -o font_size=1 -e sh -c 'cmatrix -br'"
      ######################
      ######################
      */
    ];
    splash = false; # remove default background on startup
    # gestures (also keybindings)
    gesture = [
      "3, right, move, +col"
      "3, left, move, -col"
    ];

    # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
    # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    scrolling = {
      column_width = 0.45;
    };

    # █▀▄▀█ █ █▀ █▀▀
    # █░▀░█ █ ▄█ █▄▄

    misc = {
      vrr = 0;
      force_default_wallpaper = 0;
    };
    xwayland = {
      force_zero_scaling = true;
    };

    # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
    # █░▀░█ █▄█ █#░▀█ █ ░█░ █▄█ █▀▄
    monitor = [
      #",preferred, auto, auto"
      "HDMI-A-1, highres2highrr, auto-left, 1"
    ];
    # _______  ___      __   __  _______  ___   __    _  _______
    #|       ||   |    |  | |  ||       ||   | |  |  | ||       |
    #|    _  ||   |    |  | |  ||    ___||   | |   |_| ||  _____|
    #|   |_| ||   |    |  |_|  ||   | __ |   | |       || |_____
    #|    ___||   |___ |       ||   ||  ||   | |  _    ||_____  |
    #|   |    |       ||       ||   |_| ||   | | | |   | _____| |
    #|___|    |_______||_______||_______||___| |_|  |__||_______|
    #
    "plugin:dynamic-cursors" = {
      enabled = true;
      threshold = 2;
      mode = "rotate";
      rotate = {
        # length in px of the simulated stick used to rotate the cursor
        # most realistic if this is your actual cursor size
        length = 20;
        offset = 0;
      };
      shake = {
        enabled = true;
        # use nearest-neighbour (pixelated) scaling when shaking
        # may look weird when effects are enabled
        nearest = true;
        threshold = 4;
        # magnification level immediately after shake start
        base = 4.0;
        # magnification increase per second when continuing to shake
        speed = 4.0;
        # how much the speed is influenced by the current shake intensitiy
        influence = 0.0;

        # maximal magnification the cursor can reach
        # values below 1 disable the limit (e.g. 0)
        limit = 0.0;

        # time in millseconds the cursor will stay magnified after a shake has ended
        timeout = 2000;

        # show cursor behaviour `tilt`, `rotate`, etc. while shaking
        effects = true;

        # enable ipc events for shake
        ipc = false;
      };
    };
    "plugin:overview" = {
      disableGestures = true;
      showEmptyWorkspace = true;
      workspaceActiveBorder = "rgb(ab7746)";
      disableBlur = true;
    };

    #####################################################
    #####################################################
    # theme
    decoration = {
      dim_special = 0.3;
      blur = {
        special = true;
        enabled = true;
        size = 4;
        passes = 2;
        new_optimizations = true;
        ignore_opacity = true;
      };
    };
    general = {
      gaps_in = 3;
      gaps_out = 8;
      border_size = 4;
      "col.active_border" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
      "col.inactive_border" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
      layout = "dwindle";
      resize_on_border = true;
    };
    group = {
      "col.border_active" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
      "col.border_inactive" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
      "col.border_locked_active" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
      "col.border_locked_inactive" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
    };
    ####################################################
    ##################################################

    # /$$      /$$                     /$$
    #| $$  /$ | $$                    | $$
    #| $$ /$$$| $$  /$$$$$$   /$$$$$$ | $$   /$$  /$$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$
    #| $$/$$ $$ $$ /$$__  $$ /$$__  $$| $$  /$$/ /$$_____/ /$$__  $$ |____  $$ /$$_____/ /$$__  $$
    #| $$$$_  $$$$| $$  \ $$| $$  \__/| $$$$$$/ |  $$$$$$ | $$  \ $$  /$$$$$$$| $$      | $$$$$$$$
    #| $$$/ \  $$$| $$  | $$| $$      | $$_  $$  \____  $$| $$  | $$ /$$__  $$| $$      | $$_____/
    #| $$/   \  $$|  $$$$$$/| $$      | $$ \  $$ /$$$$$$$/| $$$$$$$/|  $$$$$$$|  $$$$$$$|  $$$$$$$
    #|__/     \__/ \______/ |__/      |__/  \__/|_______/ | $$____/  \_______/ \_______/ \_______/
    #                                                     | $$
    #                                                     | $$
    #                                                     |__/
    #     see https://wiki.hypr.land/Configuring/Workspace-Rules/
    workspace = [
      "1, layout:master"
      "2, layout:scrolling, layoutopt:direction:right"
      "name:special, layout:scrolling"
      # used for smart gaps along some windowrules
      "w[tv1], gapsout:1, gapsin:1"
      "f[1], gapsout:1, gapsin:1"
    ];

    # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
    # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
    windowrule = [
      "opacity 0.90 0.90, match:class ^(firefox)$"
      "opacity 0.90 0.90, match:class ^(Brave-browser)$"
      "opacity 0.80 0.80, match:class ^(code-oss)$"
      "opacity 0.80 0.80, match:class ^(Code)$"
      "opacity 0.80 0.80, match:class ^(code-url-handler)$"
      "opacity 0.80 0.80, match:class ^(code-insiders-url-handler)$"
      "opacity 0.75 0.75, match:class ^(kitty)$"
      "opacity 0.80 0.80, match:class ^(org.kde.dolphin)$"
      "opacity 0.80 0.80, float on, match:class ^(org.kde.ark)$"
      "opacity 0.80 0.80, float on, match:class ^(nwg-look)$"
      "opacity 0.80 0.80, float on, match:class ^(qt5ct)$"
      "opacity 0.80 0.80, float on, match:class ^(qt6ct)$"
      "opacity 0.80 0.80, float on, match:class ^(kvantummanager)$"
      "opacity 0.80 0.70, float on, match:class ^(org.pulseaudio.pavucontrol)$"
      "opacity 0.80 0.70, float on, match:class ^(blueman-manager)$"
      "opacity 0.80 0.70, float on, match:class ^(nm-applet)$"
      "opacity 0.80 0.70, float on, match:class ^(nm-connection-editor)$"
      "opacity 0.80 0.70, float on, match:class ^(org.kde.polkit-kde-authentication-agent-1)$"
      "opacity 0.80 0.70, match:class ^(polkit-gnome-authentication-agent-1)$"
      "opacity 0.80 0.70, match:class ^(org.freedesktop.impl.portal.desktop.gtk)$"
      "opacity 0.80 0.70, match:class ^(org.freedesktop.impl.portal.desktop.hyprland)$"
      "opacity 0.70 0.70, match:class ^([Ss]team)$"
      "opacity 0.70 0.70, match:class ^(steamwebhelper)$"
      "opacity 0.70 0.70, match:class ^(Spotify)$"
      "opacity 0.70 0.70, match:initial_title ^(Spotify Free)$"
      "opacity 0.90 0.90, float on, match:class ^(com.github.rafostar.Clapper)$"
      "opacity 0.80 0.80, match:class ^(com.github.tchx84.Flatseal)$"
      "opacity 0.80 0.80, match:class ^(hu.kramo.Cartridges)$"
      "opacity 0.80 0.80, match:class ^(com.obsproject.Studio)$"
      "opacity 0.80 0.80, match:class ^(gnome-boxes)$"
      "opacity 0.80 0.80, match:class ^(discord)$"
      "opacity 0.80 0.80, match:class ^(WebCord)$"
      "opacity 0.80 0.80, match:class ^(ArmCord)$"
      "opacity 0.80 0.80, float on, match:class ^(app.drey.Warp)$"
      "opacity 0.80 0.80, float on, match:class ^(net.davidotek.pupgui2)$"
      "opacity 0.80 0.80, float on, match:class ^(yad)$"
      "opacity 0.80 0.80, float on, match:class ^(Signal)$"
      "opacity 0.80 0.80, float on, match:class ^(io.github.alainm23.planify)$"
      "opacity 0.80 0.80, float on, match:class ^(io.gitlab.theevilskeleton.Upscaler)$"
      "opacity 0.80 0.80, float on, match:class ^(com.github.unrud.VideoDownloader)$"
      "opacity 0.80 0.80, float on, match:class ^(io.gitlab.adhami3310.Impression)$"
      "opacity 0.80 0.80, float on, match:class ^(io.missioncenter.MissionCenter)$"
      "opacity 0.80 0.80, match:class ^(io.github.flattool.Warehouse)$"
      "float on, match:class ^(org.kde.dolphin)$, match:title ^(Progress Dialog — Dolphin)$"
      "float on, match:class ^(org.kde.dolphin)$, match:title ^(Copying — Dolphin)$"
      "float on, match:class ^(firefox)$, match:title ^(Picture-in-Picture)$"
      "float on, match:class ^(firefox)$, match:title ^(Library)$"
      "float on, match:class ^(kitty)$, match:title ^(top)$"
      "float on, match:class ^(kitty)$, match:title ^(btop)$"
      "float on, match:class ^(kitty)$, match:title ^(htop)$"
      "float on, match:class ^(vlc)$"
      "float on, match:class ^(eog)$"
      "float on, size 400 175, match:class ^(custom-librewolfprofiles)$"
      "float on, size 400 175, match:class ^(custom-obsidianvaults)$"
      "float on, size 600 600, match:initial_class ^(custom-pomodoro)$"
      "float on, size 1500 800, match:initial_class ^(custom-bottom)$"
      "border_size 2, match:float 0, match:workspace w[tv1]"
      "rounding 1, match:float 0, match:workspace w[tv1]"
      "border_size 2, match:float 0, match:workspace f[1]"
      "rounding 1, match:float 0, match:workspace f[1]"
    ];
    # add a float for tomato when in kitty
    #"plugin:imgborders:noimgborders, tag:noborder"
    layerrule = [
      "blur on, ignore_alpha 0, match:namespace rofi"
      "blur on, ignore_alpha 0, match:namespace notifications"
      "blur on, ignore_alpha 0, match:namespace swaync-notification-window"
      "blur on, ignore_alpha 0, match:namespace swaync-control-center"
      "blur on, match:namespace logout_dialog"
    ];
  };
}
