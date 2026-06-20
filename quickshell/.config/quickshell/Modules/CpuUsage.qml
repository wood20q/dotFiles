import QtQuick

Text {
  text: "CPU: " + cpuUsage + "%"
  color: root.colYellow
  font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
}


