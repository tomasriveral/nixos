{
  pkgs-unstable,
  ...
}: {
  home.packages = [
    pkgs-unstable.sbb-tui
  ];  
  home.file.".config/sbb-tui/config.yaml" = {
    enable = true;
# Gruvbox (from https://github.com/Necrom4/sbb-tui/blob/master/docs/themes.md)
    text = ''
ui:
  nerdfont: true
  theme:
    text:            "#EBDBB2"
    textMuted:       "#928374"
    error:           "#FB4934"
    warning:         "#FB4934"
    borderFocused:   "#FABD2F"
    borderUnfocused: "#504945"
    badgeKeyFg:      "#282828"
    badgeKeyBg:      "#FABD2F"
    badgeVehicleFg:  "#EBDBB2"
    badgeVehicleBg:  "#458588"
    badgeModelFg:    "#282828"
    badgeModelBg:    "#FB4934"
    badgeCompanyFg:  "#282828"
    badgeCompanyBg:  "#EBDBB2"
    logo:            "#EBDBB2"
'';
  };
}
