{ inputs, self, ...}: {
  flake.nixosConfiguration.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # keep this alphabetically organised
      anki
      audioAndMedia
      autoCleanup-laptop
      autoUpdate-laptop
      battery-laptop
      bluetooth
      bootloader-laptop
      browsers
      caelestia
      development
      documentation
      disk
      disk-laptop
      fonts
      games
      hardware-configuration-laptop
      hardwareUtils-laptop
      home-manager-laptop
      hyprland
      IO
      kdrive
      latex
      ly
      mullvad
      networking
      notifications
      office
      #ollama
      otherUtils
      printer
      udev
      user
    ];
  };
  flake.homeConfiguration.tomasr = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    pkgs-unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; };
    modules = with self.homeModules; [
      anki
      cursor
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
      oh-my-zsh
      ripgrep
      rofi
      sbb-tui
      ssh
      thunderbird
      tomasrModule
      vivify
      zoxide
      zsh
      zsh-laptop
    ];
  };
  flake.nixosModules.laptop = { ... }: {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

    home-manager.users.USERNAME = self.homeModules.USERNAMEModule;
  };
  flake.nixosModules.home-manager-laptop = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
  flake.homeModules.tomasrModule = { ... }: {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
    ];
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
