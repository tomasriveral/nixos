{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    initContent = ''
      # Safe cat that uses colorize plugin ccat
      custom-cat() {
        if [[ -t 1 ]]; then
          ccat "$@"
        else
          command cat "$@"
        fi
      }

          fastfetch''\n'';
    shellAliases = {
      ".." = "z ..";
      grep = "rg";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      ls = "ls -hA -s --color";
      cat = "custom-cat";
      pomodoro = "custom-tomato";
      librewolf = "kitty --class \"custom-librewolfprofiles\" --name \"Select LibreWolf profile\" --hold custom-librewolfprofiles";
      manix = "custom-manix";
      man = "custom-man";
      mplayer = "mplayer -volume 5";
    };
  };
}
