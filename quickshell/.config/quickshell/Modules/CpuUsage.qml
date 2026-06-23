import QtQuick
import ".."

Text {
  text: "CPU: " + cpuUsage + "%"
  color: Colors.yellow
  font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
}


