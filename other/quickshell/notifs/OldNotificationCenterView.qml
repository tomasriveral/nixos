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

    // Use ListModel so Repeater updates automatically
    ListModel {
        id: notificationsModel
    }
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
    notificationsModel.clear()
    var text = historyFile.text()
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

        notificationsModel.insert(0, { app: app, title: title, body: body, time: time, urgency: urgency })
    }

    console.log("DEBUG: Total notifications loaded:", notificationsModel.count)
}
    Component.onCompleted: {
        console.log("DEBUG: NotificationCenter component completed")
        reload()
    }

    // Scrollable list of notifications
    ScrollView {
        anchors.fill: parent

        ColumnLayout {
            id: list
            width: parent.width
            spacing: 8
Repeater {
    model: notificationsModel
    delegate: Rectangle {
        width: list.width
        height: columnContent.implicitHeight + 20
        color: "transparent"

        Image {
            anchors.fill: parent
            source: "../assets/wood.png"
            fillMode: Image.Stretch
            z: 0
        }

        ColumnLayout {
            id: columnContent
            width: parent.width
            //anchors.fill: parent
            anchors.margins: 10
            z: 1

            Text {
                text: time + " | " + app
                color: urgency === "critical" ? "red" : "white"
            }

            Text {
                text: title
                font.bold: true
                color: urgency === "critical" ? "red" : "white"
                wrapMode: Text.Wrap
            }

            Text {
                text: body
                wrapMode: Text.Wrap
                color: urgency === "critical" ? "red" : "white"
            }
        }
    }
}
                
        }
    }
}
