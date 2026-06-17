import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  Repeater {
    model: 5

    Text { 
      property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
      text: index + 1
      color: isActive ? colCyan : (ws ? colBlue : colMuted) // active : notEmpty : empty colors
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
      }
    }
  }
}
