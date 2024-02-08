import 'package:flacer/widgets/dashboard/memory_card.dart';
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
  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: const YaruWindowTitleBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                const Flexible(fit: FlexFit.tight, child: MemoryCard()),
                Flexible(
                  fit: FlexFit.tight,
                  child: ProgressIndicatorInfo(
                    header: Text(
                      'CPU',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    value: 0.2,
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
                    value: 0.2,
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
