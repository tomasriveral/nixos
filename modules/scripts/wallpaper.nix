{ writeShellApplication, socat, swww, ... }:

let
	wallpaper1 = ../../assets/wallpaper1.jpg;
	wallpaper2 = ../../assets/wallpaper2.jpg;
	wallpaper3 = ../../assets/wallpaper3.jpg;
	wallpaper4 = ../../assets/wallpaper4.jpg;
	wallpaper5 = ../../assets/wallpaper5.jpg;
in

writeShellApplication {
	name = "custom-wallpaper";
	runtimeInputs = [
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
}
