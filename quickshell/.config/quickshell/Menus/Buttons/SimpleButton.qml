import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../.."

Rectangle {
    id: button
    property int squareSize: 50
    property color boxColor: Colors.blue
    property color hoverColor: Colors.sky
    property color filledTextColor: Colors.text
    property int borderSize: 0
    property string text: "n/a"

    property int cornerRadius: Math.min(button.height, button.width)/2
    property int fontSize: Math.min(button.height, button.width)/2
    property string command: 'notify-send "error" "set command for button"'
    property int animationtime: 150
    // property int height: squareSize
    // property int width: squareSize

    width: button.squareSize
    height: button.squareSize
    color: button.borderSize != 0? "transparent" : (buttonArea.hovered? button.hoverColor : button.boxColor)
    radius: button.cornerRadius
    border {
        width: button.borderSize >0? button.borderSize : 0
        color: buttonArea.hovered? button.hoverColor : button.boxColor

        Behavior on color {
            ColorAnimation { duration: button.animationtime }
        }
    }
    
    Text {
        text: button.text
        font { pixelSize: fontSize; family: root.fontFamily }
        anchors.centerIn: parent
        color: button.borderSize == 0? button.filledTextColor : (buttonArea.hovered? button.hoverColor : button.boxColor)
        
        Behavior on color {
            ColorAnimation { duration: button.animationtime }
        }
    }

    AbstractButton {
        id: buttonArea
        anchors.fill: parent
        onClicked: Quickshell.execDetached(["sh", "-c", button.command])
    }

    Behavior on color {
        ColorAnimation { duration: button.animationtime }
    }
}