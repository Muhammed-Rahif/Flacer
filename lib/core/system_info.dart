import 'dart:io';

// System info includes:
// hostname
// platform
// distribution
// kernel release
// CPU model
// CPU core count
// CPU speed

class SystemInfo {
  static String get hostName => Platform.localHostname;

  static String get platform =>
      Process.runSync(r'uname', ['-s', '-m']).stdout.toString().trim();

  static String get distribution => File('/etc/os-release')
      .readAsStringSync()
      .split('\n')
      .map((line) => line.split('='))
      .where((parts) =>
          parts.length == 2 && (parts[0] == 'NAME' || parts[0] == 'VERSION_ID'))
      .map((parts) => parts[1].replaceAll('"', ''))
      .join(' ');

  static String get kernelRelease =>
      Process.runSync(r'uname', ['-r']).stdout.toString().trim();

  // https://askubuntu.com/questions/988440/how-do-i-get-the-model-name-of-my-processor
  static String get cpuModel {
    var result = Process.runSync(
        "sh", ["-c", r"lscpu | sed -nr '/Model name/ s/.*:\s*(.*) @ .*/\1/p'"]);
    if (result.exitCode == 0) {
      return result.stdout.toString().trim();
    }
    return "Unknown";
  }

  // https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
  static int get coreCount =>
      int.parse(Process.runSync('nproc', ['--all']).stdout.toString().trim());

  // https://askubuntu.com/questions/218567/any-way-to-check-the-clock-speed-of-my-processor
  static String get cpuSpeed {
    var result = Process.runSync(
        "sh", ["-c", r"lscpu | sed -nr '/CPU max MHz/ s/.*:\s*(.*)/\1/p'"]);
    if (result.exitCode == 0) {
      var maxMHz = double.tryParse(result.stdout.trim());
      if (maxMHz != null) {
        var maxGHz = maxMHz / 1000; // Convert MHz to GHz
        return "${maxGHz.toStringAsFixed(2)}GHz"; // Convert GHz to string with two decimal places
      }
    }
    return "Unknown";
  }
}
