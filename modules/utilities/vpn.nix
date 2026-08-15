# config for openconnect is in ./epfl.nix
{self, ...}: {
  flake.nixosModules.vpn = {pkgs, ...}: {
    services.mullvad-vpn = {
      enable = true;
    };
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-vpn-picker
    ];
    age.secrets.epfl = {
      file = ../../secrets/epfl.age;
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-vpn-picker = pkgs.writeShellApplication {
      name = "custom-vpn-picker";

      runtimeInputs = with pkgs; [
        fzf
        mullvad-compass
        mullvad
        openconnect
        gawk
        wl-clipboard
        cliphist
      ];

      text = ''
        mullvad_connect () {
          mullvad disconnect
          mullvad relay set location "$1"
          mullvad connect
        }

        profiles=(
          "mullvad-best"
          "mullvad-zurich"
          "mullvad-tirana"
          "mullvad-bogota"
          "epfl"
          "disconnect"
        )

        selected=$(printf "%s\n" "''${profiles[@]}" |
          fzf --height 8 --reverse --prompt="Select vpn:")

        [[ -z "$selected" ]] && exit 0

        if [[ "$selected" == "mullvad-best" ]]; then
          mullvad_connect "$(
            mullvad-compass |
              awk '/Best server:/ {
                getline
                split($1, a, "-")
                print a[1]
              }'
          )"

        elif [[ "$selected" == "mullvad-zurich" ]]; then
          mullvad_connect ch

        elif [[ "$selected" == "mullvad-tirana" ]]; then
          mullvad_connect al

        elif [[ "$selected" == "mullvad-bogota" ]]; then
          mullvad_connect co

        elif [[ "$selected" == "epfl" ]]; then
          # shellcheck disable=SC1091
          source /run/agenix/epfl

          # Put password in clipboard so it can be pasted into openconnect.
          printf '%s' "$EPFL_VPN_PASSWORD" | wl-copy

          sudo openconnect \
            --background \
            --pid-file="$HOME/.local/state/epfl-openconnect.pid" \
            --server="$EPFL_VPN_SERVER" \
            --user="$EPFL_VPN_USER"

          # Remove the password from cliphist and clear the current clipboard.
          cliphist delete-query "$EPFL_VPN_PASSWORD" || true
          wl-copy --clear

        elif [[ "$selected" == "disconnect" ]]; then
          if [[ -f "$HOME/.local/state/epfl-openconnect.pid" ]]; then
            sudo kill "$(cat "$HOME/.local/state/epfl-openconnect.pid")" 2>/dev/null || true
          fi

          mullvad disconnect
          rm "$HOME/.local/state/epfl-openconnect.pid"
        fi

        pkill -f "kitty.*Select vpn option" || true
        exit
      '';
    };
  };
}
