import Quickshell
import QtQuick
import QtQuick.Layouts
import "Modules"


RowLayout {
  id: rightModules
  anchors.centerIn: parent
  spacing: globalSpacing

  /// Right
  CpuUsage {}
  Spacer {}

  MemUsage {}
  Spacer {}

  Network {}
}
