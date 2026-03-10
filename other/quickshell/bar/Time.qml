import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

Text {
    id: timetxt
    font.family: "BigBlueTermPlusNerdFont"
    font.pointSize: 16
    font.bold: true
    color: "white"
    opacity: 0.5

    Process {
        id: dateProc
        command: ["date", "+%H:%M"]
        running: true
        stdout: SplitParser {
            onRead: data => timetxt.text = data
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
