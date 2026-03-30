{
  config,
  pkgs,
  inputs,
  ...
}: {
  # every import imports a specific module for an app. This module contains the enabling of this app and its settings.
  # So if you want to add an home-manager app create a module which enables it and configures it and import it.
  imports = [
    # app modules
    ../../modules/home-manager/kitty.nix # terminal # use absolute path with --impure flag or go back to /etc/nixos and use relative
    ../../modules/home-manager/zoxide.nix # better cd
    ../../modules/home-manager/zsh.nix # better bash
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/wlogout.nix # logout utility
    ../../modules/home-manager/rofi.nix # launcher and keybindings helper
    #notifications are now manager with quickshell../../modules/home-manager/swaync.nix # notification daemon 
    ../../modules/home-manager/neovim.nix # dont use nixvim. broken
    #../../modules/home-manager/neovim2.nix # ./neovim2.nix uses vim plug instead of the nix repository as with ./neovim.nix see the begining of neovim2 for an explanation
    ../../modules/home-manager/rclone.nix
    #../../modules/home-manager/waybar.nix
    ../../modules/home-manager/quickshell.nix # used for widgets, waybar and notifications
#../../modules/home-manager/oh-my-posh.nix # zsh customizer
    ../../modules/home-manager/oh-my-zsh.nix # another zsh customizer
    ../../modules/home-manager/hypridle.nix
    ../../modules/home-manager/swaylock.nix
    ../../modules/home-manager/anki.nix # we use only for some settings. see ../../modules/nixos/anki.nix for activating
    ../../modules/home-manager/librewolf.nix # privacy browser
    ../../modules/home-manager/cursor.nix # cursor (the icon not the app)
    ../../modules/home-manager/ripgrep.nix # better grep
    #../../modules/home-manager/obsidian.nix obsidian was replaced with a custom solution
    ../../modules/home-manager/thunderbird.nix # email client
  ];

  #programs.nixvim = {
  #	enable = true;
  #	imports = [ ../../modules/nixvim/neovim.nix ];
  #	package = pkgs.neovim;
  #};
  # Home Manager needs a bit of information about you and the paths it should

  # Required for Home Manager
  home.username = "tomasr";
  home.homeDirectory = "/home/tomasr";
  home.stateVersion = "25.11"; # match your Home Manager release

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    #scritps
    (pkgs.callPackage ../../modules/scripts/dontkillsteam.nix {}) # kill app (if it is steam put it in some background
    (pkgs.callPackage ../../modules/scripts/batterynotify.nix {})
    (pkgs.callPackage ../../modules/scripts/batterywarning.nix {})
    (pkgs.callPackage ../../modules/scripts/weather.nix {})
    (pkgs.callPackage ../../modules/scripts/cowsay.nix {})
    (pkgs.callPackage ../../modules/scripts/wallpaper.nix {})
    (pkgs.callPackage ../../modules/scripts/mountkdrive.nix {})
    (pkgs.callPackage ../../modules/scripts/weatherwaybar.nix {})
    (pkgs.callPackage ../../modules/scripts/colorpicker.nix {})
    (pkgs.callPackage ../../modules/scripts/killall.nix {}) # kill all windows except focused window
    (pkgs.callPackage ../../modules/scripts/launch.nix {}) # necessary for the apps i launch with hyprland at every start
    (pkgs.callPackage ../../modules/scripts/gitnotify.nix {})
    (pkgs.callPackage ../../modules/scripts/tomato.nix {})
    (pkgs.callPackage ../../modules/scripts/librewolfprofiles.nix {})
    (pkgs.callPackage ../../modules/scripts/performance-mode.nix {})
    (pkgs.callPackage ../../modules/scripts/btm.nix {})
    (pkgs.callPackage ../../modules/scripts/manix.nix {})
    (pkgs.callPackage ../../modules/scripts/man.nix {})
    (pkgs.callPackage ../../modules/scripts/trimmer.nix {})
    #(pkgs.callPackage ../../modules/scripts/obsidianbackup.nix {}) # periodically syncs obsidian's note to kdrive
    #(pkgs.callPackage ../../modules/scripts/obsidianprofiles.nix {}) # fzf vault selector # obsidian was replaced with a custom solution
    (pkgs.callPackage ../../modules/scripts/QSsysinfo.nix {})
    (pkgs.callPackage ../../modules/scripts/QSnotifycache.nix {})
    (pkgs.callPackage ../../modules/scripts/QSnotifyhistory.nix {})
#pkgs
    pkgs.gruvbox-gtk-theme
    pkgs.biber
    (pkgs.texliveMedium.withPackages (
      ps: with ps; [
        # these few pkgs are used in the CV template
        titlesec # allows creating custom \section
        marvosym # some symboles
        ebgaramond # Use the EB Garamond font
        microtype # To enable letterspacing
        fontaxes
        # these few pkgs were used for my TM
        svg
        catchfile
        caption
        transparent
        cfr-lm
        svn-prov
        nfssext-cfr
        hyphenat
        csquotes
        enumitem
        chngcntr
        tcolorbox
        pdfcol
        wrapfig
        tocloft
        lastpage
        biblatex
        biblatex-iso690
        libertine
        minted
        upquote
        lipsum
        footmisc
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  ]))
   # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  #maybe migrate both of them in a separate file
  # gtk config
  gtk.theme = {
    enable = true;
    Gruvbox-GTK-Theme-BL-MB = {
      enable = true;
      name = "Gruvbox-GTK-Theme-BL-MB";
      package = pkgs.gruvbox-gtk-theme;
    };
  };

  # ssh config

  programs.ssh.enable = true;
  services.ssh-agent.enable = true;

  home.file.".ssh/config".text = ''
    Host *
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_ed25519
  '';

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tomasr/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
    # Git update function
    # Prompts for commit message; defaults if empty
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
