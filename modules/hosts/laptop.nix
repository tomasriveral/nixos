{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    #system = "x86_64-linux";
    specialArgs = {
      inherit (self) pkgs-unstable pkgs-local pkgs-master;
    };
    modules = with self.nixosModules; [
      # important do not remove
      home-manager-laptop
      laptop
      {nixpkgs.pkgs = self.pkgs;}
      # keep this alphabetically organised
      anki
      audioAndMedia
      autoCleanup-laptop
      autoUpdate-laptop
      battery-laptop
      bluetooth
      bootloader
      browsers
      caelestia
      development
      documentation
      disk
      disk-laptop
      fonts
      gitBackup
      hardware-configuration-laptop
      hardwareUtils-laptop
      hyprland
      IO
      kdrive-laptop
      latex
      ly
      mathematics
      mullvad
      networking
      nixUtils-laptop
      nixUtils
      notifications
      office
      #ollama
      otherUtils
      printer
      rss
      udev
      user
    ];
  };
  flake.homeModules.laptop = {...}: {
    imports = with self.homeModules; [
      inputs.caelestia-shell.homeManagerModules.default
      anki
      caelestia
      caelestia-laptop
      cursor
      development
      eza
      fastfetch
      git
      gtk
      hyprland
      hyprland-laptop
      kitty
      librewolf
      mullvad
      neovim
      nix-git-cherry-picker-laptop
      notewrapper
      oh-my-zsh
      ripgrep
      rofi
      sbb-tui
      ssh
      swaync # used in performance mode
      thunderbird
      tomasr
      vivify
      waybar-minimal # used in performance mode
      zoxide
      zsh
      zsh-laptop
    ];
  };
  flake.nixosModules.laptop = _: {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  flake.nixosModules.home-manager-laptop = {pkgs, ...}: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];

    # Warning. Git is used in case I break everything up. It already saved me once
    environment.systemPackages = [pkgs.git];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit (self) pkgs-unstable pkgs-local pkgs-master;
        inherit self;
      };
    };

    users.users.tomasr = {
      isNormalUser = true;
    };
    home-manager.users.tomasr = self.homeModules.laptop;
  };
  flake.homeModules.tomasr = _: {
    home.username = "tomasr";
    home.homeDirectory = "/home/tomasr";

    home.sessionVariables = {
      EDITOR = "neovim";
      TERMINAL = "kitty";
    };

    # Required for Home Manager
    home.stateVersion = "25.11"; # match your Home Manager release
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
