import 'package:flacer/extensions/strings.dart';
import 'package:flutter/material.dart';

class SystemInfoHeader extends StatelessWidget {
  const SystemInfoHeader({super.key});

  final String hostname = "Rahifs-Computer";
  final String platform = "linux x86_64";
  final String distribution = "Ubuntu 24.04.1 LTS";
  final String kernelRelease = "6.8.0-41-generic";
  final String cpuModel = "Intel(R) Pentium(R) CPU G3240";

  @override
  Widget build(BuildContext context) {
    final subtitle =
        "\n$distribution | ${platform.capitalize}\nKernal $kernelRelease\nPowered by $cpuModel";

    return Center(
      child: SelectableText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: hostname,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: subtitle)
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
