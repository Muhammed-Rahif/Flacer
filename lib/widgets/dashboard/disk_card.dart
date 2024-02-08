import 'dart:async';

import 'package:flacer/widgets/animated_count.dart';
import 'package:flacer/widgets/progress_indicator_info.dart';
import 'package:flutter/material.dart';

class DiskCard extends StatefulWidget {
  const DiskCard({super.key});

  @override
  State<DiskCard> createState() => _DiskCardState();
}

class _DiskCardState extends State<DiskCard> {
  int cpuUsagePercentage = 0;

  // All the memory values are in KB (convert it to MB using ~/ 1024)
  void setCpuValues() {
    // cpuUsagePercentage = (CpuInfo.processUsage).toInt();
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
        header: Text('DISK', style: titleMd),
        value: cpuUsagePercentage / 100,
        child: Column(
          children: [
            AnimatedCount(
              count: cpuUsagePercentage,
              suffix: '%',
              style: headlineMd,
            ),
            Opacity(
              opacity: .5,
              child: Text('53GB/128GB', style: captionMd),
            ),
          ],
        ),
      ),
    );
  }
}
