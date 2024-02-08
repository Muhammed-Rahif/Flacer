import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flacer/core/memory_info.dart';
import 'package:flacer/widgets/animated_count.dart';
import 'package:flacer/widgets/progress_indicator_info.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double memoryUsagePercentage = 0.0;

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      final memoryUsed = MemoryInfo.getMemoryUsed();
      final memoryTotal = MemoryInfo.getMemoryTotal();

      setState(() {
        memoryUsagePercentage = memoryUsed / memoryTotal;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: const YaruWindowTitleBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    header: Text(
                      'MEMORY',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    value: memoryUsagePercentage,
                    child: AnimatedCount(
                      count: memoryUsagePercentage,
                      suffix: "%",
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    header: Text(
                      'CPU',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    value: memoryUsagePercentage,
                    child: const Text('6GB/12GB'),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    header: Text(
                      'DISK',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    value: memoryUsagePercentage,
                    child: const Text('53GB/128GB'),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Flexible(child: Container(color: YaruColors.lubuntuBlue)),
                Flexible(child: Container(color: YaruColors.sage)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
