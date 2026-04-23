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
    ../../hostsModules/laptop/home-manager/zsh.nix # some things are hosts dependant.
    ../../modules/home-manager/gtk.nix # some config for gtk themed apps
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/hyprland.nix
    ../../hostsModules/laptop/home-manager/hyprland.nix
    #../../modules/home-manager/wlogout.nix # logout utility
    ../../modules/home-manager/rofi.nix # used for keybinds and for clipboard
    #notifications are now manager with quickshell../../modules/home-manager/swaync.nix # notification daemon
    ../../modules/home-manager/neovim.nix # dont use nixvim. broken
    #../../modules/home-manager/neovim2.nix # ./neovim2.nix uses vim plug instead of the nix repository as with ./neovim.nix see the begining of neovim2 for an explanation
    ../../modules/home-manager/rclone.nix
    #../../modules/home-manager/waybar.nix
    #../../modules/home-manager/quickshell.nix # used for widgets, waybar and notifications # i migrated to caelestia-shell
    inputs.caelestia-shell.homeManagerModules.default
    ../../modules/home-manager/caelestia.nix # caelestia shell is based on quickshell
    #../../modules/home-manager/oh-my-posh.nix # zsh customizer
    ../../modules/home-manager/oh-my-zsh.nix # another zsh customizer
    #../../modules/home-manager/hypridle.nix
    #../../modules/home-manager/swaylock.nix
    ../../modules/home-manager/anki.nix # we use only for some settings. see ../../modules/nixos/anki.nix for activating
    ../../modules/home-manager/librewolf.nix # privacy browser
    ../../modules/home-manager/cursor.nix # cursor (the icon not the app)
    ../../modules/home-manager/ripgrep.nix # better grep
    #../../modules/home-manager/obsidian.nix obsidian was replaced with a custom solution
    ../../modules/home-manager/thunderbird.nix # email client
    ../../modules/home-manager/eza.nix # ls replacement
    ../../modules/home-manager/vivify.nix # neovim markdown viewer (has also config for qutebrowser
    #../../modules/home-manager/micro.nix # micro text editor. Not main editor (used for testing for notewrapper)

    ../../modules/other/desktopEntries.nix # creates .desktop files
  ];


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
    (pkgs.callPackage ../../hostsModules/laptop/scripts/batterynotify.nix {})
    (pkgs.callPackage ../../hostsModules/laptop/scripts/batterywarning.nix {})
    (pkgs.callPackage ../../modules/scripts/weather.nix {})
    (pkgs.callPackage ../../modules/scripts/wallpaper.nix {})
    (pkgs.callPackage ../../modules/scripts/mountkdrive.nix {})
    (pkgs.callPackage ../../modules/scripts/colorpicker.nix {})
    (pkgs.callPackage ../../modules/scripts/killall.nix {}) # kill all windows except focused window
    (pkgs.callPackage ../../modules/scripts/gitnotify.nix {})
    (pkgs.callPackage ../../modules/scripts/tomato.nix {})
    (pkgs.callPackage ../../modules/scripts/librewolfprofiles.nix {})
    (pkgs.callPackage ../../modules/scripts/btm.nix {})
    (pkgs.callPackage ../../modules/scripts/manix.nix {})
    (pkgs.callPackage ../../modules/scripts/man.nix {})
    (pkgs.callPackage ../../modules/scripts/trimmer.nix {})
    (pkgs.callPackage ../../hostsModules/laptop/qt/qtbatticon.nix {})
    #pkgs
    pkgs.gruvbox-gtk-theme
    pkgs.biber
    (pkgs.texliveMedium.withPackages (
      ps:
        with ps; [
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
        ]
    ))
  ];


  home.sessionVariables = {
    EDITOR = "neovim";
    # Git update function
    # Prompts for commit message; defaults if empty
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
