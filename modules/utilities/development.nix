{inputs, ...}: {
  flake.nixosModules.development = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    programs.nix-ld.enable = true; #Run unpatched dynamic binaries on NixOS. For example lets run ./a.out from gcc
    environment.systemPackages = with pkgs; [
      gcc
      jq # json parser used in some scripts
      jp # lightweight and flexible cli JSON parser
      (pkgs-unstable.python314.withPackages (ps:
        with ps; [
          matplotlib
          networkx
          scipy
        ]))
      python313Packages.pygments # used for ccat (comment of colorize plugin from oh-my-zsh)
      pkg-config
      nixpkgs-review
      gdb
      raylib
      glfw # raylib and some dependecies
      gnumake
      go
      direnv
      git gh
      cling # c interpreter used for coding
      # lsp
      clang-tools
      python314Packages.python-lsp-server
      ltex-ls-plus
      pylint
      black
      gnupg
      pinentry-curses
      inputs.nixpkgs-notifier.packages.${pkgs.system}.default
    ];
  };
  flake.homeModules.development = _: {
    home.file.".config/nixpkgs-notifier/config.json" = {
      enable = true;
      text = ''
        {
          "configTime": 3600,
          "configFetchTime": 1,
          "localNotify": true,
          "matrix": {
            "enable": true,
            "room": "!BXRRokBmEdNOyYdfOF:matrix.org",
            "ping": true,
            "userPing": "@notificationbot_0000",
            "userPingServer": "matrix.org"
          }
        }
      '';
    };
  };
}
