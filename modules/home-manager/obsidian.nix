{
  config,
  pkgs,
  ...
}: {
  programs.obsidian = {
    enable = true;
    vaults.miscellanious = {
      enable = true;
      target = "/Documents/Notes/miscellanious"; # target is relative to ~ #not directly to kdrive. It causes problems
    };
    vaults.work = {
      enable = true;
      target = "/Documents/Notes/work";
    };
    defaultSettings = {
      
    };
  };
}
