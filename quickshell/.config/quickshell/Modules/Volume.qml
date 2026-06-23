import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import ".."

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

        property var sink: Pipewire.defaultAudioSink

        readonly property bool ready: sink && sink.ready
        readonly property bool muted: ready && sink.audio.muted
        readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

        readonly property string icon: {
            if (!ready) return String.fromCodePoint(0xF0581)
            if (muted) return String.fromCodePoint(0xF0E08)

            if (vol === 0) return String.fromCodePoint(0xF0581)
            if (vol < 34) return String.fromCodePoint(0xF057F)
            if (vol < 67) return String.fromCodePoint(0xF0580)

            return String.fromCodePoint(0xF057E)
        }

        Text {
            text: volume.icon
            color: Colors.yellow
            font { family: fontFamily; pixelSize: fontSize }
        }

        Text {
            text: {
                if (!volume.ready) return "--"
                if (volume.muted) return "Muted"
                return volume.vol + "%"
            }

            color: volume.muted ? Colors.surface2 : volume.baseColor
            font { family: fontFamily; pixelSize: fontSize }
        }

        PwObjectTracker {
            objects: [volume.sink]
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Quickshell.execDetached(["sh", "-c", "pavucontrol"])
    }
}