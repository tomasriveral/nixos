{ writeShellApplication, curl, ... }:

writeShellApplication {
	name = "custom-weather";
	runtimeInputs = [
		curl
	];
	text = ''
while true; do 
	curl "https://wttr.in/?0&d&q&F&lang=fr"
	sleep 7200
done
	'';
}
