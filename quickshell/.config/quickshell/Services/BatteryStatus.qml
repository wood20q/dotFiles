import Quickshell
import Quickshell.Services.UPower
import QtQuick

pragma Singleton

Item {
    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
    console.log(`battery: ${battery} | charging: ${charging} | level: ${level} | type: ${battery.type}`)
    if (charging) return String.fromCodePoint(0xF0084)
    if (level >= 100) return String.fromCodePoint(0xF0079)
    if (level < 10) return String.fromCodePoint(0xF0083)

    // If the level is betwwen 10 and 100, it will calculate the icon based on the level in incroments of 10 (level / 10) starting at level 10
    return String.fromCodePoint(0xF007a + (Math.floor(level / 10) - 1))
    }
}
