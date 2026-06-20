import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  Repeater {
    model: 5

    Text { 
      id: text
      property bool hovered: false
      property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
      text: index + 1
      color: hovered? colCyan : (isActive ? colCyan : (ws ? colBlue : colMuted)) // hovered : active : notEmpty : empty colors
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: text.hovered = true
        onExited: text.hovered = false
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
      }
    }
  }
}
