pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "." as Notifs

Singleton {
    id: root
    property bool isOpen: false

    IpcHandler {
        target: "notifications"

        function open() {
            root.isOpen = true
        }

        function close() {
            root.isOpen = false
        }

        function toggle() {
            root.isOpen = !root.isOpen
        }
    }

    LazyLoader {
      id: loader
      active: root.isOpen
        Notifs.NotificationCenterView {
            id: notificationCenter
            anchors.centerIn: parent
            width: 1000
            height: 800
            visible: true
        }
    }

    function init() {
        // Empty init function to ensure singleton is loaded
    }
}
