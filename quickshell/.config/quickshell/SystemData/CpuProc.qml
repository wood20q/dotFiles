import Quickshell
import QtQuick
import Quickshell.Io

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


