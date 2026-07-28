import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."

RowLayout {
  id: workspaces
  spacing: root.globalSpacing - 4
  property color highlightColor: Colors.sky

  Repeater {
    model: 10

    Rectangle {
      id: box
      
      property bool hovered: false
      property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)

      implicitHeight: root.fontSize + 4
      implicitWidth: text.implicitWidth + 8
      color: "transparent"

      Text { 
        id: text
        anchors.centerIn: parent
        text: index + 1
        color: hovered? workspaces.highlightColor : (isActive ? workspaces.highlightColor : (ws ? Colors.blue : Colors.surface0)) // hovered : active : notEmpty : empty colors
        font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }

        Behavior on color {
          ColorAnimation { duration: 200 }
        }

      }


      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: box.hovered = true
        onExited: box.hovered = false
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
      }
    }
  }
}
