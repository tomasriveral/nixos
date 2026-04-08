{ 
  config,
  pkgs,
  pkgs-unstable,
  caelestia-shell,
  ...
}: {
  # set profile picture in ~/.face
  programs.caelestia = {
  enable = true;
  systemd = {
    enable = false; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  settings = { # default config https://github.com/caelestia-dots/shell?tab=readme-ov-file#example-configuration
    appearance = {
      mediaGifSpeedAdjustment = 300;
      sessionGifSpeed = 0.7;
      anim = {
        duration = {
          scale = 1;
        };
      };
      font = {
        family = {
          clock = "Rubik"; # (TODO figure out those fonts)
          material = "Material Symboles Rounded";
          mono = "CaskaydiaCove NF";
          sans = "Rubik";
        };
        size = {
          scale = 1;
        };
      };
      padding = {
        scale = 1;
      };
      rounding = {
        scale = 1;
      };
      spacing = {
        scale = 1;
      };
      transparency = {
        enabled = false;
        base = 0.85;
        layeres = 0.4;
      };
    };
    general = {
      logo = "caelestia";
      apps = {
        terminal = [ "kitty" ]; # default foot
        audio = [ "pavucontrol" ];
        playback = [ "mpv" ]; # what's that?
        explorer = [ "nautilus" ]; # default thunar
      };
      battery = {
        wanLevels = [
          {
            level = 20;
            title = "Low battery";
            message = "You might want to plug in a charger";
            icon = "battery_android_frame_2";
          }
          {
            level = 10;
            title = "Did you see the previous message?";
            message = "You should probably plug in a charger <b>now</b>";
            icon = "battery_android_frame_1";
          }
          {
            level = 5;
            title = "Critical battery level";
            message = "PLUG THE CHARGER RIGHT NOW!!";
            icon = "battery_android_alert";
            critical = true;
          }
        ];
        criticalLevel = 3;
      };
      idle = {
        lockBeforeSleep = true;
        inhibitWhenAudio = true;
        timeouts = [
          {
            timeout = 180;
            idleAction = "lock";
          }
          {
            timeout = 300;
            idleAction = "dpms off"; # what's that?
            returnAction = "dpms on";
          }
          {
            timeout = 600;
            idleAction = [ "systemctl" "suspend-then-hibernate" ];
          }
        ];
      };
    };
    background = {
      desktopClock = {
        enabled = false;
        scale = 1.0;
        position = "bottom-right";
        shadow = {
          enabled = true;
          opacity = 0.7;
          blur = 0.4;
        };
        background = {
          enabled = false;
          opacity = 0.7;
          blur = true;
        };
        invertColors = false;
      };
      enabled = true; #ptet changer ca pour wallpaper
      visualiser = {
        blur = false;
        enabled = false;
        autohide = true;
        rounding = 1;
        spacing = 1;
      };
    };
    bar = {
      activeWindow = {
        compact = false;
        inverted = false;
        showOnHover = true;
      };
      clock = {
        background = false;
        showDate = false;
        showIcon = true;
      };
      dragThreshold = 20;
      entries = [
        {
          id = "logo";
          enabled = true;
        }
        {
          id = "workspaces";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "activeWindow";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "tray";
          enabled = true;
        }
        {
          id = "clock";
          enabled = true;
        }
        {
          id = "statusIcon";
          enbaled = true;
        }
        {
          id = "power";
          enabled = true;
        }
      ];
      persistent = true;
      popouts = {
        activeWindow = true;
        statusIcon = true;
        tray = true;
      };
      scrollActions = {
        brightness = true;
        workspaces = true;
        volume = true;
      };
      showOnHover = true;
      status = {
        showAudio = false;
        showBattery = true;
        showBluetooth = true;
        showKbLayout = false;
        showMicrophone = false;
        showNetwork = true;
        showWifi = true;
        showLockStatus = true;
      };
      tray = {
        background = false;
        compact = false;
        iconSubs = [];
        recolour = false;
      };
      workspaces = {
        activeIndicator = true;
        activeLabel = "󰮯";
        activeTrail = false;
        label = " ";
        occupiedBg = false;
        occpiedLabel = "󰮯";
        perMonitorWorkspaces = true;
        showWindows = true;
        shown = 5;
        specialWorkspaceIcons = [
          {
            name = "steam";
            icon = "sports_esports";
          }
        ];
        windowIcons = [
          {
            regex = "steam(_app_(default|[0-9]+))?";
            icon = "sports_esports";
          }
        ];
      };
      excludedScreens = [ "" ]; # default says "" those this work?
    };
    border = {
      rounding = 25;
      thickness = 10;
    };
    dashboard = {
      enabled = true;
      dragThreshold = 50;
      mediaUpdateInterval = 500;
      showOnHover = true;
    };
    launcher = {
      actionsPrefix = ">";
      actions = [
        {
          name = "Calculator";
          icon = "calculate";
          description = "Do simple math equations (powered by Qalc)";
          command = [ "autocomplete" "calc" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Scheme"; # to remove
          icon = "palette";
          description = "Change the current colour scheme";
          command = [ "autocomplete" "scheme" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Wallpaper"; # to remove
          icon = "image";
          description = "Change the current wallpaper";
          command = [ "autocomplete" "wallpaper" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Variant"; # to remove
          icon = "colors";
          description = "Change the current scheme variant";
          command = [ "autocomplete" "variant" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Transparency";
          icon = "opacity";
          description = "Change shell transparency";
          command = [ "autocomplete" "transparency" ];
          enbaled = false;
          dangerous = false;
        }
        {
          name = "Random";  # to remove
          icon = "casino";
          description = "Switch to a random wallpaper";
          command = [ "caelestia" "wallpaper" "-r" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Light"; # to remove
          icon = "light_mode";
          description = "Change the scheme to light mode";
          command = [ "setMode" "light" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Dark"; # to remove
          icon = "dark_mode";
          description = "Change the scheme to dark mode";
          command = [ "setMode" "dark" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Shutdown";
          icon = "power_settings_new";
          description = "Shutdown the system";
          command = [ "systemctl" "poweroff" ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Reboot";
          icon = "cached";
          description = "Reboot the system";
          command = [ "systemctl" "reboot" ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Lock"; # does this work with ly?
          icon = "lock";
          description = "Log out of the current session";
          command = [ "loginctl" "terminate-user" "" ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Sleep";
          icon = "bedtime";
          description = "Suspend then hibernate";
          command = [ "systemctl" "suspend-then-hibernate" ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Settings"; # to remove -- > we want to do every config with nix
          icon = "settings";
          description = "Configure the shell";
          command = [ "caelestia" "shell" "controlCenter" "open" ];
          enabled = true;
          dangerous = false;
        }
      ];
      dragThreshold = 50;
      vimKeybinds = false; # intersting to put to true
      enableDangerousActions = false; # set to true
      maxShown = 7;
      maxWallpapers = 9;
      specialPrefix = "@";
      useFuzzy = { # should try
        apps = false;
        actions = false;
        schemes = false;
        variants = false;
        wallpapers = false;
      };
      showOnHover = false;
      favouriteApps = [];
      hiddenApps = [];
    };
    lock = {
      recolourLogo = false; # what's that
      hideNotifs = false;
    };
    notifs = {
      actionOnClick = false;
      clearThreshold = 0.3;
      defaultExpireTimeout = 5000;
      expantThreshold = 20;
      openeExpanded = false;
      expire = false;
    };
    osd = { # whats that
      enabled = true;
      enableBrightness = true;
      enableMicrophone = false;
      hideDelay = 2000;
    };
    paths = {
      mediaGif = "root:/assets/bongocat.gif";
      sessionGif = "root:/assets/kurukuru.gif";
      noNotifsPic = "root:/assets/dino.png";
      lockNoNotifsPic = "root:/assets/dino.png";
      wallpaperDir = "~/Pictures/Wallpapers";
      lyricsDir = "~/Music/lyrics";
    };
    services = {
      audioIncrement = 0.1;
      brightnessIncrement = 0.1;
      maxVolume = 1.0;
      defaultPlayer = "Spotify";
      gpuType = "";
      #playerAliases: [ { "from": "com.github.th_ch.youtube_music", "to": "YT Music" } ]; # how to put this into nix language?
      weatherLocation = "";
      useFahrenheit = false;
      useFahrenheitPerformance = false;
      useTwelveHourClock = false;
      smartScheme = true;
      visualisersBars = 45;
    };
    session = {
      dragThreshold = 30; # what does dragThreshold do?
      enabled = true;
      vimKeybinds = false; # maybe set to true?
      icons = {
        logout = "logout";
        shutdown = "power_settings_new";
        hibernate = "downloading"; # find a better icon
        reboot = "cached";
      };
      commands = {
        logout = [ "loginctl" "terminate-user" ];
        shutdown = [ "systemctl" "poweroff" ];
        hibernate = [ "systemctl" "hibernate" ];
        reboot =  [ "systemctl" "reboot" ];
      };
    };
    sidebar = {
      dragThreshold = 80;
      enabled = true;
    };
    # is there a way to get some system info?
    utilities = {
      enabled = true;
      maxToasts = 4; # what's that?
      toasts = {
        audioInputChanged = true;
        audioOutputChanged = true;
        capsLockChanged = true;
        chargingChanged = true;
        configLoaded = true;
        dndChanged = true;
        gameModeChanged = true;
        kbLayoutChanged = true;
        kbLimit = true;
        numLockChanged = true;
        vpnChanged = true;
        nowPlaying = false;
      };
    };
    vpn = {
      enabled = false; # default true
      provider = [
        {
          # default example-configuration
          name = "wireguard";
          interface = "your-connection-name";
          displayName = "wireguard (Your VPN)";
          enabled = false;
        }  
      ];
    };
    quickToggles = [
      {
        id = "wifi";
        enabled = true;
      }
      {
        id = "bluetooth";
        enabled = true;
      }
      {
        id = "mic";
        enabled = true;
      }
      {
        id = "settings";
        enabled = true; # should desactivate
      }
      {
        id = "gameMode";
        enabled = true; # should remap my performance mode
      }
      {
        id = "dnd"; # what's that?
        enabled = true;
      }
      {
        id = "vpn";
        enabled = false; # default true;
      }
    ];
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
    settings = {
      theme.enableGtk = true;
    };
  };
};
}
