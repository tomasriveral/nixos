# taken and adapted https://github.com/miniMinn24/Battery_Notify with MIT License
{
  writeShellApplication,
  mplayer,
  brightnessctl,
  ...
}: let
  NotifySound = ../../../assets/battery_notify.mp3;
in
  writeShellApplication {
    name = "custom-batterywarning";
    runtimeInputs = [
      mplayer
      brightnessctl
    ];
    text = ''

      # Delay for startup
      sleep 5


      playsound() {
          mplayer ${NotifySound}
      }



      while true; do
          Battery_Status="$(cat /sys/class/power_supply/BAT*/status)"
          Battery_Capacity="$(cat /sys/class/power_supply/BAT*/capacity)"

          if [ "$Battery_Status" == "Discharging" ]; then
              if [ "$Battery_Capacity" -le 20 ] && [ "$Battery_Capacity" -ge 10 ]; then
                  notify-send -e -u critical "Battery Low!" "Power running out: <b>''${Battery_Capacity}%</b>"
                  playsound
                  sleep 180

              elif [ "$Battery_Capacity" -lt 10 ]; then
                  notify-send -e -u critical "Battery Low!" "<b>Save your works</b> before immediate shutdown."
                  playsound
                  sleep 180
              fi
          else
              sleep 120
          fi
      done
    '';
  }
