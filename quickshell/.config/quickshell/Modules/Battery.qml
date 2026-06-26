import Quickshell
import QtQuick
import QtQuick.Layouts
import "../Services"
import ".."

RowLayout {
  id: battery
  spacing: root.globalSpacing
  property color baseColor: Colors.text

  Text {
    id: batteryIcon
    text: BatteryStatus.icon
    color: BatteryStatus.charging ? Colors.green : ( BatteryStatus.level <= 15 ? Colors.red : battery.baseColor )
    font { family: root.fontFamily; pixelSize: fontSize }
  }

  Text {
    id: batterytext
    text: BatteryStatus.level + "%"
    color: battery.baseColor
    font { family: root.fontFamily; pixelSize: fontSize }
  }
}