import Quickshell
import QtQuick
import QtQuick.Layouts
import "Modules"
import "SystemData"
import "Menus"
import "."

PanelWindow {
  id: root

  // Colors
  // property color colBg: "#ff1a1b26" // AARRGGBB => AA: Alpha | RR: Red | GG: Green | BB: BLue
  // property color colFg: "#a9b1d6"
  // property color colMuted: "#444b6a"
  // property color colRed: '#e26161'
  // property color colOrange: '#e2b243'
  // property color colYellow: '#f0e76e'
  // property color colGreen: '#88d97b'
  // property color colBlue: "#7aa2f7"
  // property color colCyan: "#0db9d7"
  // property color colPurple: '#ae7ff5'
  property string fontFamily: "JetBrainsMono Nerd Font Propo"
  property int fontSize: 18
  property int globalSpacing: 8

  // SystemData
  property int cpuUsage: 0
  property int memUsage: 0
  property var lastCPUIdle: 0
  property var lastCPUTotal: 0

  // submap vars
  property string activeSubmap: ""

  // Popup Visability
  property bool powerVisable: false
  property bool controlCenterVisable: false

  // Starting properties for the bar itself
  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: fontSize * 2
  color: "transparent"

  // Refreshing the system data using ./SystemData/RefreshData
  RefreshData {}

  PowerMenu { visible: powerVisable }
  ControlCenter { id: controlCenter; visible: controlCenterVisable }

  Rectangle {
    id: leftGroup
    color: Colors.base

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
    color: Colors.base

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    width: centerModules.implicitWidth + (globalSpacing * 2)
    height: parent.height
    radius: 15

    CenterModules { id: centerModules }
  }

  Rectangle {
    id: rightGroup
    color: Colors.base

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: globalSpacing

    width: rightModules.implicitWidth + (globalSpacing * 2)
    height: parent.height
    radius: 15

    RightModules { id: rightModules }
  }
} 
