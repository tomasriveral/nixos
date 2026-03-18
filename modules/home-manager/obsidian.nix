{
  config,
  pkgs,
  ...
}: {
  programs.obsidian = {
    enable = true;
    vaults.miscellanious = {
      enable = true;
      target = "/kdrive/Notes/miscellanious";
      };
  };
}
