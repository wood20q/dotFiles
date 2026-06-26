import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../.."
import "../../Services"

Rectangle {
    height: 100
    width: 100
    radius: height/2
    color: button.hovered ? Colors.mauve : Colors.surface1

    property color textColor: button.hovered ? Colors.surface1 : Colors.text

    RowLayout {
        anchors.centerIn: parent
        Text {
            text: NetworkingStatus.icon
            color: textColor
            font {family: root.fontFamily; pixelSize: root.fontSize}
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
        Text {
            text: {
            if (!Networking.wifiEnabled) return "off"
            if (!NetworkingStatus.active) return "Disconnected"

            return NetworkingStatus.active.name
            }

            color: textColor
            font {family: root.fontFamily; pixelSize: root.fontSize - 6}
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
    }
    AbstractButton {
        id: button
        anchors.fill: parent
        onClicked: Quickshell.execDetached(["sh", "-c", 'notify-send "Wifi" "Work in progress"'])
    }
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}