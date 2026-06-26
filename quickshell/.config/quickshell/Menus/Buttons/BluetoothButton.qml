import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../.."
import "../../Services"

Rectangle {
    id: bluetooth
    height: 100
    width: 100
    radius: height/2
    color: button.hovered ? Colors.mauve : Colors.surface1

    property color textColor: button.hovered ? Colors.surface1 : Colors.text
    property bool clicked: false

    RowLayout {
        anchors.centerIn: parent
        Text {
            text: BluetoothStatus.icon
            color: textColor
            font {family: root.fontFamily; pixelSize: root.fontSize}

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
        Item { Layout.fillWidth: true }
        Text {
            text: {
            if (!Bluetooth.adapters) return "off"
            if (!BluetoothStatus.connected) return "Nothing Connected"

            return `${BluetoothStatus.connected.length} Connected`
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
        onClicked: {
            controlCenter.bluetoothVisable = true
            BluetoothStatus.defaultAdapter.discovering = bluetoothVisable
        }
    }
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}