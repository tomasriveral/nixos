pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Services.SystemTray
import "../../theme" as Theme
import ".."
import "../.."
import "../../components"

Rectangle {
    id: root
    required property var bar
    implicitWidth: row.implicitWidth + 10
    Layout.fillHeight: true

    color: Theme.Colors.sysTrayColor1

    RowLayout {
        id: row
        implicitWidth: childrenRect.width
        spacing: 5

        anchors {
            fill: parent
            margins: 5
        }

        Repeater {
            model: SystemTray.items

            Item {
                id: item
                required property SystemTrayItem modelData

                property bool targetMenuOpen: false

                Layout.fillHeight: true
                implicitWidth: height

                Image {
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: height
                    source: item.modelData.icon
                    scale: item.targetMenuOpen ? 0.8 : 1
                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent

                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                        // showPressed: item.targetMenuOpen || (pressedButtons & ~Qt.RightButton)
                        // fillWindowWidth: true
                        // extraVerticalMargin: row.spacing / 2

                        onClicked: event => {
                            event.accepted = true;

                            if (event.button == Qt.LeftButton) {
                                item.modelData.activate();
                            } else if (event.button == Qt.MiddleButton) {
                                item.modelData.secondaryActivate();
                            }
                        }

                        onPressed: event => {
                            if (event.button == Qt.RightButton && item.modelData.hasMenu) {
                                item.targetMenuOpen = !item.targetMenuOpen;
                            }
                        }

                        onWheel: event => {
                            event.accepted = true;
                            const points = event.angleDelta.y / 120;
                            item.modelData.scroll(points, false);
                        }

                        // property var tooltip: TooltipItem {
                        //     tooltip: root.bar.tooltip
                        //     owner: mouseArea
                        //
                        //     show: mouseArea.containsMouse
                        //
                        //     Text {
                        //         id: tooltipText
                        //         text: item.modelData.tooltipTitle != "" ? item.modelData.tooltipTitle : item.modelData.id
                        //         color: "white"
                        //     }
                        // }

                        LazyLoader {
                            active: item.targetMenuOpen

                            PopupWindow {
                                id: rightclickMenu
                                anchor.window: root.bar
                                visible: true

                                Component.onCompleted: () => {
                                    root.bar.focusable = true;
                                    const pos = mouseArea.mapToGlobal(mouseArea.x, mouseArea.y);
                                    anchor.rect.x = pos.x;
                                    anchor.rect.y = pos.y + mouseArea.height;
                                }
                                Connections {
                                    target: item
                                    function onTargetMenuOpenChanged() {
                                        root.bar.focusable = false;
                                    }
                                }
                                contentItem {
                                    focus: true
                                    Keys.onEscapePressed: item.targetMenuOpen = false
                                }

                                implicitWidth: Math.max(1, menuView.implicitWidth)
                                implicitHeight: Math.max(1, menuView.implicitHeight)
                                color: Theme.Colors.sysTrayColor1

                                Rectangle {
                                    anchors.fill: parent
                                    color: Theme.Colors.sysTrayColor3
                                    MenuView {
                                        id: menuView
                                        anchors.fill: parent
                                        menu: item.modelData.menu
                                        onClose: item.targetMenuOpen = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
