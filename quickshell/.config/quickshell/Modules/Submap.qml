import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import ".."

RowLayout {
  id: subMap
  spacing: root.globalSpacing

  property color color: Colors.text
  
  Connections {
    target: Hyprland

    // Listen to raw IPC events from socket2
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.activeSubmap = event.data

        if (event.data == "⏻") {
          color = Colors.red
        } else {
          color = Colors.text
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


