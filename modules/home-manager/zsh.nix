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

      custom-eza() { # behaves differently if we just call it or if we pipe initContent
        if [[ -t 1 ]]; then
          eza -hlF -aa --color=always --hyperlink --group-directories-first --show-symlinks --icons=always --git --no-permissions "$@"
        else
          command eza "$@"
        fi
      }
      eval "$(direnv hook zsh)"
      export PATH="$PATH:$HOME/NoteWrapper" # some project im coding
            fastfetch''\n'';
    shellAliases = {
      ".." = "z ..";
      grep = "rg";
      ll = "custom-eza"; # if there is a special ls just use the big eza
      la = "custom-eza";
      l = "custom-eza";
      eza = "custom-eza";
      ls = "\\eza -a"; # ls -> normal ls. eza gives more info
      tree = "\\eza -hlTF --color=always --hyperlink --group-directories-first --show-symlinks --icons=always --git --no-permissions";
      cat = "custom-cat";
      pomodoro = "custom-tomato";
      librewolf = "kitty --class \"custom-librewolfprofiles\" --name \"Select LibreWolf profile\" --hold custom-librewolfprofiles";
      manix = "custom-manix";
      man = "custom-man";
      mplayer = "mplayer -volume 5";
      # these are to create the developpement shell
      cenv = "nix-shell -p zsh gcc raylib libx11 libGL";
    };
  };
}
