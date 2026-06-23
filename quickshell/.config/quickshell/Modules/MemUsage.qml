import QtQuick
import ".."

Text {
  text: "Mem: " + memUsage + "%"
  color: Colors.sky
  font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
}
