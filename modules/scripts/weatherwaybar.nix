{ writeShellApplication, curl, ... }:

writeShellApplication {
	name = "custom-weatherwaybar";
	runtimeInputs = [
		curl
	];
	text = ''
PATTERN="C"
PATTERN2=" "
TEXT1="''$(curl -s "https://wttr.in/?format=%c")"
TEXT1=''${TEXT1/$PATTERN2/}
TEXT2="''$(curl -s "https://wttr.in/?format=%t")"
TEXT2=''${TEXT2/$PATTERN/}
TEXT3="''$(curl -s "https://wttr.in/?format=%f")"
TEXT3=''${TEXT3/$PATTERN/}
printf '{"text":" %s\\n %s\\n %s", "tooltip": false, "class": "weather"}\\n' \
  "$TEXT1" "$TEXT2" "$TEXT3"
'';
}
