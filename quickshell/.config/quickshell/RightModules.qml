import Quickshell
import QtQuick
import QtQuick.Layouts
import "Modules"
import "Services"

RowLayout {
  id: rightModules
  anchors.centerIn: parent
  spacing: globalSpacing

  /// Right
  CpuUsage {}
  Spacer {}

  MemUsage {}
  Spacer {}

  Battery { visible: BatteryStatus.level != 0 }
  Spacer { visible: BatteryStatus.level != 0 }

  Volume {}
  Spacer{}

  Network { id: network }
  Spacer {}

  ControlCenterIcon {}
}
