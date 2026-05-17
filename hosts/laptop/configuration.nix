# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  libs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../hostsModules/laptop/nixos/battery.nix
    #../../modules/nixos/ly.nix
    ../../modules/nixos/ly.nix
    ../../modules/nixos/anki.nix
    ../../modules/nixos/nixUtils.nix
    ../../hostsModules/laptop/nixos/udev.nix
    ../../hostsModules/laptop/nixos/disk.nix
    ../../modules/nixos/printer.nix
    ../../hostsModules/laptop/nixos/ollama.nix # llm config
    ../../modules/nixos/mullvad.nix # vpn config
    ../../hostsModules/laptop/nixos/autoUpdate.nix # auto update the flakes. Handles notification via libnotify and matrix-commander-rs
    ../../hostsModules/laptop/nixos/bootloader.nix
    ../../hostsModules/laptop/nixos/networking.nix # firewall, ssh, networkmanager, etc.
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/audioAndMedia.nix
    ../../modules/nixos/windowManager.nix
    ../../modules/nixos/documentation.nix
  ];


  programs.nix-ld.enable = true; #Run unpatched dynamic binaries on NixOS. For example lets run ./a.out from gcc

  qt.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      tomasr = ./home.nix;
    };
    extraSpecialArgs = {inherit inputs pkgs-unstable;};
  };

  services.dbus.enable = true;
  security.polkit.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # zsh dont want to work if it is not initialzed here.
  programs.zsh.enable = true;

  # removes rclone error
  programs.fuse.userAllowOther =  true;
  programs.fuse.enable = true;

  security.wrappers.gsr-kms-server = {
    # to remove the password prompt when using gpu-screen-recorder
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
  };

  services.upower.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  # Configure console keymap
  console.keyMap = "fr_CH";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomasr = {
    isNormalUser = true;
    description = "Tomas Rivera";
    extraGroups = ["networkmanager" "wheel" "fuse"]; #wheel allow to use sudo / fuse -> rclone
    shell = pkgs.zsh;
  };

  # removes need for password for nixos-rebuild
    security.sudo.extraRules = [
    {
      users = [ "tomasr" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];



  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; # Nonfree packages: hplipWithPlugin

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # use pkgs-unstable if you want the package from the unstable channel
    #we need to install gnome and kde utils individually as we dont use gnome
    gnome-calculator
    snapshot
    gnome-characters
    gnome-disk-utility
    gnome-font-viewer
    #tree # shows dir in tree # we use eza now
    zsh # better bash
    brightnessctl # control brightness
    udiskie # removable disk automounter for udisks
    cliphist # Wayland clipboard manager
    wl-clipboard # cli copy/past utilities for Wayland
    jp # lightweight and flexible cli JSON parser
    libnotify # Library that sends desktop notifications to a notification daemon
    hyprkeys # keybind helper
    cowsay
    cmatrix
    swww #wallpaper daemon
    socat # Utility for bidirectional data transfer between two independent data channels (used to communicate between hyprland and swww to change wallpapers dinamically)
    gcc # GNU C compiler
    libreoffice
    gruvbox-gtk-theme
    hyprpicker
    powertop
    python313Packages.pygments # used for ccat (comment of colorize plugin from oh-my-zsh)
    fzf
    jq # json parser used in some scripts
    bottom # Cross-platform graphical process/system monitor with a customizable interface
    cmatrix
    tomato-c # pomodoro timer
    #hyprshot
    mailcap
    pkgs-unstable.vimPluginsUpdater # used for building plugins
    hyprcursor
    vial # Open-source GUI and QMK fork for configuring your keyboard in real time
    chromium # used only to flash the firmware on my framework laptop 16 (keyboard.frame.work) as only chromium based browser support webHID.
    capitaine-cursors-themed # cursor theme
    usbutils # used for lsusb
    # used for the framework 16 laptop
    framework-tool
    framework-tool-tui
    (pkgs-unstable.python314.withPackages (ps:
      with ps; [
        matplotlib
        networkx
        scipy
      ]))
    fluffychat matrix-commander-rs # matrix client
    direnv
    # utils for dev
    pkg-config
    gdb
    raylib
    glfw # raylib and some dependecies
    cling # c interpreter used for coding
    # lsp
    texlab
    clang-tools
    python311Packages.python-lsp-server
    lua-language-server
    ltex-ls-plus
    pylint
    black
    # for caelestia
    kdePackages.qtdeclarative # provides qmlls and other things
    quickshell # we have it but adding it there solves "WARN qt.qpa.services: Failed to register with host portal QDBusError("org.freedesktop.portal.Error.Failed", "Could not register app ID: App info not found for 'org.quickshell'")"
    fuzzel
    papirus-icon-theme
    papirus-folders
    birdtray # thunderbird tray app
    # this is more up to date
    #(callPackage ../../modules/packages/vivify.nix {})
    #(callPackage ../../modules/packages/sbb-tui.nix {})
    pkgs-unstable.tor-browser
    pkgs-unstable.bitwarden-desktop
  ];

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    cinzel
    times-newer-roman
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # to resolve this https://wiki.nixos.org/wiki/Home_Manager#I_cannot_set_GNOME_or_Gtk_themes_via_Home_Manager
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
