{ ... }: {
  flake.packages.custom-bottom = { pkgs, ... }:
  pkgs.writeShellApplication {
    name = "custom-bottom";
    runtimeInputs = with pkgs; [
      kitty
      bottom
    ];
    text = ''
      kitty --class "custom-bottom" -o font_size=10 --name "custom-bottom" -e btm --theme gruvbox --disable-click --disable_advanced_kill --enable_cache_memory -g -R -T
    '';
  };
}
