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
  property color colBg: "#ff1a1b26" // AARRGGBB => AA: Alpha | RR: Red | GG: Green | BB: BLue
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

  // Starting properties for the bar itself
  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 35
  color: "transparent"

  // Refreshing the system data using ./SystemData/RefreshData
  RefreshData {}

  Rectangle {
    id: leftGroup
    color: colBg

    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: globalSpacing

    width: leftModules.implicitWidth + (globalSpacing * 2)
    height: parent.height
    radius: 15
    
    LeftModules { id: leftModules }
  }

  Rectangle {
    id: centerGroup
    color: colBg

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    width: centerModules.implicitWidth + (globalSpacing * 2)
    height: parent.height
    radius: 15

    CenterModules { id: centerModules }
  }

  Rectangle {
    id: rightGroup
    color: colBg

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: globalSpacing

    width: rightModules.implicitWidth + (globalSpacing * 2)
    height: parent.height
    radius: 15

    RightModules { id: rightModules }
  }
} 
