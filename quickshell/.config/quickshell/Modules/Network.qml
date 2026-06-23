import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import ".."

RowLayout {
    id: network
    spacing: root.globalSpacing
    property color baseColor: Colors.text
    property color disabledColor: Colors.surface2

    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null

    readonly property real signal: active ? active.signalStrength : 0
    
    readonly property string icon: {
        if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
        if (!active) return String.fromCodePoint(0xF092D)

        let tier = signal >= 0.75 ? 4
                : signal >= 0.50 ? 3
                : signal >= 0.25 ? 2
                : 1

        return String.fromCodePoint(0xF091F + (tier - 1) * 3)
    }

    Text {
        text: network.icon
        color: Networking.wifiEnabled ? network.baseColor : network.disabledColor

        font { family: root.fontFamily; pixelSize: root.fontSize }
    }

    Text {
        text: {
            if (!Networking.wifiEnabled) return "off"
            if (!network.active) return "Disconnected"

            return network.active.name
        }

        color: network.baseColor
        font { family: root.fontFamily; pixelSize: root.fontSize }
    }
}