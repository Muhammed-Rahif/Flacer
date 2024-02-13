import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class APTRepositoryManagerPage extends StatelessWidget {
  const APTRepositoryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const YaruDetailPage(
        appBar: YaruWindowTitleBar(title: Text('APT Repository Manager')));
  }
}
