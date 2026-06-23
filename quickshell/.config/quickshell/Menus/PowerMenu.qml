import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import ".."

PanelWindow {
    id: powerMenu
    property int size: 50
    property color boxColor: Colors.blue
    property int cornerRadius: size/2
    property int borderSize: 3

    anchors { top: true; left: true}
    margins { top: 12 + root.height; left: 12}
    
    implicitWidth: powerButtons.implicitWidth + 10
    implicitHeight: powerButtons.implicitHeight + 10
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    IpcHandler {
        target: "powerMenu"

        function view(): void {root.powerVisable = true}
        function hide(): void {root.powerVisable = false}
    }


    Rectangle {
        anchors.fill: parent
        color: Colors.base
        radius: cornerRadius

        RowLayout {
            id: powerButtons
            spacing: root.globalSpacing
            anchors.centerIn: parent

            Button {
                id: power
                text: ""
                boxColor: powerMenu.boxColor
                size: powerMenu.size
                borderSize: powerMenu.borderSize
                hoverColor: Colors.red
                command: "hyprshutdown --post-cmd 'systemctl poweroff'"
            }
            Button {
                id: restart
                text: ""
                boxColor: powerMenu.boxColor
                size: powerMenu.size
                hoverColor: Colors.green
                borderSize: powerMenu.borderSize
                command: "hyprshutdown --post-cmd 'systemctl reboot'"
            }
            Button {
                id: suspend
                text: "󰍷"
                boxColor: powerMenu.boxColor
                size: powerMenu.size
                hoverColor: Colors.peach
                borderSize: powerMenu.borderSize
                command: `qs ipc call powerMenu hide && hyprctl dispatch "hl.dsp.submap('reset')"  && systemctl suspend && hyprlock`
            }
            Button {
                id: lock
                text: "󱅟"
                boxColor: powerMenu.boxColor
                size: powerMenu.size
                hoverColor: Colors.yellow
                borderSize: powerMenu.borderSize
                command: "qs ipc call powerMenu hide && hyprlock"
            }
            Button {
                id: logout
                text: "󰗽"
                boxColor: powerMenu.boxColor
                size: powerMenu.size
                hoverColor: Colors.mauve
                borderSize: powerMenu.borderSize
                command: "hyprshutdown"
            }
        }
    }
}