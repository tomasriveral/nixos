{self, ...}: {
  flake.nixosModules.otherUtils =
    # try to keep packages here at a minium. Preferably use a dedicated file
    {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        gnome-calculator
        snapshot
        gnome-characters
        #tree # shows dir in tree # we use eza now
        brightnessctl # control brightness
        powertop
        fzf
        bottom # Cross-platform graphical process/system monitor with a customizable interface
        tomato-c # pomodoro timer
        #hyprshot
        mailcap
        fuzzel
        usbutils # used for lsusb
        self.packages.${pkgs.system}.custom-tomato
        self.packages.${pkgs.system}.custom-syllabes
        # Electron 39 EOL. https://github.com/bitwarden/clients/pull/20448 should move it to 41. For the moment use the browser extension
        #pkgs-unstable.bitwarden-desktop
        fluffychat # matrix client
      ];
    };
}
