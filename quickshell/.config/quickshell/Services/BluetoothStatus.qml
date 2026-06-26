import Quickshell
import Quickshell.Bluetooth
import QtQuick

pragma Singleton

Item {
    property var defaultAdapter: Bluetooth.defaultAdapter
    property var devices: defaultAdapter ? defaultAdapter.devices : null
    property var connected: devices ? devices.values.filter(d => d.connected) : null
    
    // property var log: console.log(connected) 
    readonly property string icon: {
        if (!defaultAdapter) return String.fromCodePoint(0xf00b2)
        if (connected.length <= 0) return String.fromCodePoint(0xf00af)
        return String.fromCodePoint(0xf00b1)
    }
}