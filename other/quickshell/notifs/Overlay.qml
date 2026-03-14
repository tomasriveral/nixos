pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "../theme" as Theme
import "."



PanelWindow {
    id: root

    required property var bar
    property list<Notification> notifs

    WlrLayershell.namespace: "shell:notifications"
    exclusionMode: ExclusionMode.Ignore
    color: Theme.Colors.notifsOverlayColor1

    anchors {
        left: true
        top: true
        bottom: true
        right: true
    }
    Process {
          id: notifLogger
    }
    NotificationServer {

        

        actionsSupported: true

        onNotification: notif => {
            notif.tracked = true;
            //root.notifs = [...root.notifs, notif]; // sometimes sent as null
            if (notif) {
              notif.tracked = true;
              root.notifs = [...root.notifs, notif];

              notifLogger.command = ["QS-notifyhistory", notif.appName, notif.summary, notif.body, notif.urgency]
              notifLogger.running = true // logs the notification for later
            }
          }
    }


    visible: stack.children.length != 0
    mask: Region {
        item: stack
    }

    ListView {
        id: stack

        model: ScriptModel {
            values: [...root.notifs]
        }
        anchors.right: parent.right
        y: root.bar.height
        implicitWidth: 240
        implicitHeight: children.reduce((h, c) => h + c.height, 0)
        interactive: false
        spacing: 20

        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        move: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        delegate: Notif {
            required property Notification modelData
            notif: modelData

            onDismissed: () => {
              if (notif) { //handles sometimes WARN scene: @notifs/Overlay.qml[82:-1]: TypeError: Cannot read property 'dismiss' of null
                modelData.dismiss();
                // Remove from list
                const index = root.notifs.indexOf(notif);
                if (index > -1)
                root.notifs.splice(index, 1);
              }
            }
        }
    }
}
