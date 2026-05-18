_: {
  programs.zsh = {
    shellAliases = {
      snrt = "git -C ~/nixos add -A && time sudo nixos-rebuild test --flake ~/nixos/#laptop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
      snrs = "git -C ~/nixos add -A && time sudo nixos-rebuild switch --flake ~/nixos/#laptop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
    };
  };
}
