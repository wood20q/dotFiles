import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: root.globalSpacing
  
  Connections {
    target: Hyprland

    // Listen to raw IPC events from socket2
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.activeSubmap = event.data
      }
    }
  }

  Spacer { id: spacer }

  Timer {
    interval: 10
    running: true
    repeat: true
    onTriggered: spacer.width = root.activeSubmap !== "" ? spacer.ogWidth : 0
  }

  // Shows the active submap
  Text {
    id: submap
    text: root.activeSubmap
    color: root.colFg 
    font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
  }
}


