import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('Services')));
  }
}
