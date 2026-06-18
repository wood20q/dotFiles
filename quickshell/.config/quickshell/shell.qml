import Quickshell
//import Quickshell.Wayland
//import Quickshell.Io
//import Quickshell.Hyprland
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import "Modules"
import "SystemData"

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
  property int globalSpacing: 8

  // SystemData
  property int cpuUsage: 0
  property int memUsage: 0
  property var lastCPUIdle: 0
  property var lastCPUTotal: 0

  // submap vars
  property string activeSubmap: ""

  // Networking
  property string networkName: "WifiNetwork PlaceHolder"

  // Refreshing the system data using ./SystemData/RefreshData
  RefreshData {}

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 35
  color: colBg 


  RowLayout {
    id: leftModules
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: globalSpacing
    spacing: globalSpacing

    /// Left
    Workspaces {}

    Submap {}

  }

  RowLayout {
    id: centerModules
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: globalSpacing

    /// Center
    Clock {}

  }

  RowLayout {
    id: rightModules
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: globalSpacing
    spacing: globalSpacing

    /// Right
    CpuUsage {}
    Spacer {}

    MemUsage {}
    Spacer {}

    Text {
      text: root.networkName
      color: root.colCyan
      font { pixelSize: root.fontSize; bold: true; family: root.fontFamily }
    }
  }
}
