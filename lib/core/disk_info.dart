import 'dart:convert';
import 'dart:io';

import 'package:flacer/utils/strings.dart';

class DiskInfo {
  // Function to get total disk space
  static int get totalDiskSpace {
    final String diskInfo = Process.runSync('df', []).stdout;
    final diskInfoLines = const LineSplitter().convert(diskInfo);

    final headerLineSpiltted = diskInfoLines.first.split(whitespaceRegex);
    final totalIndx = headerLineSpiltted.indexOf('1K-blocks');

    for (var line in diskInfoLines) {
      if (line.endsWith('/')) {
        final diskInfo = line.split(whitespaceRegex);
        final totalSpace = int.tryParse(diskInfo[totalIndx]) ?? 0;

        return (totalSpace); // Values are in KB
      }
    }

    return 0;
  }

  // Function to get used disk space
  static int get usedDiskSpace {
    final String diskInfo = Process.runSync('df', []).stdout;
    final diskInfoLines = const LineSplitter().convert(diskInfo);

    final headerLineSpiltted = diskInfoLines.first.split(whitespaceRegex);
    final usedIndx = headerLineSpiltted.indexOf('Used');

    for (var line in diskInfoLines) {
      if (line.endsWith('/')) {
        final diskInfo = line.split(whitespaceRegex);
        final totalSpace = int.tryParse(diskInfo[usedIndx]) ?? 0;

        return (totalSpace); // Values are in KB
      }
    }

    return 0;
  }

  // Function to get available disk space
  static int get availableDiskSpace {
    final String diskInfo = Process.runSync('df', []).stdout;
    final diskInfoLines = const LineSplitter().convert(diskInfo);

    final headerLineSpiltted = diskInfoLines.first.split(whitespaceRegex);
    final availableIndx = headerLineSpiltted.indexOf('Available');

    for (var line in diskInfoLines) {
      if (line.endsWith('/')) {
        final diskInfo = line.split(whitespaceRegex);
        final totalSpace = int.tryParse(diskInfo[availableIndx]) ?? 0;

        return (totalSpace); // Values are in KB
      }
    }

    return 0;
  }
}
