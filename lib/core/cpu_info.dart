import 'dart:io';

import 'package:flacer/utils/strings.dart';

class CpuInfo {
  static final File _meminfo = File("/proc/meminfo");
  static final File _cpuinfo = File("/proc/cpuinfo");
  static final File _statFile = File("/proc/stat");

  static int getMeminfoValue(String field) {
    var lines = _meminfo.readAsLinesSync();
    for (var line in lines) {
      if (line.startsWith(field)) {
        var value = int.tryParse(line.substring(field.length + 1).trim());
        if (value != null) {
          return value;
        }
      }
    }
    return -1; // Return -1 if field not found
  }

  static int get coreCount {
    var lines = _cpuinfo.readAsLinesSync();
    int coreCount = 0;
    for (var line in lines) {
      if (line.startsWith("processor")) {
        coreCount++;
      }
    }
    return coreCount;
  }

  static Future<double> get processCpuUsage async {
    try {
      var lines1 = _statFile.readAsLinesSync();
      var cpuLine1 = lines1.firstWhere((line) => line.startsWith('cpu '));
      var tokens1 = cpuLine1.split(whitespaceRegex);

      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Wait for a short interval

      var lines2 = _statFile.readAsLinesSync();
      var cpuLine2 = lines2.firstWhere((line) => line.startsWith('cpu '));
      var tokens2 = cpuLine2.split(whitespaceRegex);

      var user1 = int.parse(tokens1[1]);
      var nice1 = int.parse(tokens1[2]);
      var system1 = int.parse(tokens1[3]);
      var idle1 = int.parse(tokens1[4]);
      var iowait1 = int.parse(tokens1[5]);

      var user2 = int.parse(tokens2[1]);
      var nice2 = int.parse(tokens2[2]);
      var system2 = int.parse(tokens2[3]);
      var idle2 = int.parse(tokens2[4]);
      var iowait2 = int.parse(tokens2[5]);

      var total1 = user1 + nice1 + system1 + idle1 + iowait1;
      var total2 = user2 + nice2 + system2 + idle2 + iowait2;

      var usage =
          ((user2 - user1 + system2 - system1) * 100) / (total2 - total1);

      return usage;
    } catch (e) {
      print("Error: $e");
      return -1;
    }
  }

  static int get totalCpuTime {
    var lines = _statFile.readAsLinesSync();
    var firstLine = lines[0].split(whitespaceRegex);
    int totalTime = 0;
    for (var i = 1; i < firstLine.length; ++i) {
      totalTime += int.parse(firstLine[i]);
    }
    return totalTime;
  }

  static List<double> get cpuUsagePerCore {
    var lines = _statFile.readAsLinesSync();
    var cpuUsage = <double>[];
    for (var line in lines) {
      if (line.startsWith("cpu")) {
        var tokens = line.split(whitespaceRegex);

        int totalTime = 0;
        for (var i = 1; i < tokens.length; ++i) {
          totalTime += int.parse(tokens[i]);
        }
        double cpuUsagePercentage = (totalTime / totalCpuTime) * 100.0;
        cpuUsage.add(cpuUsagePercentage);
      }
    }
    return cpuUsage;
  }
}
