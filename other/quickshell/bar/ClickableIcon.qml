/*import QtQuick

BarButton {
    id: root
    property alias image: img.source
    property alias mirror: img.mirror
    implicitWidth: 24
    implicitHeight: 24
    Image {
        id: img
        anchors.fill: parent
        smooth: false
        scale: root.containsMouse ? 0.9 : 1
        Behavior on scale {
            NumberAnimation {
                duration: 70
            }
        }
    }
  }*/
  import QtQuick

BarButton {
    id: root

    // NEW property: stores the intended image path
    property string iconSource: "" 

    // optional: alias for external access
    property alias mirror: img.mirror

    implicitWidth: 24
    implicitHeight: 24

    Image {
        id: img
        anchors.fill: parent
        smooth: false

        // Use the property, fallback if empty
        //source: root.iconSource ? root.iconSource : "../assets/noaudio.png"
        Component.onCompleted: {
        source: typeof root.iconSource === "string" && root.iconSource.length > 0
            ? root.iconSource
            : "../assets/noaudio.png"
          }
        onSourceChanged: {
          console.log("ClickableIcon: iconSource =", root.iconSource, " -> Image.source =", img.source);
        } 
        scale: root.containsMouse ? 0.9 : 1
        Behavior on scale {
            NumberAnimation { duration: 70 }
        }
    }
}
