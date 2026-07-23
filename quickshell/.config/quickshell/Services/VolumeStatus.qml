import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
             
pragma Singleton

Item {
    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF0581)
        if (muted) return String.fromCodePoint(0xF0E08)

        if (vol === 0) return String.fromCodePoint(0xF0581)
        if (vol < 34) return String.fromCodePoint(0xF057F)
        if (vol < 67) return String.fromCodePoint(0xF0580)

        return String.fromCodePoint(0xF057E)
    }
}