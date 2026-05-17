{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    shellAliases = {
      snrt = "git -C ~/nixos add -A && time sudo nixos-rebuild test --flake ~/nixos/#laptop";
      snrs = "git -C ~/nixos add -A && time sudo nixos-rebuild switch --flake ~/nixos/#laptop";
    };
  };
}
