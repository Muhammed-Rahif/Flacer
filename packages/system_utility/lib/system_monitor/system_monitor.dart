import 'dart:io';

import './system_monitor_linux.dart';

abstract class SystemMonitor {
  static SystemMonitor create() {
    if (Platform.isLinux) {
      return SystemMonitorLinux();
    } else {
      throw "Not implemented by system_utility";
    }
  }

  int get totalRAM;
  int get totalROM;

  int getCpuUsage();

  int getRAMUsed();

  int getROMUsed();
}
