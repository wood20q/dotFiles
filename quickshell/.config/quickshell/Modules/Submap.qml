import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: subMap
  spacing: root.globalSpacing

  property color color: root.colFg
  
  Connections {
    target: Hyprland

    // Listen to raw IPC events from socket2
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.activeSubmap = event.data

        if (event.data == "⏻") {
          color = root.colRed
        } else {
          color = root.colFg
        }
        
      }
    }
  }

  Spacer {}



  // Shows the active submap
  Text {
    id: submap
    text: root.activeSubmap
    color: subMap.color
    font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
  }
}


