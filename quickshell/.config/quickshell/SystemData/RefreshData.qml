import Quickshell
import QtQuick

Item {
  // Processes
  CpuProc { id: cpuProc }
  MemProc { id: memProc }

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
}
