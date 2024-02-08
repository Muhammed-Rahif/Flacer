import 'dart:async';

import 'package:flacer/core/memory_info.dart';
import 'package:flacer/widgets/animated_count.dart';
import 'package:flacer/widgets/progress_indicator_info.dart';
import 'package:flutter/material.dart';

class MemoryCard extends StatefulWidget {
  const MemoryCard({super.key});

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  int cached = 0;
  int memoryTotal = 0;
  int buffer = 0;
  int memoryFree = 0;
  int memoryUsagePercentage = 0;
  int actualMemoryUsed = 0;

/* https://access.redhat.com/solutions/406773
 *
 * https://stackoverflow.com/questions/41224738/
 *   Total used memory = MemTotal - MemFree
 *   Non cache/buffer memory (green) = Total used memory - (Buffers + Cached memory)
 *   Buffers (blue) = Buffers
 *   Cached memory (yellow) = Cached + SReclaimable - Shmem
 *   Swap = SwapTotal - SwapFree
 * 
 * 
 *  Therefore:
 *  cached = (cached + sreclaimable - shmem);
 *  memUsed = (memTotal - (memFree + buffers + cached));
 *  swapUsed = (swapTotal - swapFree);
*/

  // All the memory values are in KB (convert it to MB using ~/ 1024)
  void setMemoryValues() {
    cached = MemoryInfo.cached ~/ 1024;
    memoryTotal = MemoryInfo.memoryTotal ~/ 1024;
    buffer = MemoryInfo.buffers ~/ 1024;
    memoryFree = MemoryInfo.memoryFree ~/ 1024;
    memoryUsagePercentage =
        ((actualMemoryUsed / (MemoryInfo.memoryTotal ~/ 1024)) * 100).toInt();
    actualMemoryUsed = (MemoryInfo.memoryTotal -
            (MemoryInfo.memoryFree + MemoryInfo.buffers + MemoryInfo.cached)) ~/
        1024;
  }

  @override
  void initState() {
    // Setting the memory values on the first run
    setState(() {
      setMemoryValues();
    });

    // Updating the memory values every 200 milliseconds
    Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!mounted) return;

      setState(() {
        setMemoryValues();
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
    final usageOutOfGB = 'GB/${(memoryTotal / 1024).toStringAsFixed(1)}GB';

    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        child: ProgressIndicatorInfo(
          header: Text('MEMORY', style: titleMd),
          value: memoryUsagePercentage / 100,
          child: Column(
            children: [
              AnimatedCount(
                count: memoryUsagePercentage,
                suffix: "%",
                style: headlineMd,
              ),
              AnimatedCount(
                count: (actualMemoryUsed / 1024),
                suffix: usageOutOfGB,
                style: captionMd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
