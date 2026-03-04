# taken and adapted https://github.com/miniMinn24/Battery_Notify with MIT License
{ writeShellApplication, mplayer, brightnessctl, ... }:
let
  NotifySound = ../../assets/battery_notify.mp3;
in  
writeShellApplication {
	name = "custom-batterynotify";
    runtimeInputs = [
      mplayer
      brightnessctl
	];
	text = ''

# Delay for startup
sleep 5

# Change your sound path here

playsound() {
    mplayer ${NotifySound}
}

adjustBrightness() {
    local adjustment="$1"
    brightnessctl set "$adjustment"
}

sendNotification() {
    local title="$1"
    local message="$2"
    notify-send -h string:x-canonical-private-synchronous:sys-notify -e -u low "$title" "$message"
}

# Runs full time in background
x=0
while true; do
    Battery_Status="$(cat /sys/class/power_supply/BAT*/status)"
    Battery_Capacity=$(cat /sys/class/power_supply/BAT*/capacity)

    case "$Battery_Status" in
        "Discharging")
            if [ $x -eq 1 ]; then
                sendNotification "Discharging" "Remains: <b>''${Battery_Capacity}%</b>"
                adjustBrightness "15%-"
                playsound
                x=0
            fi
            ;;
        "Charging")
            if [ $x -eq 0 ]; then
                sendNotification "Charging" "Current: <b>''${Battery_Capacity}%</b>"
                adjustBrightness "15%+"
                playsound
                x=1
            fi
            ;;
        "Full")
            if [ $x -eq 0 ]; then
                sendNotification "Fully Charged" "Noice: <b>''${Battery_Capacity}%</b>"
                playsound
                x=1
            fi
            ;;
    esac

    sleep 1
done
    '';
}
