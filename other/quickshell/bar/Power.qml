import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower
import Qt5Compat.GraphicalEffects
import "../theme" as Theme
Item {
    id: root

    required property var bar

    readonly property var chargeState: UPower.displayDevice.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging
    readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    readonly property real percentage: UPower.displayDevice.percentage
    readonly property bool isLow: percentage <= 0.20
    readonly property bool isLaptop: true // hardcoded because this doesnt work UPowerDevice.isLaptopBattery
    width: 32
    height: 32

    Image {
        id: mask
        source: "../assets/battery-mask.png"
        smooth: false
        anchors.fill: parent
        visible: false
    }

    Rectangle {
        id: progressBar
        anchors.fill: parent
        color: Theme.Colors.powerColor1
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: root.isLaptop ? root.percentage * parent.height : parent.height
            color: root.isLaptop ? (root.isLow ? Theme.Colors.powerColor2 : Theme.Colors.powerColor3) : Theme.Colors.powerColor4
        }
        visible: false
    }
    OpacityMask {
        id: pBarMask
        anchors.fill: progressBar
        source: progressBar
        maskSource: mask
    }
    MultiEffect {
        source: pBarMask
        anchors.fill: pBarMask
        brightness: root.isCharging ? 0.3 : 0
        blur: 1.0
        blurEnabled: root.isCharging
    }
}
