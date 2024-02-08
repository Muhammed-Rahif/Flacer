import 'dart:async';

import 'package:flacer/core/cpu_info.dart';
import 'package:flacer/widgets/animated_count.dart';
import 'package:flacer/widgets/progress_indicator_info.dart';
import 'package:flutter/material.dart';

class CpuCard extends StatefulWidget {
  const CpuCard({super.key});

  @override
  State<CpuCard> createState() => _CpuCardState();
}

class _CpuCardState extends State<CpuCard> {
  int cpuUsagePercentage = 0;
  final int coreCount = CpuInfo.coreCount;

  // All the memory values are in KB (convert it to MB using ~/ 1024)
  void setCpuValues() {
    cpuUsagePercentage = (CpuInfo.processUsage) ~/ 1;
  }

  @override
  void initState() {
    // Setting the memory values on the first run
    setState(() {
      setCpuValues();
    });

    // Updating the memory values every 500 milliseconds
    Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;

      setState(() {
        setCpuValues();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleMd = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
    final headlineMd = Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
    final captionMd = Theme.of(context).textTheme.bodyMedium;

    return Card(
      elevation: 2,
      child: ProgressIndicatorInfo(
        header: Text('CPU', style: titleMd),
        value: cpuUsagePercentage / 100,
        child: Column(
          children: [
            AnimatedCount(
              count: cpuUsagePercentage,
              suffix: "%",
              style: headlineMd,
            ),
            Opacity(
              opacity: .5,
              child: Text("$coreCount Cores", style: captionMd),
            ),
          ],
        ),
      ),
    );
  }
}
