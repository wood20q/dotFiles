import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import ".."
import "../Services"

Rectangle {
    id: volBox
    height: volume.implicitHeight
    width: volume.implicitWidth
    Layout.preferredWidth: volume.implicitWidth
    Layout.preferredHeight: volume.implicitHeight 
    color: "transparent"

    RowLayout {
        id: volume
        spacing: root.globalSpacing
        property color baseColor: Colors.text

        Text {
            text: VolumeStatus.icon
            color: Colors.yellow
            font { family: fontFamily; pixelSize: fontSize }
        }

        Text {
            text: {
                if (!VolumeStatus.ready) return "--"
                if (VolumeStatus.muted) return "Muted"
                return VolumeStatus.vol + "%"
            }

            color: VolumeStatus.muted ? Colors.surface2 : volume.baseColor
            font { family: fontFamily; pixelSize: fontSize }
        }

        PwObjectTracker {
            objects: [VolumeStatus.sink]
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Quickshell.execDetached(["sh", "-c", "pavucontrol"])
    }
}