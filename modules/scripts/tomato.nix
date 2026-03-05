# used for the terminal autostart. Needs to get cleared and recall fastfetch so that the bar from oh-my-zsh get resized

{ writeShellApplication, kitty, tomato-c,... }:

writeShellApplication {
	name = "custom-tomato";
	runtimeInputs = [
      kitty
      tomato-c
	];
	text = ''
kitty --name "custom-pomodoro" -e tomato 
'';
}
