pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../theme" as Theme
import "../components"

// TODO: make configurable: cursor visibility, screen freeze
PanelWindow {
    id: root

    required property var controller

    exclusionMode: ExclusionMode.Ignore
    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }
    color: "transparent"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "shell:screenshot"

    visible: screencopy.hasContent
    ScreencopyView {
        id: screencopy
        captureSource: root.screen
        anchors.fill: parent
        paintCursor: false
    }

    Process {
        id: cmd
        running: false
        onExited: notifyCmd.running = true
    }
    Process {
        id: notifyCmd
        command: ["notify-send", "\"Screenshot copied\"", "\"The screenshot was copied to your clipboard\\n\and saved to ~/Pictures/"]
        running: false
        onExited: root.controller.isOpen = false
    }

    contentItem {
        focus: true
        Keys.onEscapePressed: root.controller.isOpen = false

        Keys.onReturnPressed: () => {
            const x = Math.ceil(root.left);
            const y = Math.ceil(root.top);
            const w = Math.floor(root.right - root.left);
            const h = Math.floor(root.bottom - root.top);
            cmd.command = ["zsh", "-c", `grim -g "${x},${y} ${w}x${h}" - | wl-copy && grim -g "${x},${y} ${w}x${h}"`]; // we copy it once and save it another time
            cmd.running = true;
        }
    }

    property var left: 0
    property var top: 0
    property var right: 0
    property var bottom: 0

    Canvas {
        id: canvas
        anchors.fill: parent

        readonly property var borderExtendX: 56
        readonly property var borderExtendY: 48
        readonly property var borderWidthH: 12
        readonly property var borderWidthV: 18

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Background
            ctx.fillStyle = Theme.Colors.screenshotOverlayColor1;
            ctx.fillRect(0, 0, root.width, root.height);

            // Border
            ctx.fillStyle = Theme.Colors.screenshotOverlayColor2;
            ctx.fillRect(root.left - borderExtendX, root.top - borderWidthH, root.right - root.left + borderExtendX * 2, borderWidthH);
            ctx.fillRect(root.left - borderExtendX, root.bottom, root.right - root.left + borderExtendX * 2, borderWidthH);
            ctx.fillRect(root.left - borderWidthV, root.top - borderExtendY, borderWidthV, root.bottom - root.top + borderExtendY * 2);
            ctx.fillRect(root.right, root.top - borderExtendY, borderWidthV, root.bottom - root.top + borderExtendY * 2);

            // Rect
            ctx.clearRect(root.left, root.top, root.right - root.left, root.bottom - root.top);
        }
    }

    Rope {
        id: topLeftRope
        anchors.fill: parent
        start: Qt.vector2d(0, 0)
        end: Qt.vector2d(0, 0)
    }
    Rope {
        id: topRightRope
        anchors.fill: parent
        start: Qt.vector2d(0, 0)
        end: Qt.vector2d(0, 0)
    }
    Rope {
        id: bottomRightRope
        anchors.fill: parent
        start: Qt.vector2d(0, 0)
        end: Qt.vector2d(0, 0)
    }
    Rope {
        id: bottomLeftRope
        anchors.fill: parent
        start: Qt.vector2d(0, 0)
        end: Qt.vector2d(0, 0)
    }

    RopeTie {
        x: root.left - width / 2
        y: root.top - height / 2
    }
    RopeTie {
        x: root.right - width / 2
        y: root.top - height / 2
    }
    RopeTie {
        x: root.right - width / 2
        y: root.bottom - height / 2
    }
    RopeTie {
        x: root.left - width / 2
        y: root.bottom - height / 2
    }

    MouseArea {
        anchors.fill: parent

        onPressed: e => {
            root.left = e.x;
            root.top = e.y;
            root.right = e.x;
            root.bottom = e.y;
        }
        onPositionChanged: e => {
            if (e.x > root.left) {
                root.right = e.x;
            }

            if (e.y > root.top) {
                root.bottom = e.y;
            }
        }
    }

    onLeftChanged: () => {
        canvas.requestPaint();
        topLeftRope.end = Qt.vector2d(left, top);
        bottomLeftRope.end = Qt.vector2d(left, bottom);
    }
    onTopChanged: () => {
        canvas.requestPaint();
        topLeftRope.end = Qt.vector2d(left, top);
        topRightRope.end = Qt.vector2d(right, top);
    }
    onRightChanged: () => {
        canvas.requestPaint();
        topRightRope.end = Qt.vector2d(right, top);
        bottomRightRope.end = Qt.vector2d(right, bottom);
    }
    onBottomChanged: () => {
        canvas.requestPaint();
        bottomRightRope.end = Qt.vector2d(right, bottom);
        bottomLeftRope.end = Qt.vector2d(left, bottom);
    }

    onWidthChanged: () => {
        left = width / 2;
        right = width / 2;

        topRightRope.start = Qt.vector2d(width, 0);
        bottomRightRope.start = Qt.vector2d(width, height);
    }
    onHeightChanged: () => {
        top = height / 2;
        bottom = height / 2;

        bottomRightRope.start = Qt.vector2d(width, height);
        bottomLeftRope.start = Qt.vector2d(0, height);
    }

    component RopeTie: Image {
        width: 48
        height: 48
        source: "../assets/rope-tie.png"
        smooth: false
    }
}
