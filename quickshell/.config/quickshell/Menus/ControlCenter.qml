import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import "Buttons"
import "../Services"
import ".."

PanelWindow {
    id: controlCenter
    property color boxColor: Colors.surface1
    property int boxWidth: 100
    property int boxHeight: 50
    property int rounding: 20

    // Sub Menues
    property bool bluetoothVisable: false

    anchors { top: true; right: true }
    margins { top: 12; right: 12}
    color: "transparent"

    implicitHeight: panelLayout.implicitHeight + (2 * root.globalSpacing)
    implicitWidth: panelLayout.implicitWidth + (2 * root.globalSpacing)

    Rectangle {
        visible: !bluetoothVisable
        id: panel
        anchors.fill: parent
        color: Colors.base
        radius: rounding

        ColumnLayout {
            id: panelLayout
            spacing: root.globalSpacing
            anchors.centerIn: parent

            WifiButton { id: wifi; height: boxHeight; width: (boxWidth * 2) + root.globalSpacing }
            BluetoothButton { id: bluetooth; height: boxHeight; width: (boxWidth * 2) + root.globalSpacing }

            // RowLayout {
            //     SimpleButton { height: controlCenter.boxHeight; width: controlCenter.boxWidth; boxColor: controlCenter.boxColor; text: `00`; fontSize: root.fontSize }
            //     SimpleButton { height: controlCenter.boxHeight; width: controlCenter.boxWidth; boxColor: controlCenter.boxColor; text: `${bluetoothVisable}`; fontSize: root.fontSize - 5 }
            // }
        }
    }

    BluetoothMenu { id: bluetoothMenu; visible: bluetoothVisable }
}