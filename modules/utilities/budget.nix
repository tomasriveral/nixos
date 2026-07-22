_: {
  flake.nixosModules.hledger = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      hledger
      hledger-ui
      hledger-web
      asciinema # used for some hledger demos
    ];
  };
  flake.nixosModules.hledger-laptop = _: {
    environment.variables = {
      LEDGER_FILE = "/home/tomasr/kdrive/Budget/hledger.journal";
    };
  };
  flake.nixosModules.hledger-desktop = _: {
    environment.variables = {
      LEDGER_FILE = "/home/tomasr/hdd/kdrive/Budget/hledger.journal";
    };
  };
}
