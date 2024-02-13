import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class GnomeSettingsPage extends StatelessWidget {
  const GnomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('Gnome Settings')));
  }
}
