import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import ".."
import "../Services"

RowLayout {
    id: network
    spacing: root.globalSpacing
    property color baseColor: Colors.text
    property color disabledColor: Colors.surface2

    Text {
        text: NetworkingStatus.icon
        color: Networking.wifiEnabled ? network.baseColor : network.disabledColor

        font { family: root.fontFamily; pixelSize: root.fontSize }
    }

    Text {
        text: {
            if (!Networking.wifiEnabled) return "off"
            if (!NetworkingStatus.active) return "Disconnected"

            return NetworkingStatus.active.name
        }

        color: network.baseColor
        font { family: root.fontFamily; pixelSize: root.fontSize }
    }
}