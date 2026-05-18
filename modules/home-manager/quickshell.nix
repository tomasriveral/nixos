# pulled from https://codeberg.org/zacoons/rivendell-hyprdots
_: {
  qt.enable = true;
  programs.quickshell = {
    systemd.enable = true;
    enable = true;
  };
  home.file.".config/quickshell" = {
    source = ../../other/quickshell;
    recursive = true;
  };
}
