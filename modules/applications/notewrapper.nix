{inputs, ...}: {
  flake.homeModules.laptop-notewrapper = {pkgs, ...}: {
    home.packages = [
      inputs.notewrapper.packages.${pkgs.system}.default
    ];
    home.file.".config/notewrapper/config.json" = {
      enable = true;
      force = true;
      text = ''
        {
          "directory": ["~/Documents/Notes/"],
          "render": true,
          "jumpToEndOfFileOnLaunch": true,
          "editor": "neovim",
          "journalRegex": ".*journal.*",
          "dateEntry": "# %Y %m %d %a",
          "newLineOnOpening": true,
          "backup": {
            "enable": true,
            "directory": {
              "~/Documents/Notes/": "~/kdrive/Notes/"
            },
            "interval": "daily",
            "rsyncArgs": ["-Lqah", "--update"],
            "git": {
              "enable": true,
              "name": "Tomas Rivera",
              "email": "tomas.riveral@icloud.com"
            }
          }
        }
      '';
    };
  };
  flake.homeModules.desktop-notewrapper = {pkgs, ...}: {
    home.packages = [
      inputs.notewrapper.packages.${pkgs.system}.default
    ];
    home.file.".config/notewrapper/config.json" = {
      enable = true;
      force = true;
      text = ''
        {
          "directory": ["~/hdd/kdrive/Notes/"],
          "render": true,
          "jumpToEndOfFileOnLaunch": true,
          "editor": "neovim",
          "journalRegex": ".*journal.*",
          "dateEntry": "# %Y %m %d %a",
          "newLineOnOpening": true,
          "backup": {
            "enable": false,
            "directory": {
              "~/Documents/Notes/": "~/hdd/kdrive/Notes/",
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
