import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import Quickshell.Wayland
import "mpris" as Mpris
import "systray" as SysTray
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
        return Math.max(bar.anchors.topMargin + height, Math.min(bar.height + bar.anchors.topMargin - height, targetY));
    }
    function boundedX(targetX: real, width: real): real {
        return Math.max(bar.anchors.leftMargin + width, Math.min(bar.width + bar.anchors.leftMargin - width, targetX));
    }

    WlrLayershell.namespace: "shell:bar"
    anchors {
        top: true
        left: true
        right: true
    }
    exclusiveZone: 48
    implicitHeight: 72
    color: "transparent"
    mask: barRegion

    Region {
        id: barRegion
        width: bar.width
        height: bar.height
    }

    Item {
        id: bar

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        implicitHeight: 48

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            implicitWidth: left.width + left.anchors.leftMargin + left.anchors.rightMargin
            implicitHeight: left.height
            color: "#3B253F"

            Rectangle {
                z: -1
                anchors.fill: parent
                color: "#BE850E"
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

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: 7
                    rightMargin: 7
                }

                spacing: 12

                //Launcher {}

                Workspaces {
                    bar: root
                }

                SysTray.SysTray {
                    bar: root
                }
            }
        }

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }

            implicitWidth: right.width + right.anchors.leftMargin + right.anchors.rightMargin
            implicitHeight: right.height
            color: "#3B253F"

            Rectangle {
                z: -1
                anchors.fill: parent
                color: "#BE850E"
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

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    leftMargin: 7
                    rightMargin: 7
                }

                spacing: 12

                Time {}

                Volume {
                    bar: root
                }

                Mpris.Players {
                    window: root
                    bar: root
                }

                //Theme {}

                Power {
                    id: power
                    bar: root
                }
            }
        }
    }
}
