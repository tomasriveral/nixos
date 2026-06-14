{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.battery-laptop = {pkgs, ...}:
  # https://discourse.nixos.org/t/what-is-the-best-option-for-power-management/63406/2
  # we just activate tlp unconditonally
  #let
  #  cfg = config.custom;
  #hasBattery =
  #    lib.any (x: lib.strings.hasPrefix "BAT" x)
  #    (builtins.attrNames (builtins.readDir "/sys/class/power_supply"));
  #in
  {
    #  options.custom = {
    #     battery.enable = lib.mkOption {
    #     default = hasBattery;
    #     description = "Enable better battery support";
    #     type = lib.types.bool;
    #    };
    #  };

    #  config = lib.mkIf cfg.battery.enable {
    /*
      powerManagement.powertop.enable = true; # enable powertop auto tuning on startup.
    # Acording to https://community.frame.work/t/solved-keys-stick-and-repeat-after-being-released/51153/12
    # Some powertop bug is responsable for the problem of the random keypress being stuck
    # fix: from https://git.gabbie.blue/blue/nixconf/src/commit/2d1bc6dad4684c019b6b3e894408e76e2734806c/hosts/gabbielaptop/configuration.nix#L68
    powerManagement.powertop.postStart = ''
      ${lib.getExe' config.systemd.package "udevadm"} trigger -c bind -s usb -a idVendor=32ac -a idProduct=0018
      # Retrigger macropad udev rules
      ${lib.getExe' config.systemd.package "udevadm"} trigger -c bind -s usb -a idVendor=32ac -a idProduct=0013
    '';
    */
    services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
    services.thermald.enable = false; # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)
    services.power-profiles-daemon.enable = true; # ppd is recommended over tlp for framework 16
    /*
          services.tlp = {
          enable = true; # Enable TLP (better than gnomes internal power manager)
          settings = {
            CPU_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 1;
            CPU_HWP_DYN_BOOST_ON_AC = 1;
            CPU_HWP_DYN_BOOST_ON_BAT = 1;
            CPU_SCALING_GOVERNOR_ON_AC = "balanced";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balanced";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
            PLATFORM_PROFILE_ON_AC = "balanced";
            PLATFORM_PROFILE_ON_BAT = "powersave";
            STOP_CHARGE_THRESH_BAT1 = 80;
          };
    <<<<<<< HEAD
        };
    */
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-performance
    ];
  };
  perSystem = {pkgs, ...}: let
    NotifySound = ../../assets/battery_notify.mp3;
  in {
    packages.custom-batterynotify = pkgs.writeShellApplication {
      # taken and adapted https://github.com/miniMinn24/Battery_Notify with MIT License

      name = "custom-batterynotify";
      runtimeInputs = with pkgs; [
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
            Battery_Status="$(\cat /sys/class/power_supply/BAT*/status)"
            Battery_Capacity=$(\cat /sys/class/power_supply/BAT*/capacity)

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
    };
    packages.custom-batterywarning = pkgs.writeShellApplication {
      # taken and adapted https://github.com/miniMinn24/Battery_Notify with MIT License
      name = "custom-batterywarning";
      runtimeInputs = with pkgs; [
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
    };
    # because cbatticon, batticonplus  and other things didn't work.
    # chatGpt did this.
    # https://chatgpt.com/c/69da11b3-ba24-8331-b7b0-a58a72e69d42
    # at your risk and perils
    # click on the icon to get a notification with state, percentage and wattage
    packages.qtbatticon = pkgs.stdenv.mkDerivation {
      pname = "qtbatticon";
      version = "1.0";

      src = pkgs.writeTextFile {
        name = "qtbatticon.cpp";
        text = ''
          #include <QApplication>
          #include <QSystemTrayIcon>
          #include <QTimer>
          #include <QFile>
          #include <QTextStream>
          #include <QIcon>
          #include <QString>
          #include <QDebug>
          #include <cstdlib>

          QString readFile(const QString &path) {
              QFile f(path);
              if (!f.open(QIODevice::ReadOnly)) return "";
              QTextStream in(&f);
              return in.readAll().trimmed();
          }

          int readInt(const QString &path) {
              return readFile(path).toInt();
          }

          double readDouble(const QString &path) {
              QFile f(path);
              if (!f.open(QIODevice::ReadOnly)) return 0;
              QTextStream in(&f);
              return in.readAll().trimmed().toDouble();
          }

          int toStep(int capacity) {
              return (capacity / 10) * 10;
          }

          QString pad3(int n) {
              return QString("%1").arg(n, 3, 10, QChar('0'));
          }

          double getPowerW(const QString &batPath) {
              double current_uA = readDouble(batPath + "/current_now");
              double voltage_uV = readDouble(batPath + "/voltage_now");

              if (current_uA > 0 && voltage_uV > 0) {
                  return (current_uA * voltage_uV) / 1e12;
              }
              return -1;
          }

          QIcon batteryIcon(int capacity, bool charging) {
              int step = toStep(capacity);
              QString num = pad3(step);

              QString base = "/run/current-system/sw/share/icons/Papirus/24x24/panel/";

              QString file;
              if (charging) {
                  file = base + "battery-" + num + "-charging.svg";
              } else {
                  file = base + "battery-" + num + ".svg";
              }

              QIcon icon(file);

              if (icon.isNull()) {
                  qDebug() << "FAILED icon:" << file;
                  icon = QIcon(base + "battery-100.svg");
              }

              return icon;
          }

          void sendNotification(const QString &title, const QString &body) {
              QString cmd = "notify-send \"" + title + "\" \"" + body + "\"";
              system(cmd.toUtf8().constData());
          }

          int main(int argc, char *argv[]) {
              QApplication app(argc, argv);

              QString batPath = "/sys/class/power_supply/BAT1";
              QSystemTrayIcon tray;

              auto updateIcon = [&]() {
                  int capacity = readInt(batPath + "/capacity");
                  QString status = readFile(batPath + "/status");
                  bool charging = status.contains("Charging");

                  tray.setIcon(batteryIcon(capacity, charging));
              };

              auto notify = [&]() {
                  int capacity = readInt(batPath + "/capacity");
                  QString status = readFile(batPath + "/status");

                  bool charging = status.contains("Charging");
                  bool discharging = status.contains("Discharging");

                  double power = getPowerW(batPath);

                  QString state;
                  if (charging) state = "Charging";
                  else if (discharging) state = "Discharging";
                  else state = status;

                  QString powerStr = (power > 0.01)
                      ? QString::number(power, 'f', 2) + " W"
                      : "N/A";

                  QString msg =
                      QString("%1\n%2%\n%3")
                          .arg(state)
                          .arg(capacity)
                          .arg(powerStr);

                  sendNotification("Battery status", msg);
              };

              QObject::connect(&tray, &QSystemTrayIcon::activated,
                               [&](QSystemTrayIcon::ActivationReason r) {
                  if (r == QSystemTrayIcon::Trigger) {
                      notify();
                  }
              });

              updateIcon();
              tray.setVisible(true);

              QTimer timer;
              QObject::connect(&timer, &QTimer::timeout, updateIcon);
              timer.start(5000);

              return app.exec();
          }
        '';
      };

      nativeBuildInputs = with pkgs; [
        pkg-config
        qt6.wrapQtAppsHook
      ];

      buildInputs = with pkgs; [
        qt6.qtbase
        qt6.qtsvg
        papirus-icon-theme
      ];

      dontUnpack = true;

      buildPhase = ''
        g++ $src -o qtbatticon \
          $(pkg-config --cflags --libs Qt6Widgets)
      '';

      installPhase = ''
        mkdir -p $out/bin
        install -m755 qtbatticon $out/bin/
      '';
    };
    # This was replaced by caelestia shell's Game Mode
    packages.custom-performance = pkgs.writeShellApplication {
      name = "custom-performance";
      runtimeInputs = with pkgs; [
        hyprland
        brightnessctl
        swaynotificationcenter
        self.packages.${pkgs.system}.custom-wallpaper
        libnotify
        inputs.caelestia-shell.packages.${pkgs.system}.default
      ];
      text = ''
        STATE="$HOME/.cache/hypr-battery-saver"

        enable() {
            mkdir -p "$(dirname "$STATE")"

            echo "Enabling battery saver mode..."

            # Save brightness
            brightnessctl get > "''${STATE}.brightness" 2>/dev/null || true

            # Kill heavy UI components
            pkill -f caelestia-shell || true
            pkill -f caelestia || true
            pkill shell || true
            pkill -f custom-wallpaper || true

            # Start lightweight notifications
            pkill swaync || true
            swaync & disown

            # Start lightweight waybar
            pkill waybar || true
            waybar & disown

            # Lower refresh rate (BIGGEST win)
            hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"

            # Core performance toggles
            hyprctl --batch "\
                keyword animations:enabled 0;\
                keyword animation borderangle,0;\
                keyword decoration:shadow:enabled 0;\
                keyword decoration:blur:enabled 0;\
                keyword decoration:rounding 0;\
                keyword decoration:fullscreen_opacity 1;\
                keyword general:gaps_in 0;\
                keyword general:gaps_out 0;\
                keyword general:border_size 1;\
                keyword decoration:active_opacity 1;\
                keyword decoration:inactive_opacity 1;\
                keyword misc:vfr true"

            # Lower brightness
            brightnessctl set 5% 2>/dev/null || true

            touch "$STATE"

            notify-send "Battery Saver" "Enabled"
        }

        disable() {
            echo "Disabling battery saver mode..."

            # Restore refresh rate
            hyprctl keyword monitor "eDP-1,2560x1600@165,0x0,1"

            # Restore Caelestia
            pkill swaync || true
            pkill waybar || true
            caelestia shell -d >/dev/null 2>&1 &
            disown


            # Restart wallpaper
            custom-wallpaper >/dev/null 2>&1 &
            disown

            # Restore full UI via reload (safe here on exit)
            hyprctl reload

            # Restore brightness
            if [[ -f "''${STATE}.brightness" ]]; then
                brightnessctl set "$(cat "''${STATE}.brightness")" 2>/dev/null || true
            fi

            rm -f "$STATE" "''${STATE}.brightness"

            notify-send "Battery Saver" "Disabled"
        }

        if [[ -f "$STATE" ]]; then
            disable
        else
            enable
        fi
      '';
    };
    # Old script that was used for the battery. Might not work.
    packages.custom-olddeprecatedbatterynotify = pkgs.writeShellApplication {
      name = "custom-olddeprecatedbatterynotify";

      runtimeInputs = with pkgs; [
        libnotify # provides notify-send
        systemd # provides systemctl
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
    };
  };
  flake.homeModules.cbatticon = _: {
    # don't works. some GTK error. I let it here if someday, someone is interest in this shit.
    # ChatGPT half baked a replacement that works on my system.
    # see qtbatticon
    services.cbatticon = {
      enable = true;
      lowLevelPercent = 20;
      criticalLevelPercent = 5;
      batteryId = "BAT1";
      hideNotification = true; # we use another script for battery notifications
      updateIntervalSeconds = 10;
    };
  };
}
