import QtQuick

Text {
  text: "Mem: " + memUsage + "%"
  color: root.colCyan
  font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
}
