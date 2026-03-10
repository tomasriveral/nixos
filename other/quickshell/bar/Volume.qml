pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "mpris"

MouseArea {
    id: root

    required property var bar

    property var node: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [root.node]
    }

    implicitWidth: 26
    implicitHeight: 26

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton

    //enabled: MprisController.canChangeVolume

    opacity: enabled ? 1 : 0.5

    Image {
        anchors.fill: parent
        //source: `../assets/${root.node.audio.muted ? "noaudio" : "audio"}.png`
        source: root.node ? `../assets/${root.node.audio.muted ? "noaudio" : "audio"}.png` : "../assets/noaudio.png"
        smooth: false

        scale: popupLoader.active ? 0.9 : 1
        Behavior on scale {
            NumberAnimation {
                duration: 70
            }
        }
    }

    onClicked: node.audio.muted = !node.audio.muted

    LazyLoader {
        id: popupLoader

        property bool popupContainsMouse
        active: root.enabled && (root.containsMouse || popupContainsMouse)
        Behavior on active {
            NumberAnimation {
                duration: 100
            }
        }

        PopupWindow {
            id: popup

            visible: true
            anchor.window: root.bar
            width: 200
            height: 32
            color: "#9B5B36"
            Connections {
                target: root
                function onXChanged() {
                    popup.updatePos();
                }
            }
            Component.onCompleted: updatePos()
            function updatePos() {
                const pos = root.mapToGlobal(root.width / 2 - popup.width / 2, root.height);
                popup.anchor.rect.x = pos.x;
                popup.anchor.rect.y = pos.y + 5;
            }

            Slider {
                id: slider

                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                anchors.margins: 5
                from: 0
                to: 1

                value: root.node.audio.volume
                onValueChanged: root.node.audio.volume = value

                background: Rectangle {
                    x: slider.leftPadding
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitHeight: 16
                    width: slider.availableWidth
                    height: implicitHeight
                    color: "#824524"
                    opacity: node.audio.muted ? 0.5 : 1

                    Rectangle {
                        anchors.margins: 5
                        x: anchors.leftMargin
                        y: anchors.topMargin
                        width: slider.visualPosition * (parent.width - anchors.leftMargin - anchors.rightMargin)
                        height: parent.height - anchors.topMargin - anchors.bottomMargin
                        color: "#8D804B"
                    }
                }

                handle: Rectangle {
                    x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitWidth: 12
                    implicitHeight: 12
                    rotation: 45
                    color: "#8D804B"
                }
            }

            MouseArea {
                id: popupMouseArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton
                propagateComposedEvents: true
                onEntered: popupLoader.popupContainsMouse = true
                onExited: popupLoader.popupContainsMouse = false
            }
        }
    }
}
