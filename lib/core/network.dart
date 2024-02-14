import 'dart:async';
import 'dart:io';

class NetworkMonitor {
  static BigInt _initialUploadBytes = _readStats()[0];
  static BigInt _initialDownloadBytes = _readStats()[1];

  static Future<List<double>> get internetSpeed async {
    // Get current values
    var currentStats = _readStats();
    BigInt currentUploadBytes = currentStats[0];
    BigInt currentDownloadBytes = currentStats[1];

    // Calculate upload and download speeds
    double uploadSpeed = (currentUploadBytes - _initialUploadBytes).toDouble() /
        1024; // Convert to KB
    double downloadSpeed =
        (currentDownloadBytes - _initialDownloadBytes).toDouble() /
            1024; // Convert to KB

    // Update initial values for next calculation
    _initialUploadBytes = currentUploadBytes;
    _initialDownloadBytes = currentDownloadBytes;

    return [uploadSpeed, downloadSpeed];
  }

  static List<BigInt> _readStats() {
    BigInt uploadBytes = BigInt.zero;
    BigInt downloadBytes = BigInt.zero;

    var lines = File('/proc/net/dev').readAsLinesSync();
    // Skip the first two lines (headers)
    lines.removeRange(0, 1);

    // Extract interface name and stats
    for (var line in lines) {
      var parts = line.trim().split(RegExp(r'\s+'));
      if (parts.isNotEmpty) {
        // ignore: unused_local_variable
        String interface = parts[0].replaceAll(':', '');

        BigInt rxBytes = BigInt.tryParse(parts[1]) ?? BigInt.zero;
        BigInt txBytes = BigInt.tryParse(parts[9]) ?? BigInt.zero;

        uploadBytes += txBytes;
        downloadBytes += rxBytes;
      }
    }

    return [uploadBytes, downloadBytes];
  }
}

void main() {
  // Update speeds every second
  Timer.periodic(Duration(seconds: 1), (timer) async {
    for (int i = 0; i < stdout.terminalLines; i++) {
      stdout.writeln();
    } // Clear the console
    var speeds = await NetworkMonitor.internetSpeed;
    print("Upload Speed: ${speeds[0]} KB/s");
    print("Download Speed: ${speeds[1]} KB/s");
    await Future.delayed(Duration(milliseconds: 100)); // Delay for a short time
  });
}
