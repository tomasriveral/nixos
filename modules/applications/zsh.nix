_: {
  flake.homeModules.zsh-laptop = _: {
    programs.zsh = {
      shellAliases = {
        snrt = "git -C ~/nixos add -A && time sudo nixos-rebuild test --flake ~/nixos/#laptop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
        snrs = "git -C ~/nixos add -A && time sudo nixos-rebuild switch --flake ~/nixos/#laptop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
      };
    };
  };
  flake.homeModules.zsh-desktop = _: {
    programs.zsh = {
      shellAliases = {
        snrt = "git -C ~/nixos add -A && time sudo nixos-rebuild test --flake ~/nixos/#desktop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
        snrs = "git -C ~/nixos add -A && time sudo nixos-rebuild switch --flake ~/nixos/#desktop && pkill shell || true && pkill caelestia-shell || true && caelestia-shell -n > /dev/null 2>&1 & disown";
      };
    };
  };
  flake.homeModules.zsh = {pkgs-unstable, ...}: {
    home.packages = [
      #self.packages.${pkgs.system}.dejaManuallyDerived
      pkgs-unstable.deja
    ];

    programs.zsh = {
      enable = true;
      autosuggestion.enable = false; # zsh-autocomplete is replaced by deja
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
        eval "$(deja init zsh)"
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
        # i always write nvim wrong :(
        nbim = "nvim";
        nivm = "nvim";
        bivm = "nvim";
        nibm = "nvim";
        vikm = "nvim";
        nvimm = "nvim";
        nnvim = "nvim";
        nvvim = "nvim";
        nviim = "nvim";
      };
    };
  };
  flake.homeModules.oh-my-zsh = _: {
    programs.zsh.oh-my-zsh = {
      enable = true;
      theme = "jonathan";
      plugins = [
        "aliases"
        "alias-finder"
        "colored-man-pages"
        "colorize"
        "command-not-found"
        "dirhistory"
        "fzf"
        "git"
        "rclone"
        "safe-paste"
        "sudo"
      ];
    };
  };
}
