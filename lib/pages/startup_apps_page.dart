import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class StartupAppsPage extends StatelessWidget {
  const StartupAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('Startup Apps')));
  }
}
