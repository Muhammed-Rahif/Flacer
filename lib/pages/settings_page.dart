import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('Settings')));
  }
}
