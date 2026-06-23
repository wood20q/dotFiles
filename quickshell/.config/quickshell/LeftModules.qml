import Quickshell
import QtQuick
import QtQuick.Layouts
import "Modules"
import "."

RowLayout {
  id: leftModules
  anchors.centerIn: parent
  spacing: globalSpacing

  Logo {
  id: logo
  color: Colors.surface2
  border: logo.color
  }
  
  Workspaces {}

  Submap { visible: root.activeSubmap !== "" }
}

