import 'package:flacer/core/system_info.dart';
import 'package:flutter/material.dart';

final systemDetails = {
  "Hostname": SystemInfo.hostName,
  "Platform": SystemInfo.platform,
  "Distribution": SystemInfo.distribution,
  "Kernel Release": SystemInfo.kernelRelease,
  "CPU Model": SystemInfo.cpuModel,
  "CPU Core Count": SystemInfo.coreCount.toString(),
  "CPU Speed": SystemInfo.cpuSpeed
};

class SystemInfoCard extends StatelessWidget {
  const SystemInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyLargeStyle = Theme.of(context).textTheme.bodyLarge;
    final keyTxtStyle = bodyLargeStyle?.copyWith(
      color: bodyLargeStyle.color?.withOpacity(.65),
    );
    final valueTxtStyle = bodyLargeStyle?.copyWith(fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DefaultTextStyle(
        style: bodyLargeStyle!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final entry in systemDetails.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Text("${entry.key}: ", style: keyTxtStyle),
                    Text(entry.value, style: valueTxtStyle),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
