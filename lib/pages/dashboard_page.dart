import 'package:flacer/widgets/dashboard/cpu_card.dart';
import 'package:flacer/widgets/dashboard/disk_card.dart';
import 'package:flacer/widgets/dashboard/memory_card.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: const YaruWindowTitleBar(title: Text('Dashboard')),
      body: Column(
        children: [
          const Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Flexible(fit: FlexFit.tight, child: CpuCard()),
                  Flexible(fit: FlexFit.tight, child: MemoryCard()),
                  Flexible(fit: FlexFit.tight, child: DiskCard()),
                ],
              ),
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
