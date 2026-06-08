{inputs, ...}: {
  flake.homeModules.nixGitCherryPicker-laptop = {pkgs, ...}: {
    home.packages = [
      inputs.nix-git-cherry-picker.packages.${pkgs.system}.default
    ];
    home.file.".config/nix-git-cherry-picker/config.json" = {
      enable = true;
      text = ''
        {
          "localBranch": "laptop",
          "remoteBranch": "desktop",
          "nixConfigPath": "/home/tomasr/nixos/"
        }
      '';
      force = true;
    };
  };
  flake.homeModules.nix-git-cherry-picker-desktop = {pkgs, ...}: {
    home.packages = [
      inputs.nix-git-cherry-picker.packages.${pkgs.system}.default
    ];
  };
  home.file.".config/nix-git-cherry-picker/config.json" = {
    enable = true;
    text = ''
      {
        "localBranch": "desktop",
        "remoteBranch": "laptop",
        "nixConfigPath": "/home/tomasr/nixos/"
      }
    '';
    force = true;
  };
}
