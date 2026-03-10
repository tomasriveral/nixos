pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    /*readonly property var getThemeProc: Process {
        running: true
        command: ["gsettings", "get", "org.gnome.desktop.interface", "color-scheme"]
        stdout: SplitParser {
            onRead: data => root.isDarkTheme = data == "'prefer-dark'"
        }
    }
    property var isDarkTheme: false
    readonly property var kittenThemeProc: Process {
        command: ["kitten", "theme", "--reload-in=all", `"Gruvbox ${root.isDarkTheme ? "Dark" : "Light"} Soft"`]
    }
    readonly property var gtk4ThemeProc: Process {
        command: ["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", `"prefer-${root.isDarkTheme ? "dark" : "light"}"`]
    }
    readonly property var gtk3ThemeProc: Process {
        command: ["gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", `"Adwaita${root.isDarkTheme ? "-dark" : ""}"`]
    }
    onIsDarkThemeChanged: () => {
        kittenThemeProc.command = ["kitten", "theme", "--reload-in=all", `Gruvbox ${root.isDarkTheme ? "Dark" : "Light"} Soft`];
        kittenThemeProc.running = true;
        gtk4ThemeProc.command = ["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", `"prefer-${root.isDarkTheme ? "dark" : "light"}"`];
        gtk4ThemeProc.running = true;
        gtk3ThemeProc.command = ["gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", `"Adwaita${root.isDarkTheme ? "-dark" : ""}"`];
        gtk3ThemeProc.running = true;
      }*/
}
