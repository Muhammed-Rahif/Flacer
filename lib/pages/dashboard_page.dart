import 'dart:async';
import 'dart:math';

import 'package:flacer/core/memory_info.dart';
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
      // final memoryUsed = MemoryInfo.getMemoryUsed();
      // final memoryTotal = MemoryInfo.getMemoryTotal();

      setState(() {
        // memoryUsagePercentage = memoryUsed / memoryTotal;
        memoryUsagePercentage = Random().nextDouble();
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
                    textCenter: "Memory Used",
                    textBottom: memoryUsagePercentage.toStringAsFixed(2),
                    value: memoryUsagePercentage,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    textCenter: "Memory Used",
                    textBottom: memoryUsagePercentage.toStringAsFixed(2),
                    value: memoryUsagePercentage,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    textCenter: "Memory Used",
                    textBottom: memoryUsagePercentage.toStringAsFixed(2),
                    value: memoryUsagePercentage,
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
