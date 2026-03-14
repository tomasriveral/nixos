pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "." as Notifs

Singleton {
    id: root

    PanelWindow {
        id: window
        visible: false

        Notifs.NotificationCenterView {
            id: notificationCenter
            anchors.right: parent.right
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
}
