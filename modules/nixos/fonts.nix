{
  pkgs,
  ...
}:
{
  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    cinzel
    times-newer-roman
  ];

  environment.systemPackages = with pkgs; [
    gnome-font-viewer
  ];
}
