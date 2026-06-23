import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import ".."

RowLayout {
  id: battery
  spacing: root.globalSpacing
  property color baseColor: Colors.text

  property var battery: UPower.displayDevice
  property bool charging: battery.state === UPowerDeviceState.charging
  readonly property int level: Math.round(battery.percent * 100)

  readonly property string icon: {
    console.log(`battery: ${battery} | charging: ${charging} | level: ${level} | type: ${battery.type}`)
    if (charging) return String.fromCodePoint(0xF0084)
    if (level >= 100) return String.fromCodePoint(0xF0079)
    if (level < 10) return String.fromCodePoint(0xF0083)

    // If the level is betwwen 10 and 100, it will calculate the icon based on the level in incroments of 10 (level / 10) starting at level 10
    return String.fromCodePoint(0xF007a + (Math.floor(level / 10) - 1))
  }

  Text {
    id: batteryIcon
    text: battery.icon
    color: battery.charging ? Colors.green : ( battery.level <= 15 ? Colors.red : battery.baseColor )
    font { family: root.fontFamily; pixelSize: fontSize }
  }

  Text {
    id: batterytext
    text: battery.level + "%"
    color: battery.baseColor
    font { family: root.fontFamily; pixelSize: fontSize }
  }
}