import QtQuick
import QtQuick.Shapes
import ".."

Item {
    id: logo

    property color color: Colors.overlay2
    property color circles: Colors.mantle
    property color border: "transparent"
    property int size: root.fontSize + 5

    implicitWidth: size
    implicitHeight: size

    Shape {
        anchors.fill: parent
        asynchronous: true

        // Top Rounded Rectangle
        ShapePath {
            fillColor: color
            strokeColor: border
            scale: Qt.size(logo.width / 25, logo.height / 25)

            PathSvg {
                path: "M4 6.5C4 4.567 5.567 3 7.5 3L16.5 3C18.433 3 20 4.567 20 6.5V6.5C20 8.433 18.433 10 16.5 10L7.5 10C5.567 10 4 8.433 4 6.5V6.5Z"
            }
        }

        // Bottom Rounded Rectangle
        ShapePath {
            fillColor: color
            strokeColor: border
            scale: Qt.size(logo.width / 25, logo.height / 25)

            PathSvg {
                path: "M20 17.5C20 19.433 18.433 21 16.5 21L7.5 21C5.567 21 4 19.433 4 17.5V17.5C4 15.567 5.567 14 7.5 14L16.5 14C18.433 14 20 15.567 20 17.5V17.5Z"
            }
        }

        // Bottom Right Circle (cx="16.5", cy="17.5", r="1")
        ShapePath {
            fillColor: circles
            strokeColor: border
            scale: Qt.size(logo.width / 25, logo.height / 25)

            PathSvg {
                // SVG path representation of a circle with radius 1
                path: "M 16.5, 17.5 m -1, 0 a 1,1 0 1,0 2,0 a 1,1 0 1,0 -2,0"
            }
        }

        // Top Left Circle (cx="7.5", cy="6.5", r="1")
        ShapePath {
            fillColor: circles
            strokeColor: border
            scale: Qt.size(logo.width / 25, logo.height / 25)

            PathSvg {
                // SVG path representation of a circle with radius 1
                path: "M 7.5, 6.5 m -1, 0 a 1,1 0 1,0 2,0 a 1,1 0 1,0 -2,0"
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.controlCenterVisable = !root.controlCenterVisable
            controlCenter.bluetoothVisable = false;
            BluetoothStatus.defaultAdapter.discovering = bluetoothVisable
        }
    }
}