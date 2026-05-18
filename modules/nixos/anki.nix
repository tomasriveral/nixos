{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (pkgs.anki.withAddons [
      (pkgs.ankiAddons.recolor.withConfig {
        config = {
          # we must specify all the colors or it crashes as this overwrite the whole colors set
          colors = {
            # ===== Foregrounds =====
            FG = ["Foreground" "#ebdbb2" "#ebdbb2" ""];
            FG_SUBTLE = ["Subtle FG" "#d5c4a1" "#d5c4a1" ""];
            FG_FAINT = ["Faint FG" "#a89984" "#a89984" ""];
            FG_DISABLED = ["Disabled FG" "#928374" "#928374" ""];

            # ===== Main Background Layers =====
            BG = ["Background" "#1d2021" "#1d2021" ""];
            MAIN_BG = ["Main Background" "#1d2021" "#1d2021" ""];
            VIEW_BG = ["View Background" "#282828" "#282828" ""];
            EDITOR_BG = ["Editor Background" "#282828" "#282828" ""];
            CANVAS = ["Canvas" "#282828" "#282828" ""];
            CANVAS_ELEVATED = ["Elevated Canvas" "#32302f" "#32302f" ""];

            # ===== Tables & Lists =====
            TABLE_BG = ["Table Background" "#282828" "#282828" ""];
            TABLE_ALT_BG = ["Table Alt Background" "#32302f" "#32302f" ""];
            HEADER_BG = ["Header Background" "#3c3836" "#3c3836" ""];
            SELECTED_BG = ["Selected Background" "#504945" "#504945" ""];

            # ===== Borders =====
            BORDER = ["Border" "#504945" "#504945" ""];
            FAINT_BORDER = ["Faint Border" "#3c3836" "#3c3836" ""];

            # ===== Buttons =====
            BUTTON_GRADIENT_START = ["Button Start" "#3c3836" "#3c3836" ""];
            BUTTON_GRADIENT_END = ["Button End" "#3c3836" "#3c3836" ""];
            BUTTON_HOVER = ["Button Hover" "#665c54" "#665c54" ""];

            # ===== Accent & Links =====
            ACCENT = ["Accent" "#458588" "#458588" ""];
            LINK = ["Link" "#83a598" "#83a598" ""];
            LINK_HOVER = ["Link Hover" "#8ec07c" "#8ec07c" ""];

            # ===== Status =====
            WARNING = ["Warning" "#fe8019" "#fe8019" ""];
            ERROR = ["Error" "#fb4934" "#fb4934" ""];
            SUCCESS = ["Success" "#8ec07c" "#8ec07c" ""];
          };
        };
        #          version = { major = 3; minor = 1; };
        # let nixpkgs handle the version
      })
    ])
  ];
}
