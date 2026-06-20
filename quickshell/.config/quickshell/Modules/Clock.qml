import Quickshell
import QtQuick

Text {
  id: clockText
  color: root.colBlue
  font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
  text: Qt.formatDateTime(clock.date, "MMM | hh:mm ap | dd")

  MouseArea {
    anchors.fill: parent
    onClicked: Quickshell.execDetached(["sh", "-c", "chromium --app=https://calendar.google.com"])
  }
 
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}

