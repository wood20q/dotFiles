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

  Text {
    text: root.networkName
    color: root.colCyan
    font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
  }
}
