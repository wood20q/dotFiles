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

  Battery {id: battery; visible: battery.battery.type != 0 }
  Spacer { visible: battery.battery.type != 0 }

  Volume {}
  Spacer{}

  Network { id: network }
  Spacer {}

  ControlCenterIcon {}
}
