{ writeShellApplication, hyprland, jq, ... }:

writeShellApplication {
	name = "custom-dontkillsteam";
	runtimeInputs = [
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
}
