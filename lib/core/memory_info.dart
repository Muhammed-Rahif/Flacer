import 'dart:io';

class MemoryInfo {
  // Function to read a specific field from /proc/meminfo
  static int getMeminfoValue(String field) {
    var meminfo = File("/proc/meminfo");
    var lines = meminfo.readAsLinesSync();
    for (var line in lines) {
      if (line.startsWith(field)) {
        final integersRegex = RegExp(r'\d+');
        var value = integersRegex.firstMatch(line)?.group(0);
        var parsedValue = value != null ? int.tryParse(value) : null;
        if (parsedValue is int) {
          return parsedValue;
        }
      }
    }
    return -1; // Return -1 if field not found
  }

  // Getter to get Swap free
  static int get swapFree => getMeminfoValue("SwapFree:");

  // Getter to get Swap total
  static int get swapTotal => getMeminfoValue("SwapTotal:");

  // Getter to get Memory free
  static int get memoryFree => getMeminfoValue("MemFree:");

  // Getter to get Memory total
  static int get memoryTotal => getMeminfoValue("MemTotal:");

  // Getter to get Buffers
  static int get buffers => getMeminfoValue("Buffers:");

  // Getter to get Cached
  static int get cached => getMeminfoValue("Cached:");

  // Getter to get Shmem
  static int get shmem => getMeminfoValue("Shmem:");

  // Getter to get SReclaimable
  static int get sReclaimable => getMeminfoValue("SReclaimable:");
}
