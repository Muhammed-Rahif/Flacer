import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SystemCleanerPage extends StatelessWidget {
  const SystemCleanerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('System Cleaner')));
  }
}
