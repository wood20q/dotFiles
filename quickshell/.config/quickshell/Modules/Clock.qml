import Quickshell
import QtQuick
import ".."

Text {
  id: clockText
  color: Colors.blue
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

