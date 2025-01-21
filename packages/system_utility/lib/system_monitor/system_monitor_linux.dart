import 'dart:io';
import './system_monitor.dart';

class SystemMonitorLinux extends SystemMonitor {
  @override
  int get totalRAM {
    final memInfo = File('/proc/meminfo').readAsLinesSync();
    for (var line in memInfo) {
      if (line.startsWith('MemTotal:')) {
        return _extractKbValue(line) ~/ 1024; // Convert to MB
      }
    }
    return 0;
  }

  @override
  int get totalROM {
    final result = Process.runSync('df', ['/', '--output=size']);
    List<String> lines = result.stdout.toString().split('\n');
    if (lines.length > 1) {
      return int.parse(lines[1].trim()) ~/ 1024; // Convert to MB
    }
    return 0;
  }

  @override
  int getCpuUsage() {
    final stat1 = File('/proc/stat').readAsLinesSync().first;
    sleep(
        Duration(milliseconds: 100)); // Small delay to measure CPU usage change
    final stat2 = File('/proc/stat').readAsLinesSync().first;

    List<int> values1 = _parseCpuStat(stat1);
    List<int> values2 = _parseCpuStat(stat2);

    int total1 = values1.reduce((a, b) => a + b);
    int total2 = values2.reduce((a, b) => a + b);
    int idle1 = values1[3];
    int idle2 = values2[3];

    int totalDiff = total2 - total1;
    int idleDiff = idle2 - idle1;

    return ((1 - (idleDiff / totalDiff)) * 100).round();
  }

  List<int> _parseCpuStat(String stat) {
    var parts = stat.split(RegExp(r'\s+')).sublist(1).map(int.parse).toList();
    return parts;
  }

  @override
  int getRAMUsed() {
    final memInfo = File('/proc/meminfo').readAsLinesSync();
    int totalMemory = 0, availableMemory = 0;

    for (var line in memInfo) {
      if (line.startsWith('MemTotal:')) {
        totalMemory = _extractKbValue(line);
      } else if (line.startsWith('MemAvailable:')) {
        availableMemory = _extractKbValue(line);
      }
    }

    int usedMemory = totalMemory - availableMemory;
    return usedMemory ~/ 1024; // Convert to MB
  }

  int _extractKbValue(String line) {
    return int.parse(RegExp(r'\d+').firstMatch(line)!.group(0)!);
  }

  @override
  int getROMUsed() {
    final result = Process.runSync('df', ['/', '--output=used']);
    List<String> lines = result.stdout.toString().split('\n');
    if (lines.length > 1) {
      return int.parse(lines[1].trim()) ~/ 1024; // Convert to MB
    }
    return 0;
  }
}
