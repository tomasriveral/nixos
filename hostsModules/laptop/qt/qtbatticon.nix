# because cbatticon, batticonplus  and other things didn't work.
# chatGpt did this.
# https://chatgpt.com/c/69da11b3-ba24-8331-b7b0-a58a72e69d42
# at your risk and perils
# click on the icon to get a notification with state, percentage and wattage
{
  lib,
  stdenv,
  qt6,
  pkg-config,
  pkgs,
}:
stdenv.mkDerivation {
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

  nativeBuildInputs = [
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtsvg
    pkgs.papirus-icon-theme
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
}
