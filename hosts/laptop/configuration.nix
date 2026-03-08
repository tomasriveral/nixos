# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, libs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
	../../modules/nixos/battery.nix
    #../../modules/nixos/ly.nix
    ../../modules/nixos/lyminimal.nix
    ../../modules/nixos/anki.nix
    ../../modules/nixos/udevsimple.nix
  ];



# grub theme
boot.loader.grub = {
    theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos; # if you want to use nixos grub theme
};


  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs.outPath}"
    "home-manager=${inputs.home-manager.outPath}"
  ]; #manix is unhappy without this



home-manager = {
	useGlobalPkgs = true;
	useUserPackages = true;
	users = {
		tomasr = ./home.nix;
	};
	extraSpecialArgs = { inherit pkgs-unstable; };
};


environment.pathsToLink = [
  "/share/applications"
  "/share/xdg-desktop-portal"
];
# removes uxterm
services.xserver.excludePackages = [ pkgs.xterm ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.Name = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # zsh dont want to work if it is not initialzed here.
  programs.zsh.enable = true;
	
# Enable the GNOME Desktop Environment.
#  services.displayManager.gdm.enable = true;
#  services.desktopManager.gnome.enable = true;
# we dont use gnome but some utils yes -> see pckgs
#enable sddm
#services.displayManager.sddm = {
#	enable = true;
#	wayland.enable = true;
#};
# we use ly as the displayManager. see ../../modules/nixos/ly.nix


# enable hyprland WM
programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland; # we use the unstable branch to get the latest features
    withUWSM = true;
    xwayland.enable = true;
};



services.upower.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  # Configure console keymap
  console.keyMap = "fr_CH";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomasr = {
    isNormalUser = true;
    description = "Tomas Rivera";
    extraGroups = [ "networkmanager" "wheel" ]; #wheel allow to use sudo
    shell = pkgs.zsh;
  };

 #adds nixos experimental features:
 nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Garbage collector of generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d"; # every week delete generations older than a month
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = false;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
# use pkgs-unstable if you want the package from the unstable channel
#we need to install gnome and kde utils individually as we dont use gnome
gnome-calculator
snapshot
gnome-characters
gnome-disk-utility
kdePackages.okular
nautilus
gnome-font-viewer
wget
tree # shows dir in tree
zsh # better bash
brightnessctl # control brightness
pulseaudio # sound server
playerctl # controls media player
blueman # GTK-based Bluetooth Manager
udiskie # removable disk automounter for udisks
networkmanagerapplet # NetworkManager control applet
cliphist # Wayland clipboard manager
wl-clipboard # cli copy/past utilities for Wayland
jp # lightweight and flexible cli JSON parser
notepad-next
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
inetutils # collections of network programs such as telnet
python313Packages.pygments # used for ccat (comment of colorize plugin from oh-my-zsh)
fzf
jq # json parser used in some scripts
bottom # Cross-platform graphical process/system monitor with a customizable interface
cmatrix
tomato-c # pomodoro timer
pavucontrol # PulseAudio Volume Control
hyprshot
hyprcursor
vial # Open-source GUI and QMK fork for configuring your keyboard in real time
mplayer # Movie player that supports many video formats
chromium # used only to flash the firmware on my framework laptop 16 (keyboard.frame.work) as only chromium based browser support webHID. 
capitaine-cursors-themed # cursor theme
usbutils # used for lsusb
# used for the framework 16 laptop
framework-tool
framework-tool-tui

#some nix tools
manix
];

# fonts
fonts.packages = with pkgs; [
nerd-fonts._0xproto
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
