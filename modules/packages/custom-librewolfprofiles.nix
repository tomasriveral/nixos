_: {
  perSystem = {pkgs, ...}: {
    # fzf librewolf profile selector
    packages.custom-librewolfprofiles = pkgs.writeShellApplication {
      name = "custom-librewolfprofiles";
      runtimeInputs = with pkgs; [
        zsh
        fzf
      ];
      text = ''
        # List of profiles
        profiles=("work" "other" "private window")

        # Use fzf to select
        selected=$(printf "%s\n" "''${profiles[@]}" | fzf --height 6 --reverse --prompt="Select LibreWolf profile:")

        # If user cancels, exit
        [[ -z "$selected" ]] && exit 0

        # Launch LibreWolf detached, keeping environment
        if [[ "$selected" == "private window" ]]; then
          setsid  librewolf --private-window --no-remote >/dev/null 2>&1 &
              pkill -f "kitty.*Select LibreWolf profile"
        else
          setsid  librewolf -P "$selected" --no-remote >/dev/null 2>&1 &
              pkill -f "kitty.*Select LibreWolf profile"
        fi

        # Exit the kitty terminal after selection
        exit
      '';
    };
  };
}
