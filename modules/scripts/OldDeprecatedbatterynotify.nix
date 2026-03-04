{ writeShellApplication
, libnotify
, systemd
}:

writeShellApplication {
  name = "custom-olddeprecatedbatterynotify";

  runtimeInputs = [
    libnotify   # provides notify-send
    systemd     # provides systemctl
  ];

  text = ''
    set -euo pipefail

    LOW="''${BATTERY_LOW_THRESHOLD:-20}"
    CRITICAL="''${BATTERY_CRITICAL_THRESHOLD:-5}"
    FULL="''${BATTERY_FULL_THRESHOLD:-95}"
    INTERVAL="''${BATTERY_INTERVAL:-30}"
    ACTION="''${BATTERY_CRITICAL_ACTION:-systemctl suspend}"

    notify() {
      notify-send -a "Battery" -u "$1" "$2" "$3"
    }

    get_info() {
      total=0
      count=0

      for bat in /sys/class/power_supply/BAT*; do
        [ -f "$bat/capacity" ] || continue
        capacity=$(<"$bat/capacity")
        status=$(<"$bat/status")
        total=$((total + capacity))
        count=$((count + 1))
      done

      [ "$count" -gt 0 ] || exit 0
      percentage=$((total / count))
    }

    last_state=""

    while true; do
      get_info

      if [[ "$status" == "Discharging" && "$percentage" -le "$CRITICAL" ]]; then
        notify critical "Battery Critically Low" "$percentage% — suspending."
        $ACTION

      elif [[ "$status" == "Discharging" && "$percentage" -le "$LOW" ]]; then
        if [[ "$last_state" != "low" ]]; then
          notify normal "Battery Low" "$percentage% remaining."
          last_state="low"
        fi

      elif [[ "$status" != "Discharging" && "$percentage" -ge "$FULL" ]]; then
        if [[ "$last_state" != "full" ]]; then
          notify normal "Battery Full" "$percentage% — unplug charger."
          last_state="full"
        fi

      else
        last_state=""
      fi

      sleep "$INTERVAL"
    done
  '';
}
