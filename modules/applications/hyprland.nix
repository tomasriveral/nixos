{self, ...}: {
  flake.nixosModules.hyprland = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      awww #wallpaper daemon
      gruvbox-gtk-theme
      hyprcursor
      capitaine-cursors-themed # cursor theme
      papirus-icon-theme
      papirus-folders
      self.packages.${pkgs.system}.custom-wallpaper
      self.packages.${pkgs.system}.custom-dontkillsteam # kill app (if not steam or tomato-c
      self.packages.${pkgs.system}.custom-killall # kill all windows except focused window
      xdg-utils
    ];
    # enable hyprland WM
    programs.hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland; # we use the unstable branch to get the latest features
      withUWSM = true;
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    # removes uxterm
    services.xserver.excludePackages = [pkgs.xterm];

    # Enable the X11 windowing system.
    services.xserver.enable = true;
  };
  flake.homeModules.hyprland-laptop = {lib, ...}: {
    wayland.windowManager.hyprland.settings = {
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("qtbatticon") --- custom battery tray
              hl.exec_cmd("source /run/agenix/ntfy && nixpkgs-notifier listen") --- tracks PR merge in nixos-unstable
            end
          '')
        ];
      };

      monitor = [
        {
          output = "eDP-1";
          mode = "highres@highrr";
          position = "0x0";
          scale = 1;
        }
      ];
    };
  };
  flake.homeModules.hyprland-desktop = _: {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        ", highres@highrr, auto, 0.75"
      ];
      exec-once = [
        "if [ -e  \"/home/tomasr/icloudSync.sh\" ]; then /home/tomasr/icloudSync.sh; else notify-send \"icloudSync.sh doesn't exist\" \"See ~/nixos/modules/applications/hyprland.nix for more information\"; fi"
        # my icloud account uses an email that I don't want to make public. So the script isnt pushed to github. The script looks like:
        /*
        #!/etc/profiles/per-user/tomasr/bin/zsh
        if ! icloudpd --auth-only --username tomas.rivera_2009@icloud.com --dry-run; then
         notify-send "icloudpd is not logged in" "Please run icloudpd icloudpd --username my@email.address --password my_password --auth-only"
         exit 1
        fi
        icloudpd --directory ~/hdd/kdrive/Photo/IPhone/icloudpd-backup --username tomas.rivera_2009@icloud.com --watch-with-interval 3600 --no-progress-bar
        */
      ];
    };
  };
  flake.homeModules.hyprland = {pkgs-unstable, lib, ...}: let
    wallpaper = ../../assets/wallpaper1.jpg;
    mod = "SUPER";
    term = "kitty";
    editor = "nvim";
    notes = "kitty --class \\\"custom-obsidianvaults\\\" --name \\\"Select Obsidian vault\\\" --hold custom-obsidianvaults";
    file = "dolphin";
    browser = "kitty --class \\\"custom-browserprofiles\\\" --name \\\"Select browser profile\\\" --hold custom-browserprofiles";

  in {
    #refer to https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.package = pkgs-unstable.hyprland;
    #hint Electron apps to use on wayland;
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland.plugins = [
      #pkgs-unstable.hyprlandPlugins.hyprspace # currently broken
      #pkgs-unstable.hyprlandPlugins.hypr-dynamic-cursors
    ];
    wayland.windowManager.hyprland.configType = "lua";
    wayland.windowManager.hyprland.settings = {
      # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

      config = {
        input = {
          kb_layout = "ch";
          follow_mouse = 1;
          sensitivity = 0;
          force_no_accel = 1;
        };
        
        # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
        # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█
  
        dwindle = {
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
              decoration = {
        dim_special = 0.3;
        rounding = 18;
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
        gaps_in = 5;
        gaps_out = 15;
        border_size = 4;
        #"col.active_border" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
        #"col.inactive_border" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
        layout = "dwindle";
        resize_on_border = true;
      };
      group = {
        #"col.border_active" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
        #"col.border_inactive" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
        #"col.border_locked_active" = "rgba(ca6702ff) rgba(ecd3a0ff) 45deg";
        #"col.border_locked_inactive" = "rgba(f1dca7d9) rgba(ffe1a8d9) 45deg";
      };

      };
      /*animations = {
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
      };*/

      # █▀▀ █▄░█ █░█
      # ██▄ █░▀█ ▀▄▀

      # See https://wiki.hyprland.org/Configuring/Environment-variables/
      env = [
        {_args = ["PATH" "$PATH:$scrPath"];}
        {_args = ["XDG_CURRENT_DESKTOP" "Hyprland"];}
        {_args = ["XDG_SESSION_TYPE" "wayland"];}
        {_args = ["XDG_SESSION_DESKTOP" "Hyprland"];}
        {_args = ["QT_QPA_PLATFORM" "wayland;xcb"];}
        {_args = ["QT_QPAPLATFORMTHEME" "qt6ct"];}
        {_args = ["QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"];}
        {_args = ["MOZ_ENABLE_WAYLAND" "1"];}
        {_args = ["GDK_SCALE" "1"];}
      ];

      # █ █▄░█ █▀█ █░█ ▀█▀
      # █ █░▀█ █▀▀ █▄█ ░█░

      

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█
      # caelestia shell drawers toggle dashboard
      # caelestia shell drawers toggle utilities
bind = [
  {
    _args = [
      "SUPER + W"
      (lib.generators.mkLuaInline "hl.dsp.window.float()")
    ];
  }

  {
    _args = [
      "SUPER + G"
      (lib.generators.mkLuaInline "hl.dsp.group.toggle()")
    ];
  }

  {
    _args = [
      "ALT + RETURN"
      (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
    ];
  }

  {
    _args = [
      "SUPER + LEFT"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "l" })'')
    ];
  }

  {
    _args = [
      "SUPER + RIGHT"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "r" })'')
    ];
  }

  {
    _args = [
      "SUPER + UP"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "u" })'')
    ];
  }

  {
    _args = [
      "SUPER + DOWN"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "d" })'')
    ];
  }

  {
    _args = [
      "ALT + TAB"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "d" })'')
    ];
  }

  {
    _args = [
      "SUPER + 1"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "1" })'')
    ];
  }

  {
    _args = [
      "SUPER + 2"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "2" })'')
    ];
  }

  {
    _args = [
      "SUPER + 3"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "3" })'')
    ];
  }

  {
    _args = [
      "SUPER + 4"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "4" })'')
    ];
  }

  {
    _args = [
      "SUPER + 5"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "5" })'')
    ];
  }

  {
    _args = [
      "SUPER + 6"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "6" })'')
    ];
  }

  {
    _args = [
      "SUPER + 7"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "7" })'')
    ];
  }

  {
    _args = [
      "SUPER + 8"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "8" })'')
    ];
  }

  {
    _args = [
      "SUPER + 9"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "9" })'')
    ];
  }

  {
    _args = [
      "SUPER + 0"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "10" })'')
    ];
  }

  {
    _args = [
      "SUPER + CTRL + RIGHT"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "r+1" })'')
    ];
  }

  {
    _args = [
      "SUPER + CTRL + LEFT"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "r-1" })'')
    ];
  }

  {
    _args = [
      "SUPER + CTRL + DOWN"
      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "empty" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 1"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "1" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 2"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "2" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 3"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "3" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 4"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "4" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 5"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "5" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 6"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "6" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 7"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "7" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 8"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "8" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 9"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "9" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + 0"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "10" })'')
    ];
  }

  {
    _args = [
      "SUPER + CTRL + ALT + RIGHT"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "r+1" })'')
    ];
  }

  {
    _args = [
      "SUPER + CTRL + ALT + LEFT"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "r-1" })'')
    ];
  }

  {
    _args = [
      "SUPER + BACKSPACE"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell drawers toggle session")'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + CTRL + LEFT"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "l" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + CTRL + RIGHT"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "r" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + CTRL + UP"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "u" })'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + CTRL + DOWN"
      (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "d" })'')
    ];
  }

