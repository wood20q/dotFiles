import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "Buttons"
import ".."

PanelWindow {
    id: powerMenu
    property int squareSize: 50
    property color boxColor: Colors.blue
    property int borderSize: 3

    anchors { top: true; left: true}
    margins { top: 12 ; left: 12}
    
    implicitWidth: powerButtons.implicitWidth + (2 * root.globalSpacing)
    implicitHeight: powerButtons.implicitHeight + (2 * root.globalSpacing)
    color: "transparent"

    // exclusionMode: ExclusionMode.Ignore

    IpcHandler {
        target: "powerMenu"

        function view(): void {root.powerVisable = true}
        function hide(): void {root.powerVisable = false}
    }


    Rectangle {
        anchors.fill: parent
        color: Colors.base
        radius: height/2

        RowLayout {
            id: powerButtons
            spacing: root.globalSpacing
            anchors.centerIn: parent

            SimpleButton {
                id: power
                text: ""
                boxColor: powerMenu.boxColor
                squareSize: powerMenu.squareSize
                borderSize: powerMenu.borderSize
                hoverColor: Colors.red
                command: "hyprshutdown --post-cmd 'systemctl poweroff'"
            }
            SimpleButton {
                id: restart
                text: ""
                boxColor: powerMenu.boxColor
                squareSize: powerMenu.squareSize
                hoverColor: Colors.green
                borderSize: powerMenu.borderSize
                command: "hyprshutdown --post-cmd 'systemctl reboot'"
            }
            SimpleButton {
                id: suspend
                text: "󰍷"
                boxColor: powerMenu.boxColor
                squareSize: powerMenu.squareSize
                hoverColor: Colors.peach
                borderSize: powerMenu.borderSize
                command: `qs ipc call powerMenu hide && hyprctl dispatch "hl.dsp.submap('reset')"  && systemctl suspend && hyprlock`
            }
            SimpleButton {
                id: lock
                text: "󱅟"
                boxColor: powerMenu.boxColor
                squareSize: powerMenu.squareSize
                hoverColor: Colors.yellow
                borderSize: powerMenu.borderSize
                command: "qs ipc call powerMenu hide && hyprlock"
            }
            SimpleButton {
                id: logout
                text: "󰗽"
                boxColor: powerMenu.boxColor
                squareSize: powerMenu.squareSize
                hoverColor: Colors.mauve
                borderSize: powerMenu.borderSize
                command: "hyprshutdown"
            }
        }
    }
}