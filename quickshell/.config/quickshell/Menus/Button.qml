import Quickshell
import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: button
    property int size: 50
    property color boxColor: Colors.blue
    property color hoverColor: Colors.sky
    property color filledTextColor: Colors.text
    property int borderSize: 0

    property int cornerRadius: button.size/2
    property int fontSize: button.size/2
    property string text: "n/a"
    property bool hovered: false
    property string command: 'notify-send "error" "set command for button"'
    property int animationtime: 150

    width: button.size
    height: button.size
    color: button.borderSize != 0? "transparent" : (button.hovered? button.hoverColor : button.boxColor)
    radius: button.cornerRadius
    border {
        width: button.borderSize >0? button.borderSize : 0
        color: button.hovered? button.hoverColor : button.boxColor

        Behavior on color {
            ColorAnimation { duration: button.animationtime }
        }
    }
    
    Text {
        text: button.text
        font { pixelSize: fontSize; family: root.fontFamily }
        anchors.centerIn: parent
        color: button.borderSize == 0? button.filledTextColor : (button.hovered? button.hoverColor : button.boxColor)
        
        Behavior on color {
            ColorAnimation { duration: button.animationtime }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hovered = true
        onExited: hovered = false
        onClicked: Quickshell.execDetached(["sh", "-c", button.command])
    }

    Behavior on color {
        ColorAnimation { duration: button.animationtime }
    }
}