_: {
  perSystem = {pkgs, ...}: {
    # fzf librewolf profile selector
    packages.custom-browserprofiles = pkgs.writeShellApplication {
      name = "custom-browserprofiles";
      runtimeInputs = with pkgs; [
        zsh
        fzf
        tor-browser
      ];
      text = ''
        # List of profiles
        profiles=("work" "other" "private window" "tor-browser)

        # Use fzf to select
        selected=$(printf "%s\n" "''${profiles[@]}" | fzf --height 6 --reverse --prompt="Select browser profile:")

        # If user cancels, exit
        [[ -z "$selected" ]] && exit 0

        # Launch LibreWolf detached, keeping environment
        if [[ "$selected" == "private window" ]]; then
          setsid  librewolf --private-window --no-remote >/dev/null 2>&1 &
              pkill -f "kitty.*Select browser profile"
        elif [[ "$selected" == "tor-browser" ]]; then
          setsid tor-browser >/dev/null 2>&1 & pkill -f "kitty.*Select browser profile"
        else
          setsid  librewolf -P "$selected" --no-remote >/dev/null 2>&1 &
              pkill -f "kitty.*Select browser profile"
        fi

        # Exit the kitty terminal after selection
        exit
      '';
    };
  };
}
