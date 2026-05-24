{ inputs, self, ...}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit (self) pkgs pkgs-unstable;
    };
    modules = with self.nixosModules; [
#inputs.home-manager.nixosModules.home-manager      
#inputs.home-manager.nixosModules.default
# keep this alphabetically organised


home-manager-laptop
      laptop
      { nixpkgs.pkgs = self.pkgs; }

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
    ];};
  flake.nixosModules.laptop = { ... }: {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

    /*#home-manager.users.tomasr = self.home.Configurations.tomasr;
    #home-manager.nixosModule.home-manager.users.tomasr = self.homeConfigurations.tomasr;
    home-manager.users.tomasr = {
  imports = [
      self.homeModules.tomasr
  ];
};*/
  };
  flake.nixosModules.home-manager-laptop = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];
    
    # Warning. Git is used in case I break everything up. It already saved me once
    environment.systemPackages = [ pkgs.git ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
         #inherit (self) pkgs-unstable;
         pkgs-unstable = self.pkgs-unstable;
         inherit self;
      };
    };

    users.users.tomasr = {
      isNormalUser = true;
      #shell = pkgs.zsh;
    };
    home-manager.users.tomasr = self.homeModules.tomasrModule;
  };
  # we shouldn't use homeConfigurations as it makes a standalone home-manager config
  flake.homeModules.tomasrModule = { ... }: {
    imports = with self.homeModules; [
      inputs.caelestia-shell.homeManagerModules.default
      anki
      caelestia
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
      #tomasr
     vivify
      zoxide
      zsh
      zsh-laptop
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
