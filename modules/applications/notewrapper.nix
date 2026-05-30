{inputs, ... }: {
  flake.homeModules.notewrapper = {pkgs, ...}: {
    home.packages = [
      inputs.notewrapper.packages.${pkgs.system}.default
    ];
    home.file.".config/notewrapper/config.json" = {
      enable = true;
      force = true;
      text = ''
{
  "directory": ["~/Documents/Notes/", "~/test/"],
  "render": true,
  "jumpToEndOfFileOnLaunch": true,
  "editor": "neovim",
  "journalRegex": ".*journal.*",
  "dateEntry": "# %Y %m %d %a",
  "newLineOnOpening": true,
  "backup": {
    "enable": true,
    "directory": {
      "~/Documents/Notes/": "~/kdrive/Notes/",
      "~/test/": "~/backupTest/"
    },
    "interval": "daily",
    "rsyncArgs": ["-Lqah", "--update"]
  }
}
      '';
    };
  };
}
