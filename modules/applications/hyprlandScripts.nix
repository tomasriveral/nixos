_: {
  # for some reason perSystem can't expose pkgs-unstable so we need to expose it here
  # -----------------------------------------------------
  # Here are a bunch of scripts that interact with hyprland
  # Some are still used. Some are broken. Some are deprecated. But I do still keep them in case I want to go back to old tools
  # -----------------------------------------------------
  perSystem = {pkgs, ...}: let
    wallpaper1 = ../../assets/wallpaper1.jpg;
    wallpaper2 = ../../assets/wallpaper2.jpg;
    wallpaper3 = ../../assets/wallpaper3.jpg;
    wallpaper4 = ../../assets/wallpaper4.jpg;
    wallpaper5 = ../../assets/wallpaper5.jpg;
  in {
    # kills the app, but when it's steam or custom-pomodoro
    packages.custom-dontkillsteam = pkgs.writeShellApplication {
      name = "custom-dontkillsteam";
      runtimeInputs = with pkgs; [
        hyprland
        jq
      ];
      text = ''
              class=$(hyprctl activewindow -j | jq -r ".class")
        if [[ "$class" == "Steam" || "$class" == "custom-pomodoro" ]]; then
        	hyprctl dispatch movetoworkspacesilent special
        else
        	hyprctl dispatch killactive ""
        fi

      '';
    };
    packages.custom-killall = pkgs.writeShellApplication {
      name = "custom-killall";
      runtimeInputs = [
        pkgs.hyprland # for some reason pkgs-unstable doesn't work here
        pkgs.jq
      ];
      text = ''
        active_workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')

        hyprctl clients -j |
          jq -r ".[]
            | select(.workspace.id==''${active_workspace_id})
            | select(.focusHistoryID!=0)
            | .pid" |
          xargs -r kill
      '';
    };
    packages.custom-wallpaper = pkgs.writeShellApplication {
      name = "custom-wallpaper";
      runtimeInputs = with pkgs; [
        socat
        swww
      ];
      text = ''
        handle() {
          case $1 in
            workspace*)
              str=$1
              i=$((''${#str}-1))
              workspace="''${str:$i:1}"
              case $workspace in
                1 | 6)
                  swww img -t none ${wallpaper1}
                  ;;
                2 | 7)
                  swww img  -t none ${wallpaper2}
                  ;;
                3 | 8)
                  swww img  -t none ${wallpaper3}
                  ;;
                4 | 9)
                  swww img  -t none ${wallpaper4}
                  ;;
                5 | 10 | 0)
                  swww img  -t none ${wallpaper5}
                  ;;
              esac
              ;;
          esac
        }

        socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
      '';
    };
    packages.custom-launch = pkgs.writeShellApplication {
      # used for the terminal autostart. Needs to get cleared and recall fastfetch so that the bar from oh-my-zsh get resized
      # unused
      name = "custom-launch";
      runtimeInputs = with pkgs; [
        zsh
      ];
      text = ''
        sleep 2
        clear
        zsh
      '';
    };
  };
}
