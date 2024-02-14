import 'package:flacer/widgets/dashboard/cpu_card.dart';
import 'package:flacer/widgets/dashboard/disk_card.dart';
import 'package:flacer/widgets/dashboard/memory_card.dart';
import 'package:flacer/widgets/dashboard/network_monitor_card.dart';
import 'package:flacer/widgets/dashboard/system_info_card.dart';
import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
      appBar: YaruWindowTitleBar(title: Text('Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(fit: FlexFit.tight, child: CpuCard()),
                  Flexible(fit: FlexFit.tight, child: MemoryCard()),
                  Flexible(fit: FlexFit.tight, child: DiskCard()),
                ],
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: SystemInfoCard()),
                  Flexible(child: NetworkMonitorCard()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
