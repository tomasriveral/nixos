pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import "../.."
import ".."

MouseArea {
    id: root

    required property var window
    required property var bar

    readonly property var activePlayer: MprisController.activePlayer

    property var isPopupOpen: false

    implicitWidth: column.implicitWidth + 10
    Layout.fillHeight: true

    acceptedButtons: Qt.RightButton
    onClicked: isPopupOpen = !isPopupOpen

    Item {
        id: widget
        anchors.fill: parent

        scale: root.isPopupOpen ? 0.92 : 1
        Behavior on scale {
            NumberAnimation {
                duration: 70
            }
        }

        implicitHeight: column.implicitHeight + 10

        RowLayout {
            id: column

            anchors {
                fill: parent
            }

            ClickableIcon {
                acceptedButtons: Qt.LeftButton
                implicitWidth: 20
                implicitHeight: 20
                //image: "../../assets/fastforward.png"
                iconSource:"../../assets/fastforward.png"
                mirror: true
                hoverEnabled: true
                enabled: MprisController.canGoPrevious
                onClicked: MprisController.previous()
                scale: containsMouse ? 0.9 : 1
                Behavior on scale {
                    NumberAnimation {
                        duration: 70
                    }
                }
            }

            ClickableIcon {
                acceptedButtons: Qt.LeftButton
                implicitWidth: 26
                implicitHeight: 26
                Layout.leftMargin: -4
                Layout.rightMargin: -4
                //image: `../../assets/${MprisController.isPlaying ? "pause" : "play"}.png`
                iconSource:`../../assets/${MprisController.isPlaying ? "pause" : "play"}.png`
                hoverEnabled: true
                enabled: MprisController.canTogglePlaying
                onClicked: MprisController.togglePlaying()
            }

            ClickableIcon {
                acceptedButtons: Qt.LeftButton
                implicitWidth: 20
                implicitHeight: 20
                //image: "../../assets/fastforward.png"
                iconSource:"../../assets/fastforward.png"
                hoverEnabled: true
                enabled: MprisController.canGoNext
                onClicked: MprisController.next()
                scale: containsMouse ? 0.9 : 1
                Behavior on scale {
                    NumberAnimation {
                        duration: 70
                    }
                }
            }
        }

        Connections {
            target: root
            function onIsPopupOpenChanged() {
                root.window.focusable = root.isPopupOpen;
            }
        }
        LazyLoader {
            id: popupLoader
            active: root.isPopupOpen
            // Leave time for exit anim
            Behavior on active {
                enabled: popupLoader.active
                NumberAnimation {
                    duration: 1000
                }
            }

            PlayersPopup {
                id: popup
                visible: true
                isOpen: root.isPopupOpen

                anchor.window: root.window
                anchor.rect.x: root.window.width
                anchor.rect.y: 0

                HyprlandFocusGrab {
                    active: root.isPopupOpen
                    windows: [popup]
                }
                contentItem {
                    focus: true
                    Keys.onEscapePressed: root.isPopupOpen = false
                }
            }
        }
    }

    component CenteredText: Item {
        Layout.fillWidth: true

        property alias text: label.text
        property alias font: label.font

        Label {
            id: label
            visible: text != ""
            anchors.centerIn: parent
            elide: Text.ElideRight
            width: Math.min(parent.width - 20, implicitWidth)
            font.family: "BigBlueTermPlusNerdFont"
            color: "white"
        }
    }
}
