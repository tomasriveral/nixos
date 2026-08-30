_: {
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
  flake.homeModules.hyprland-laptop = {
    home.file.".config/hypr/host.lua" = {
      text = ''
          hl.on("hyprland.start", function()
            hl.exec_cmd("qtbatticon")
        end)

        hl.monitor({
          output = "eDP-1",
          mode = "highres@highrr",
          position = "0x0",
          scale = 1,
        })
      '';
      enable = true;
      force = true;
    };
  };
  flake.homeModules.hyprland-desktop = {
    home.file.".config/hypr/host.lua" = {
      text = ''
        hl.monitor({
          output = "",
          mode = "preferred",
          position = "auto",
          scale = 0.75,
        })
      '';
      enable = true;
      force = true;
    };
  };
  flake.homeModules.hyprland = {pkgs-unstable, ...}: let
    wallpaper1 = ../../assets/wallpaper1.jpg;
    wallpaper2 = ../../assets/wallpaper2.jpg;
    wallpaper3 = ../../assets/wallpaper3.jpg;
    wallpaper4 = ../../assets/wallpaper4.jpg;
    wallpaper5 = ../../assets/wallpaper5.jpg;

    hyprlandLua =
      builtins.replaceStrings
      [
        "WALLPAPER1/PATH/PLACEHOLDER"
        "WALLPAPER2/PATH/PLACEHOLDER"
        "WALLPAPER3/PATH/PLACEHOLDER"
        "WALLPAPER4/PATH/PLACEHOLDER"
        "WALLPAPER5/PATH/PLACEHOLDER"
      ]
      [
        (toString wallpaper1)
        (toString wallpaper2)
        (toString wallpaper3)
        (toString wallpaper4)
        (toString wallpaper5)
      ]
      (builtins.readFile ../../other/hyprland/hyprland.lua);
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
    wayland.windowManager.hyprland.extraConfig = hyprlandLua;
  };
}
