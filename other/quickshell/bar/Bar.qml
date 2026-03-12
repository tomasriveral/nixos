import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Io
import "mpris" as Mpris
import "systray" as SysTray
import "../theme" as Theme
import ".."

PanelWindow {
    id: root

    property var modelData
    readonly property var tooltip: tooltip
    readonly property real tooltipYOffset: root.height + 2

    Tooltip {
        id: tooltip
        bar: root
    }

    function boundedY(targetY: real, height: real): real {
        return Math.max(bar.anchors.topMargin + height,
                        Math.min(bar.height + bar.anchors.topMargin - height, targetY));
    }

    function boundedX(targetX: real, width: real): real {
        return Math.max(bar.anchors.leftMargin + width,
                        Math.min(bar.width + bar.anchors.leftMargin - width, targetX));
    }

    WlrLayershell.namespace: "shell:bar"
    anchors { top: true; left: true; right: true }
    exclusiveZone: 48
    implicitHeight: 72
    color: Theme.Colors.barColor1
    mask: barRegion

    Region {
        id: barRegion
        width: bar.width
        height: bar.height
    }

    Item {
        id: bar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        implicitHeight: 48

        // ---------------- LEFT MODULE ----------------
        Rectangle {
            id: leftModule
            anchors { top: parent.top; bottom: parent.bottom; left: parent.left }
            color: Theme.Colors.barColor2
            implicitWidth: left.childrenRect.width + 14
            implicitHeight: left.childrenRect.height + 8

            Rectangle {
                z: -1
                anchors.fill: parent
                color: Theme.Colors.barColor3
                anchors.margins: -4
            }

            Image {
                width: 16 * 6
                height: 4 * 6
                anchors.top: parent.bottom
                anchors.left: parent.left
                source: "../assets/bar-decor.png"
                smooth: false
            }

            RowLayout {
                id: left
                anchors { top: parent.top; bottom: parent.bottom; left: parent.left; leftMargin: 7; rightMargin: 7 }
                spacing: 12

                Workspaces { bar: root }
                SysTray.SysTray { bar: root }
            }
        }

        // ---------------- SYSINFO MODULE ----------------
        Rectangle {
            id: leftCenterModule
            anchors { top: parent.top; bottom: parent.bottom; left: leftModule.right; leftMargin: 30 }
            color: Theme.Colors.barColor6
            implicitWidth: sysinfo.childrenRect.width + 16
            implicitHeight: sysinfo.childrenRect.height + 8

            Rectangle {
                z: -1
                anchors.fill: parent
                color: Theme.Colors.barColor7
                anchors.margins: -4
            }

            Image {
                width: 16 * 6
                height: 4 * 6
                anchors.top: parent.bottom
                anchors.left: parent.left
                source: "../assets/bar-decor.png"
                smooth: false
            }

           RowLayout {
              id: sysinfo
              spacing: 10
          
              property int cpu: 0
              property int mem: 0
              property int disk: 0
              property real power: 0
              property int temp: 0
              property int fan: 0
              property int down: 0
              property int up: 0
          
              Timer {
                  interval: 2000
                  running: true
                  repeat: true
                  onTriggered: sysProcess.running = true
              }
          
              Process {
                  id: sysProcess
                  command: ["QS-sysinfo"]
          
                  stdout: SplitParser {
                      onRead: function(line) {
                          try {
                              var data = JSON.parse(line)
          
                              sysinfo.cpu = parseInt(data.cpu)
                              sysinfo.mem = parseInt(data.mem)
                              sysinfo.disk = parseInt(data.disk)
                              sysinfo.power = parseFloat(data.power)
                              sysinfo.temp = parseInt(data.temp)
                              sysinfo.fan = parseInt(data.fan)
                              sysinfo.down = parseInt(data.down)
                              sysinfo.up = parseInt(data.up)
          
                          } catch(e) {}
                      }
                  }
              }
          
              Column {
                  spacing: 2
          
                  Text {
                      text: "CPU " + sysinfo.cpu + "%  |  MEM " + sysinfo.mem + "%  |  PWR " + sysinfo.power.toFixed(1) + "W  |  UP " + sysinfo.up
                      font.pixelSize: 18
                      color: Theme.Colors.barColor8
                  }
          
                  Text {
                      text: "TMP " + sysinfo.temp + "°C  |  DSK " + sysinfo.disk + "%  |  FAN " + sysinfo.fan + "  |  DOWN " + sysinfo.down
                      font.pixelSize: 18
                      color: Theme.Colors.barColor8
                  }
              }
        } 
        }

        // ---------------- RIGHT MODULE ----------------
        Rectangle {
            id: rightCenterModule
            anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
            color: Theme.Colors.barColor4
            implicitWidth: right.childrenRect.width + 14
            implicitHeight: right.childrenRect.height + 8

            Rectangle {
                z: -1
                anchors.fill: parent
                color: Theme.Colors.barColor5
                anchors.margins: -4
            }

            Image {
                width: 16 * 6
                height: 4 * 6
                anchors.top: parent.bottom
                anchors.right: parent.right
                source: "../assets/bar-decor.png"
                smooth: false
                mirror: true
            }

            RowLayout {
                id: right
                anchors { top: parent.top; bottom: parent.bottom; right: parent.right; leftMargin: 7; rightMargin: 7 }
                spacing: 12

                Time {}
                Volume { bar: root }
                Mpris.Players { window: root; bar: root }
                Power { id: power; bar: root }
            }
        }
    }
}
