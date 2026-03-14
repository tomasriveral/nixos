// This is how the notification looks

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import "../theme" as Theme

Item {
    id: root

    required property Notification notif

    implicitWidth: 240
    implicitHeight: layout.height

    ColumnLayout {
        id: layout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: 0

        Image {
            id: trumpetTop
            Layout.fillWidth: true
            Layout.preferredHeight: width * (sourceSize.height / sourceSize.width)
            source: "../assets/trumpet-top.png"
            smooth: false
        }

        Item {
            id: bannerRect

            //color: "transparent" //Theme.Colors.background
            Layout.fillWidth: true
            implicitHeight: textColumn.implicitHeight
            Layout.leftMargin: (width / trumpetTop.sourceSize.width) * 2 + 3
            Layout.rightMargin: (width / trumpetTop.sourceSize.width) * 2 + 3

            Image {
                //anchors.right: parent.right
                height: textColumn.height
                width: textColumn.width
                source: "../assets/wood.png"
                smooth: false
                //opacity: 0.4
            }
            ColumnLayout {
                id: textColumn

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                /*Text { // we sanitize in case there is some null notification
                    Layout.maximumWidth: bannerRect.width
                    text: root.notif.summary + (root.notif.body ? "\n=======" : "")
                    font.family: "BigBlueTermPlusNerdFont"
                    wrapMode: Text.Wrap
                    font.pointSize: 18
                    font.bold: true
                    color: "#9292B6"
                }

                Text {
                    Layout.maximumWidth: bannerRect.width
                    text: root.notif.body
                    font.family: "BigBlueTermPlusNerdFont"
                    wrapMode: Text.Wrap
                    font.pointSize: 14
                    font.bold: false
                    color: "#9292B6"
                  }*/
                Text {
                  text: root.notif ? root.notif.summary + (root.notif.body ? "\n" : "") : ""
                  font.family: "BigBlueTermPlusNerdFont"
                  wrapMode: Text.Wrap
                  font.pointSize: 14
                  font.bold: true
                  color: Theme.Colors.displayColor1
              }
              
              Text {
                  text: root.notif ? root.notif.body : ""
                  font.family: "BigBlueTermPlusNerdFont"
                  wrapMode: Text.Wrap
                  Layout.maximumWidth: bannerRect.width
                  Layout.fillWidth: true
                  font.pointSize: 11
                  font.bold: false
                  color: Theme.Colors.displayColor2
              }
            }
        }
    }
}
