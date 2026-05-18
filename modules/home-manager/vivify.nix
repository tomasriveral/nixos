{pkgs-unstable, ...}: {
  home.file.".config/vivify/config.json" = {
    enable = true;
    text = ''
      {
            "browserOptions": {
              "name": "qutebrowser",
              "arguments": ["-T"]
            }
        }'';
  };
  home.packages = [
    pkgs-unstable.vivify
  ];
  programs.qutebrowser = {
    enable = true;
    settings = {
      auto_save.session = false;
      changelog_after_upgrade = "never";
      content.cookies.accept = "never";
    };
  };
}
