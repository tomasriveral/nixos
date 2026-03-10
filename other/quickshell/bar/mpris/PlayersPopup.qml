pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import "../.."
import "../../components"
import ".."

PopupWindow {
    id: root

    property bool isOpen: false

    implicitWidth: 700
    //implicitHeight: popupContent.implicitHeight + popupContent.anchors.margins * 2
    implicitHeight: 800

    mask: Region {
        item: wrapper
    }

    color: "transparent"

    property Scope positionInfo: Scope {
        id: positionInfo

        property int position: Math.floor(MprisController.activePlayer.position)
        property int length: Math.floor(MprisController.activePlayer.length)

        FrameAnimation {
            id: posTracker
            running: MprisController.activePlayer.isPlaying
            onTriggered: MprisController.activePlayer.positionChanged()
        }

        function timeStr(time: int): string {
            const seconds = time % 60;
            const minutes = Math.floor(time / 60);

            return `${minutes}:${seconds.toString().padStart(2, '0')}`;
        }
    }

    Rope {
        segmentCount: 4
        segmentLen: 22
        start: Qt.vector2d(250, -5)
        end: Qt.vector2d(wrapper.x + 49, wrapper.y)
    }
    Rope {
        segmentCount: 4
        segmentLen: 22
        start: Qt.vector2d(wrapper.width + 200 - 50, -5)
        end: Qt.vector2d(wrapper.width + wrapper.x - 49, wrapper.y)
    }

    Rectangle {
        id: wrapper
        implicitWidth: 500
        implicitHeight: popupContent.implicitHeight + popupContent.anchors.margins * 2
        color: "#824524"

        x: 200
        y: -wrapper.height
        readonly property var targetX: 200
        readonly property var targetY: root.isOpen ? 70 : -wrapper.height - 50
        property var velocityX: 0
        property var velocityY: 0

        FrameAnimation {
            running: true
            function dampingVelocity(currentVelocity, delta) {
                const spring = 8.0;
                const damping = 0.3;
                const springForce = spring * delta;
                const dampingForce = -damping * currentVelocity;
                return currentVelocity + (springForce + dampingForce);
            }
            onTriggered: {
                const deltaX = wrapper.targetX - wrapper.x;
                const deltaY = wrapper.targetY - wrapper.y;
                if (Math.abs(deltaX) > 0.1 || Math.abs(deltaY) > 0.1) {
                    wrapper.velocityX = dampingVelocity(wrapper.velocityX, deltaX);
                    wrapper.velocityY = dampingVelocity(wrapper.velocityY, deltaY);
                    wrapper.x += wrapper.velocityX * frameTime;
                    wrapper.y += wrapper.velocityY * frameTime;
                }
            }
        }
        MouseArea {
            property var prevMouseX: 0
            property var prevMouseY: 0
            anchors.fill: parent
            onPressed: e => {
                prevMouseX = e.x;
                prevMouseY = e.y;
            }
            onPositionChanged: e => {
                wrapper.x += (e.x - prevMouseX) * 0.3;
                wrapper.y += (e.y - prevMouseY) * 0.3;
                prevMouseX = e.x;
                prevMouseY = e.y;
            }
        }

        Item {
            anchors.fill: parent
            anchors.margins: 8
            clip: true

            Image {
                scale: 10
                anchors.fill: parent
                source: "../../assets/wood.png"
                smooth: false
                fillMode: Image.Tile
                opacity: 0.4
            }
        }

        ColumnLayout {
            id: popupContent

            anchors.fill: parent
            anchors.margins: 8

            Connections {
                target: MprisController

                function onTrackChanged(reverse: bool) {
                    trackStack.updateTrack(reverse, false);
                }
            }

            Item {
                id: playerSelectorContainment
                Layout.fillWidth: true
                implicitHeight: playerSelector.implicitHeight
                implicitWidth: playerSelector.implicitWidth

                Rectangle {
                    anchors.centerIn: parent
                    implicitWidth: 50
                    implicitHeight: 50
                    color: "#824524"
                }

                RowLayout {
                    id: playerSelector
                    property Item selectedPlayerDisplay: Mpris.players[0]
                    x: parent.width / 2 - (selectedPlayerDisplay ? selectedPlayerDisplay.x + selectedPlayerDisplay.width / 2 : 0)
                    anchors.verticalCenter: parent.verticalCenter

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.OutExpo
                        }
                    }

                    Repeater {
                        model: Mpris.players

                        MouseArea {
                            required property MprisPlayer modelData
                            readonly property bool selected: modelData == MprisController.activePlayer
                            onSelectedChanged: () => {
                                if (selected) {
                                    playerSelector.selectedPlayerDisplay = this;
                                }
                            }

                            implicitWidth: childrenRect.width
                            implicitHeight: childrenRect.height

                            onClicked: MprisController.setActivePlayer(modelData)

                            Item {
                                width: 50
                                height: 50

                                Image {
                                    anchors.fill: parent
                                    anchors.margins: 0
                                    source: {
                                        // So janky xD
                                        const identity = modelData.identity.toLowerCase();

                                        if (identity.includes("chrome") || identity.includes("chromium")) {
                                            return Quickshell.iconPath("google-chrome") || Quickshell.iconPath("chromium");
                                        }
                                        if (identity.includes("firefox")) {
                                            return Quickshell.iconPath("firefox");
                                        }
                                        if (identity.includes("spotify")) {
                                            return Quickshell.iconPath("spotify");
                                        }
                                        if (modelData.identity == "Brave") {
                                            return "/opt/brave-bin/product_logo_64.png";
                                        }
                                        const entry = DesktopEntries.byId(modelData.desktopEntry);
                                        if (entry && entry.icon) {
                                            return Quickshell.iconPath(entry.icon);
                                        }

                                        return "../../assets/mpd.png";
                                    }
                                    smooth: false
                                    sourceSize.width: 50
                                    sourceSize.height: 50
                                    cache: false
                                }
                            }
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.topMargin: 8
                Layout.bottomMargin: 16
                Label {
                    anchors.centerIn: parent
                    text: MprisController.activePlayer.identity
                    font.family: "BigBlueTermPlusNerdFont"
                    color: "white"
                }
            }

            SlideView {
                id: trackStack
                Layout.fillWidth: true
                implicitHeight: 100
                clip: animating || (lastFlicked?.contentX ?? 0) != 0

                property Flickable lastFlicked
                property bool reverse: false

                Component.onCompleted: updateTrack(false, true)

                function updateTrack(reverse: bool, immediate: bool) {
                    this.reverse = reverse;
                    this.replace(trackComponent, {
                        track: MprisController.activeTrack
                    }, immediate);
                }

                property var trackComponent: Component {
                    Flickable {
                        id: flickable
                        required property var track
                        readonly property bool svReady: img.status === Image.Ready
                        contentWidth: width + 1
                        onDragStarted: trackStack.lastFlicked = this
                        onDragEnded: {
                            if (Math.abs(contentX) > 75) {
                                if (contentX < 0)
                                    MprisController.previous();
                                else if (contentX > 0)
                                    MprisController.next();
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Rectangle {
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                implicitHeight: 128
                                implicitWidth: 128
                                color: "transparent"

                                Image {
                                    id: img
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectCrop
                                    visible: flickable.track.artUrl != ""
                                    source: flickable.track.artUrl
                                    cache: false
                                    asynchronous: true
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter

                                Label {
                                    text: flickable.track.title
                                    font.pointSize: albumLabel.font.pointSize + 1
                                    font.family: "BigBlueTermPlusNerdFont"
                                    color: "white"
                                    elide: Text.ElideRight
                                    Layout.maximumWidth: Math.min(300, implicitWidth)
                                }

                                Label {
                                    id: albumLabel
                                    text: flickable.track.album
                                    opacity: 0.8
                                    font.family: "BigBlueTermPlusNerdFont"
                                    color: "white"
                                    Layout.maximumWidth: Math.min(300, implicitWidth)
                                }

                                Label {
                                    text: flickable.track.artist
                                    opacity: 0.8
                                    font.family: "BigBlueTermPlusNerdFont"
                                    color: "white"
                                    Layout.maximumWidth: Math.min(300, implicitWidth)
                                }
                            }
                        }
                    }
                }

                readonly property real fromPos: trackStack.width * (trackStack.reverse ? -1 : 1)

                enterTransition: PropertyAnimation {
                    property: "x"
                    from: trackStack.fromPos
                    to: 0
                    duration: 350
                    easing.type: Easing.OutExpo
                }
                exitTransition: PropertyAnimation {
                    property: "x"
                    to: target.x - trackStack.fromPos
                    duration: 350
                    easing.type: Easing.OutExpo
                }
            }

            Item {
                Layout.fillWidth: true
                implicitHeight: controlsRow.implicitHeight

                RowLayout {
                    id: controlsRow
                    anchors.centerIn: parent

                    ClickableIcon {
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                        implicitWidth: 24
                        implicitHeight: 24
                        enabled: MprisController.loopSupported
                        //image: {
                        /*iconSource {
                            switch (MprisController.loopState) {
                            case MprisLoopState.None:
                                return "../../assets/repeat-off.png";
                            case MprisLoopState.Playlist:
                                return "../../assets/repeat.png";
                            case MprisLoopState.Track:
                                return "../../assets/repeat-once.png";
                            }
                          }*/
                        function getLoopIcon() {
                          switch (MprisController.loopState) {
                          case MprisLoopState.None: return "../../assets/repeat-off.png";
                          case MprisLoopState.Playlist: return "../../assets/repeat.png";
                          case MprisLoopState.Track: return "../../assets/repeat-once.png";
                        }
                        return "../../assets/repeat-off.png"; // fallback
                      }

                      iconSource: getLoopIcon()
                        onClicked: {
                            let target = MprisLoopState.None;
                            switch (MprisController.loopState) {
                            case MprisLoopState.None:
                                target = MprisLoopState.Playlist;
                                break;
                            case MprisLoopState.Playlist:
                                target = MprisLoopState.Track;
                                break;
                            case MprisLoopState.Track:
                                target = MprisLoopState.None;
                                break;
                            }
                            MprisController.setLoopState(target);
                        }
                    }

                    ClickableIcon {
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                        implicitWidth: 32
                        implicitHeight: 32
                        enabled: MprisController.canGoPrevious
                        //image: "../../assets/fastforward.png"
                        iconSource: "../../assets/fastforward.png"
                        mirror: true
                        onClicked: MprisController.previous()
                    }

                    ClickableIcon {
                        implicitWidth: 42
                        implicitHeight: 42
                        enabled: MprisController.canTogglePlaying
                        //image: `../../assets/${MprisController.isPlaying ? "pause" : "play"}.png`
                        iconSource: `../../assets/${MprisController.isPlaying ? "pause" : "play"}.png`
                        onClicked: MprisController.togglePlaying()
                    }

                    ClickableIcon {
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                        implicitWidth: 32
                        implicitHeight: 32
                        enabled: MprisController.canGoNext
                        //image: "../../assets/fastforward.png"
                        iconSource: "../../assets/fastforward.png"
                        onClicked: MprisController.next()
                    }

                    ClickableIcon {
                        Layout.leftMargin: 2
                        Layout.rightMargin: 2
                        implicitWidth: 24
                        implicitHeight: 24
                        enabled: MprisController.shuffleSupported
                        //image: `../../assets/${MprisController.hasShuffle ? "shuffle" : "noshuffle"}.png`
                        iconSource: `../../assets/${MprisController.hasShuffle ? "shuffle" : "noshuffle"}.png`
                        onClicked: MprisController.setShuffle(!MprisController.hasShuffle)
                    }
                }
            }

            RowLayout {
                Layout.margins: 5

                Label {
                    Layout.preferredWidth: lengthLabel.implicitWidth
                    text: positionInfo.timeStr(positionInfo.position)
                    font.family: "BigBlueTermPlusNerdFont"
                    color: "white"
                }

                Slider {
                    id: slider

                    property bool bindSlider: true

                    property real boundAnimStart: 0
                    property real boundAnimFactor: 1
                    property real lastPosition: 0
                    property real lastLength: 0
                    property real boundPosition: {
                        const ppos = MprisController.activePlayer.position / MprisController.activePlayer.length;
                        const bpos = boundAnimStart;
                        return (ppos * boundAnimFactor) + (bpos * (1.0 - boundAnimFactor));
                    }

                    Layout.fillWidth: true
                    enabled: MprisController.activePlayer.canSeek
                    from: 0
                    to: 1

                    background: Rectangle {
                        x: slider.leftPadding
                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                        implicitHeight: 24
                        width: slider.availableWidth
                        height: implicitHeight
                        color: "#824524"

                        Rectangle {
                            anchors.margins: 8
                            x: anchors.leftMargin
                            y: anchors.topMargin
                            width: slider.visualPosition * (parent.width - anchors.leftMargin - anchors.rightMargin)
                            height: parent.height - anchors.topMargin - anchors.bottomMargin
                            color: "#8D804B"
                        }
                    }

                    handle: Rectangle {
                        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                        y: slider.topPadding + slider.availableHeight / 2 - height / 2
                        implicitWidth: 16
                        implicitHeight: 16
                        rotation: 45
                        color: "#8D804B"
                    }

                    Connections {
                        target: MprisController.activePlayer

                        function onPositionChanged() {
                            slider.lastPosition = MprisController.activePlayer.position;
                            slider.lastLength = MprisController.activePlayer.length;
                        }
                    }

                    onPressedChanged: () => {
                        if (!pressed)
                            MprisController.activePlayer.position = value * MprisController.activePlayer.length;
                        bindSlider = !pressed;
                    }

                    Binding {
                        when: slider.bindSlider
                        slider.value: slider.boundPosition
                    }
                }

                Label {
                    id: lengthLabel
                    text: positionInfo.timeStr(positionInfo.length)
                    font.family: "BigBlueTermPlusNerdFont"
                    color: "white"
                }
            }
        }
    }
    Image {
        source: "../../assets/rope-tie.png"
        smooth: false
        width: 32
        height: 32
        x: wrapper.x + 49 - width / 2
        y: wrapper.y - height / 2
    }
    Image {
        source: "../../assets/rope-tie.png"
        smooth: false
        width: 32
        height: 32
        x: wrapper.width + wrapper.x - 49 - width / 2
        y: wrapper.y - height / 2
    }
}
