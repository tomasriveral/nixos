# configuration is in ../../../modules/nixos/user.nix
{
  ...
}:
{
  home-manager.users.tomasr = ../../../hosts/laptop/home.nix;
}