#  {
#    _args = [
#      "SUPER + MOUSE_DOWN"
#      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e+1" })'')
#    ];
#  }
#
#  {
#    _args = [
#      "SUPER + MOUSE_UP"
#      (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e-1" })'')
#    ];
#  }

  {
    _args = [
      "SUPER + V"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy")'')
    ];
  }
  {
    _args = [
      "SUPER + B"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprkeys -bkr | rofi -dmenu")'')
    ];
  }

#  {
#    _args = [
#      "SUPER + S"
#      "togglespecialworkspace"
#    ];
#  }
#  {
#    _args = [
#      "ALT + SUPER + S"
#      "movetoworkspace"
#      "special"
#    ];
#  }

#  {
#    _args = [
#      "SUPER + A"
#      "layoutmsg"
#      "move -col"
#    ];
#  }
#  {
#    _args = [
#      "SUPER + D"
#      "layoutmsg"
#      "move +col"
#    ];
#  }

  {
    _args = [
      "SUPER + T"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${term}")'')
    ];
  }
  {
    _args = [
      "SUPER + E"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${file}")'')
    ];
  }
  {
    _args = [
      "SUPER + F"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${browser}")'')
    ];
  }
  {
    _args = [
      "SUPER + N"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${notes}")'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + A"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell drawers toggle launcher")'')
      ];
  }

  {
    _args = [
      "SUPER + Q"
      #(lib.generators.mkLuaInline ''hl.dsp.exec_cmd("custom-dontkillsteam")'')
        (lib.generators.mkLuaInline ''hl.dsp.window.kill()'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + W"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar")'')
    ];
  }

  {
    _args = [
      "SUPER + L"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell lock lock")'')
    ];
  }

  {
    _args = [
      "F11"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia screenshot")'')
    ];
  }

  {
    _args = [
      "SUPER + SHIFT + S"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell picker open")'')
    ];
  }

  {
    _args = [
      "CTRL + SUPER + 6"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("custom-killall")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 7"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("custom-performance")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 1"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar")'')
    ];
  }

  {
    _args = [
      "CTRL + SUPER + 4"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("caelestia shell notifs toggleDnd")'')
    ];
  }

  {
    _args = [
      "CTRL + SUPER + 3"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pavucontrol")'')
    ];
  }

  {
    _args = [
      "CTRL + SHIFT + ALT + 0"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty --hold --class \"custom-changeAudioOutput\" --name \"Select audio output\" zsh -c \"custom-changeAudioOutput\"")'')
    ];
  }

  {
    _args = [
      "CTRL + SUPER + 5"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("gnome-characters")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 8"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprpicker | tee >(wl-copy) | cliphist store")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 0"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("custom-tomato")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 2"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("custom-bottom")'')
    ];
  }

  {
    _args = [
      "CTRL + ALT + 9"
      (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("anki")'')
    ];
  }
];

      /*binde = [
        "${mod}+Shift, Right, resizeactive, 30 0"
        "${mod}+Shift, Left, resizeactive, -30, 0"
        "${mod}+Shift, Up, resizeactive, 0 -30"
        "${mod}+Shift, Down, resizeactive,m 0 30"
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
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
        "${mod}, Z, movewindow"
        "${mod}, X, resizewindow"
      ];*/
      # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
      # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
            hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
            hl.exec_cmd("dbus-update-activation-environment --systemd --all") -- for XDPH
            hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
            hl.exec_cmd("systemctl --user start xdg-desktop-portal-wlr.service")
            hl.exec_cmd("blueman-applet") -- systray app for Bluetooth
            hl.exec_cmd("udiskie --no-automount --smart-tray") -- front-end that allows to manage removable media
            hl.exec_cmd("nm-applet --indicator") -- systray app for Network/wifi
            hl.exec_cmd("rm -rf ~/.cache/cliphist/ && wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store")
            hl.exec_cmd("custom-batterynotify")
            hl.exec_cmd("custom-batterywarning")
            hl.exec_cmd("awww img ${wallpaper}")
            hl.exec_cmd("awww-daemon")
            hl.exec_cmd("sleep 1 && custom-wallpaper")
            hl.exec_cmd("custom-checkKdrive && custom-mountkdrive") -- checks if the remote works and mount it
            hl.exec_cmd("custom-gitnotify")
            hl.exec_cmd("sleep 4 & caelestia-shell") -- works better if it sleeps a bit before
            hl.exec_cmd("sleep 20 && ngcp pull --automatic") -- see github.com/tomasriveral/nix-git-cherry-picker
            end
            '')
        ];
      };
      #splash = true; # remove default background on startup
      # gestures (also keybindings)
      gesture = [
        {
          fingers = 3;
          direction = "right";
          action = "move";
        }
        {
          fingers = 3;
          direction = "left";
          action = "move";
        }
        {
          fingers = 2;
          direction = "pinchin";
          action = "cursor_zoom";
          mode = "live";
          zoom_level = 2;
        }
        {
          fingers = 2;
          direction = "pinchout";
          action = "cursor_zoom";
          mode = "live";
          zoom_level = -2;

        }
      ];


      # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
      # █░▀░█ █▄█ █#░▀█ █ ░█░ █▄█ █▀▄
      monitor = [
  {
    output = "";
    mode = "preferred";
    position = "auto";
    scale = "auto";
  }

  {
    output = "HDMI-A-1";
    mode = "highres@highrr";
    position = "auto-left";
    scale = 1;
  }
];
      # _______  ___      __   __  _______  ___   __    _  _______
      #|       ||   |    |  | |  ||       ||   | |  |  | ||       |
      #|    _  ||   |    |  | |  ||    ___||   | |   |_| ||  _____|
      #|   |_| ||   |    |  |_|  ||   | __ |   | |       || |_____
      #|    ___||   |___ |       ||   ||  ||   | |  _    ||_____  |
      #|   |    |       ||       ||   |_| ||   | | | |   | _____| |
      #|___|    |_______||_______||_______||___| |_|  |__||_______|
      #
      
      /*"plugin:dynamic-cursors" = {
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
      };*/

      #####################################################
      #####################################################
      # theme
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
      workspace_rule = [
  {
    workspace = "1";
    layout = "master";
  }

  {
    workspace = "2";
    layout = "scrolling";
    layout_opts = {
      direction = "right";
    };
  }

  {
    workspace = "name:special";
    layout = "scrolling";
  }
];

      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
      window_rule = [
  {
    match = {
      class = "firefox";
    };
    opacity = "0.90 0.90";
  }

  {
    match = {
      class = "Brave-browser";
    };
    opacity = "0.90 0.90";
  }

  {
    match = {
      class = "code-oss";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "Code";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "code-url-handler";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "code-insiders-url-handler";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "kitty";
    };
    opacity = "0.75 0.75";
  }

  {
    match = {
      class = "org.kde.dolphin";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "org.kde.ark";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "nwg-look";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "qt5ct";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "qt6ct";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "kvantummanager";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "org.pulseaudio.pavucontrol";
    };
    opacity = "0.80 0.70";
    float = true;
  }

  {
    match = {
      class = "blueman-manager";
    };
    opacity = "0.80 0.70";
    float = true;
  }

  {
    match = {
      class = "nm-applet";
    };
    opacity = "0.80 0.70";
    float = true;
  }

  {
    match = {
      class = "nm-connection-editor";
    };
    opacity = "0.80 0.70";
    float = true;
  }

  {
    match = {
      class = "org.kde.polkit-kde-authentication-agent-1";
    };
    opacity = "0.80 0.70";
    float = true;
  }

  {
    match = {
      class = "polkit-gnome-authentication-agent-1";
    };
    opacity = "0.80 0.70";
  }

  {
    match = {
      class = "org.freedesktop.impl.portal.desktop.gtk";
    };
    opacity = "0.80 0.70";
  }

  {
    match = {
      class = "org.freedesktop.impl.portal.desktop.hyprland";
    };
    opacity = "0.80 0.70";
  }

  {
    match = {
      class = "[Ss]team";
    };
    opacity = "0.70 0.70";
  }

  {
    match = {
      class = "steamwebhelper";
    };
    opacity = "0.70 0.70";
  }

  {
    match = {
      class = "Spotify";
    };
    opacity = "0.70 0.70";
  }

  {
    match = {
      initial_title = "Spotify Free";
    };
    opacity = "0.70 0.70";
  }

  {
    match = {
      class = "com.github.rafostar.Clapper";
    };
    opacity = "0.90 0.90";
    float = true;
  }

  {
    match = {
      class = "com.github.tchx84.Flatseal";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "hu.kramo.Cartridges";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "com.obsproject.Studio";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "gnome-boxes";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "discord";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "WebCord";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "ArmCord";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "app.drey.Warp";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "net.davidotek.pupgui2";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "yad";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "Signal";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "io.github.alainm23.planify";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "io.gitlab.theevilskeleton.Upscaler";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "com.github.unrud.VideoDownloader";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "io.gitlab.adhami3310.Impression";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "io.missioncenter.MissionCenter";
    };
    opacity = "0.80 0.80";
    float = true;
  }

  {
    match = {
      class = "io.github.flattool.Warehouse";
    };
    opacity = "0.80 0.80";
  }

  {
    match = {
      class = "org.kde.dolphin";
      title = "Progress Dialog — Dolphin";
    };
    float = true;
  }

  {
    match = {
      class = "org.kde.dolphin";
      title = "Copying — Dolphin";
    };
    float = true;
  }

  {
    match = {
      class = "firefox";
      title = "Picture-in-Picture";
    };
    float = true;
  }

  {
    match = {
      class = "firefox";
      title = "Library";
    };
    float = true;
  }

  {
    match = {
      class = "kitty";
      title = "top";
    };
    float = true;
  }

  {
    match = {
      class = "kitty";
      title = "btop";
    };
    float = true;
  }

  {
    match = {
      class = "kitty";
      title = "htop";
    };
    float = true;
  }

  {
    match = {
      class = "vlc";
    };
    float = true;
  }

  {
    match = {
      class = "eog";
    };
    float = true;
  }

  {
    match = {
      class = "custom-browserprofiles";
    };
    float = true;
    size = [400 225];
  }

  {
    match = {
      class = "custom-changeAudioOutput";
    };
    float = true;
    size = [1050 200];
  }

  {
    match = {
      class = "custom-obsidianvaults";
    };
    float = true;
    size = [400 175];
  }

  {
    match = {
      initial_class = "custom-pomodoro";
    };
    float = true;
    size = [600 600];
  }

  {
    match = {
      initial_class = "custom-bottom";
    };
    float = true;
    size = [1500 800];
  }
];
      layer_rule = [
  {
    match = {
      namespace = "rofi";
    };
    blur = true;
    ignore_alpha = 0;
  }

  {
    match = {
      namespace = "notifications";
    };
    blur = true;
    ignore_alpha = 0;
  }

  {
    match = {
      namespace = "swaync-notification-window";
    };
    blur = true;
    ignore_alpha = 0;
  }

  {
    match = {
      namespace = "swaync-control-center";
    };
    blur = true;
    ignore_alpha = 0;
  }

  {
    match = {
      namespace = "logout_dialog";
    };
    blur = true;
  }
];
    };
  };
}
