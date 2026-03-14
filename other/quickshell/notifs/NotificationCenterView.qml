import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
    id: root
    width: 1000
    height: 800
    color: "black"
    visible: false
    // Toggle the notification center visibility
    function toggleNotificationCenter() {
        root.visible = !root.visible
        console.log("DEBUG: Toggled NotificationCenter. Visible =", root.visible)
        if (root.visible) {
            reload()
        }
    }

    // FileView for reading the notification cache
    FileView {
        id: historyFile
        path: Quickshell.env("HOME") + "/.cache/notify_history"
        blockLoading: true
    }

    // Reload notifications from the file
    function reload() {
      root.visible = true
      /*var text = historyFile.text()
      if (!text || text.length === 0) {
        console.log("DEBUG: Notification file empty")
        return
    }

    console.log("DEBUG: Raw notification file content:\n" + text)
    var lines = text.split("\n")
    console.log("DEBUG: Total lines in file:", lines.length)

    var i = 1
    while (i < lines.length) {
        var app = lines[i++] || ""
        var title = lines[i++] || ""
        var bodyLines = []

        while (i < lines.length && !/^\d{2}:\d{2}:\d{2}$/.test(lines[i])) {
            bodyLines.push(lines[i++])
        }

        if (i >= lines.length) break

        var time = lines[i++] || ""
        var urgency = lines[i++] || "normal"
        var body = bodyLines.join("\n")

        console.log("DEBUG: Parsed notification:", app, title, body, time, urgency)

      }*/
    }
        Component.onCompleted: {
        console.log("DEBUG: NotificationCenterView component loaded")
        reload()
    }
}
