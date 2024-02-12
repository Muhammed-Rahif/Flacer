import 'dart:async';

import 'package:flacer/core/disk_info.dart';
import 'package:flacer/widgets/animated_count.dart';
import 'package:flacer/widgets/progress_indicator_info.dart';
import 'package:flutter/material.dart';

class DiskCard extends StatefulWidget {
  const DiskCard({super.key});

  @override
  State<DiskCard> createState() => _DiskCardState();
}

class _DiskCardState extends State<DiskCard> {
  int totalDiskSpace = 0;
  int usedDiskSpace = 0;
  int availableDiskSpace = 0;
  int diskUsagePercentage = 0;

  // All the memory values are in KB (convert it to GB using ~/ 1024 two times)
  void setDiskValues() async {
    totalDiskSpace = DiskInfo.totalDiskSpace ~/ 1024 ~/ 1024;
    usedDiskSpace = DiskInfo.usedDiskSpace ~/ 1024 ~/ 1024;
    availableDiskSpace = DiskInfo.availableDiskSpace ~/ 1024 ~/ 1024;
    diskUsagePercentage = (usedDiskSpace / totalDiskSpace * 100).round();
  }

  @override
  void initState() {
    super.initState();

    // Setting the memory values on the first run
    setState(() {
      setDiskValues();
    });

    // Updating the memory values every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;

      setState(() {
        setDiskValues();
      });
    });
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
    final diskInfo = '${usedDiskSpace}GB/${totalDiskSpace}GB';

    return Card(
      elevation: 2,
      child: ProgressIndicatorInfo(
        header: Text('DISK', style: titleMd),
        value: diskUsagePercentage / 100,
        child: Column(
          children: [
            AnimatedCount(
              count: diskUsagePercentage,
              suffix: '%',
              style: headlineMd,
            ),
            Opacity(
              opacity: .5,
              child: AnimatedCount(
                count: usedDiskSpace,
                suffix: 'GB/${totalDiskSpace}GB',
                style: captionMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
