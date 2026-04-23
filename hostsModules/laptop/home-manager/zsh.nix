{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    shellAliases = {
      snrt = "git add -A && sudo nixos-rebuild test --flake ~/nixos/#laptop";
      snrs = "git add -A && sudo nixos-rebuild switch --flake ~/nixos/#laptop";
    };
  };
}
