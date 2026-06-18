import Quickshell
import QtQuick
import QtQuick.Layouts
import "Modules"

RowLayout {
  id: leftModules
  anchors.centerIn: parent
  spacing: globalSpacing

  Logo {
  id: logo
  color: root.colMuted
  border: logo.color
  }
  
  Workspaces {}

  Submap { visible: root.activeSubmap !== "" }
}

