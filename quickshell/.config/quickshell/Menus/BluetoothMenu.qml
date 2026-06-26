import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Buttons"
import "../Services"
import ".."

PanelWindow {
    color: "transparent"
    anchors { top: true; right: true }
    margins { top: 12; right: 12}

    implicitHeight: window.implicitHeight
    implicitWidth: window.implicitWidth
    
    property int deviceItemWidth: 0

    Rectangle {
        id: window
        implicitHeight: deviceList.implicitHeight + (2 * root.globalSpacing)
        implicitWidth: deviceList.implicitWidth + (2 * root.globalSpacing)
        radius: panel.radius
        color: panel.color

        ColumnLayout {
            id: deviceList
            spacing: root.globalSpacing
            anchors.centerIn: parent
            
            Repeater {
                model: BluetoothStatus.devices?.values.filter(n => !/^([0-9a-fA-F]{2}-){5}[0-9a-fA-F]{2}$/.test(n.name))

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter

                    property var device: modelData

                    Layout.fillWidth: true
                    width: deviceItem.implicitWidth + 15
                    height: deviceItem.implicitHeight + 15
                    radius: Math.min(width, height)/2
                    border { width: 3; color: device.connected ? Colors.green : Colors.red}
                    color: controlCenter.boxColor

                    RowLayout {
                        id: deviceItem
                        anchors.fill: parent
                        anchors.margins: globalSpacing
                        spacing: globalSpacing
                        
                        Text {
                            id: text
                            // anchors.centerIn: parent
                            text: device.name
                            color: Colors.text
                            font { family: root.fontFamily; pixelSize: root.fontSize - 5 }
                        }

                        Item {Layout.fillWidth: true}

                        Rectangle {
                            id: deviceButton

                            implicitHeight: deviceButtonText.implicitHeight
                            implicitWidth: deviceButtonText.implicitWidth + (2 * root.globalSpacing)
                            radius: Math.min(width, height)/2
                            color: Colors.surface0
                            
                            Text {
                                id: deviceButtonText
                                text: device.connected? "Dissconnect" : "Connect"
                                anchors.centerIn: parent
                                font { family: root.fontFamily; pixelSize: root.fontSize - 5}
                                color: Colors.text
                            }

                            AbstractButton {
                                anchors.fill: parent
                                onClicked: device.connected ? device.disconnect() : device.connect()
                            }
                        }
                    }
                }
            }

            // Back Button
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: text.implicitWidth + 30
                height: text.implicitHeight + 10
                border { width: 3; color: Colors.mauve}
                color: controlCenter.boxColor
                radius: Math.min(width, height)/2

                Text {
                    id: text
                    anchors.centerIn: parent
                    text: "Back"
                    color: Colors.text
                    font { family: root.fontFamily; pixelSize: root.fontSize; weight: 1000}
                }
                AbstractButton {
                    id: button
                    anchors.fill: parent
                    onClicked: {controlCenter.bluetoothVisable = false; BluetoothStatus.defaultAdapter.discovering = bluetoothVisable}
                }
            }
        }
    }
}