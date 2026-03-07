{ writeShellApplication, kitty, tomato-c,... }:

writeShellApplication {
	name = "custom-tomato";
	runtimeInputs = [
      kitty
      tomato-c
	];
	text = ''
      kitty --class "custom-pomodoro" --name "custom-pomodoro" -e tomato
'';
}
