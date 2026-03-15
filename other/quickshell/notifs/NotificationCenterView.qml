import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../theme" as Theme

Rectangle {
    id: root
    width: 500
    height: 1000
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    color: Theme.Colors.notificationCenterColor1
    visible: true

    ListModel {
        id: notificationsModel
    }

    function toggleNotificationCenter() {
        root.visible = !root.visible
        if (root.visible)
            reload()
    }

    FileView {
        id: historyFile
        path: Quickshell.env("HOME") + "/.cache/notify_history"
        blockLoading: true
    }

    Process {
        id: clearProcess
        command: ["QS-notifycache"]
        onExited: reload()
    }

    function reload() {
        historyFile.reload()
        notificationsModel.clear()

        var text = historyFile.text()
        if (!text || text.length === 0)
            return

        var lines = text.split("\n")
        var i = 1

        while (i < lines.length) {

            var app = lines[i++] || ""
            var title = lines[i++] || ""
            var bodyLines = []

            while (i < lines.length && !/^\d{2}:\d{2}:\d{2}$/.test(lines[i])) {
                bodyLines.push(lines[i++])
            }

            if (i >= lines.length)
                break

            var time = lines[i++] || ""
            var urgency = lines[i++] || "normal"
            var body = bodyLines.join("\n")

            // insert at beginning to invert order
            notificationsModel.insert(0, {
                app: app,
                title: title,
                body: body,
                time: time,
                urgency: urgency
            })
        }
    }

    Component.onCompleted: reload()

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        Button {
            text: "Clear"
            Layout.fillWidth: true
            onClicked: {
                clearProcess.running = true
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: notificationsModel
            spacing: 10
            clip: true

            delegate: Rectangle {
                width: ListView.width
                color: Theme.Colors.notificationCenterColor1
                border.color: Theme.Colors.notificationCenterColor3
                border.width: 1
                radius: 4
                visible: true

                Column {
                    id: columnContent
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 4

                    Text {
                        text: time
                        color: Theme.Colors.notificationCenterColor4
                        width: ListView.width - 16
                    }

                    Text {
                        text: title
                        color: Theme.Colors.notificationCenterColor4
                        font.bold: true
                        wrapMode: Text.Wrap
                        width: ListView.width - 16
                    }

                    Text {
                        text: body
                        color: Theme.Colors.notificationCenterColor4
                        wrapMode: Text.Wrap
                        width: ListView.width - 16
                    }
                }

                height: 100 + columnContent.implicitHeight
            }
        }
    }
}
