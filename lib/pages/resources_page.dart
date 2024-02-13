import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('Resources')));
  }
}
