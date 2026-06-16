import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  // Colors
  property color colBg: "#b31a1b26" // AARRGGBB => AA: Alpha | RR: Red | GG: Green | BB: BLue
  property color colFg: "#a9b1d6"
  property color colMuted: "#444b6a"
  property color colCyan: "#0db9d7"
  property color colBlue: "#7aa2f7"
  property color colYellow: "#e0af68"
  property string fontFamily: "JetBrainsMono Nerd Font Propo"
  property int fontSize: 15

  // SystemData
  property int cpuUsage: 0
  property int memUsage: 0
  property var lastCPUIdle: 0
  property var lastCPUTotal: 0

  // submap vars
  property string activeSubmap: ""

  // Processes
  // CPU
  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1,8).reduce((a, b) => a + parseInt(b), 0)
        if (lastCPUTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle - lastCPUIdle) / (total - lastCPUTotal)))
        }
        lastCPUTotal = total
        lastCPUIdle = idle
      }
    }
    Component.onCompleted: running = true
  }

  // Memory
  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  // Timer
  Timer {
    interval: 2000 // 2000 ms ==> 2 sec
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
    }
  }

  Connections {
    target: Hyprland

    // Listen to raw IPC events from socket2
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.activeSubmap = event.data
      }
    }
  }

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 35
  color: colBg 

  /// Left
  // Workspascs
  RowLayout {
    anchors.fill: parent
    anchors.margins: 8

    Repeater {
      model: 5

      Text { 
        property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
        text: index + 1
        color: isActive ? colCyan : (ws ? colBlue : colMuted) // active : notEmpty : empty colors
        font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${index + 1} })`)
        }
      }
    }

    // Bar between submap and workspaces and toggles visability
    Rectangle {
      id: workspaceBar
      width: 0
      height: 16
      color: root.colMuted
      
      Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: workspaceBar.width = root.activeSubmap !== "" ? 2 : 0
      }
    }
    
    // Shows the active submap
    Text {
      id: submap
      text: root.activeSubmap
      color: root.colFg 
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
    }

    // adds space
    Item { Layout.fillWidth: true }
    
    /// Center
    // Clock
    Text {
      id: clock
      color: root.colBlue
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
      text: Qt.formatDateTime(new Date(), "ddd, MMM dd | HH:mm")

      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd | HH:mm")
      }
    }

    // adds space
    Item { Layout.fillWidth: true }

    /// Right
    // CPU
    Text {
      text: "CPU: " + cpuUsage + "%"
      color: root.colYellow
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
    }

    Rectangle { width: 2; height: 16; color: root.colMuted }
   
    // Mem
    Text {
      text: "Mem: " + memUsage + "%"
      color: root.colCyan
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
    }

  }
}
