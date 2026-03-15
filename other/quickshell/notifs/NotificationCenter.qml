pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "." as Notifs
import "../theme" as Theme

Singleton {
    id: root

    PanelWindow {
        id: window
        visible: false
        implicitWidth: notificationCenter.width
        implicitHeight: notificationCenter.height
        anchors.right: notificationCenter.right
        anchors.top: notificationCenter.top
        color: Theme.Colors.notificationCenterColor1 // needs to be set. Do not delete

        Notifs.NotificationCenterView {
            id: notificationCenter
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: Theme.Colors.notificationCenterColor2
          }
    }

    IpcHandler {
        target: "notifications"

        function toggle() {
            window.visible = !window.visible
            if (window.visible)
                notificationCenter.reload()
        }
      }

    function init() {
    // empty function to define first reference to singleton. Do not delete. It will break.
    }
}
